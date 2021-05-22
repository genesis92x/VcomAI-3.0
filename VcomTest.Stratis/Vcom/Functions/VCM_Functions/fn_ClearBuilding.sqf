
/*
	Author: Genesis

	Description:
		Orders group to clear building

	Parameter(s):
		0: GROUP - Clearing group
		1: OBJECT - Enemy to clear out

	Returns:
		STRING
*/

params ["_Squad","_enemy"];

private _nBuildingLst = nearestObjects [_enemy, ["House", "Building"], 25,true];

if (count _nBuildingLst < 1) exitWith {};


private _Building = _nBuildingLst#0;

_Squad setCombatMode "BLUE";

private _BXIndex = 0;

private _PositionArray = [];

if ([_Building] call BIS_fnc_isBuildingEnterable) then
{

	private _SquadFSM = _Squad getvariable "VCOM_FSMH";
	_SquadFSM setFSMVariable ["_ActivelyClearing",true];
	
	private _KeepRunning = true;
	while {_KeepRunning} do
	{
		private _StackPos = _Building buildingExit _BXIndex;
		_BXIndex = _BXIndex + 1;
		if (_StackPos isEqualTo [0,0,0]) then
		{
			_KeepRunning = false;
		}
		else
		{
			_PositionArray pushback _StackPos;
		};
	};
	
	
	//Take our best guess at where the doors are.
	private _DoorA = [];
	private _JustPositions = [];
	
	private _SelectionNames = (selectionNames _Building);
	{
		if (["door",_x] call BIS_fnc_inString) then
		{
			private _doorPos = _Building selectionPosition _x;
			private _WorldPos = (_Building modelToWorld _doorPos);
			private _Door = (_x + "_rot");
			_DoorA pushBack [(_WorldPos#2),_Door,_WorldPos];
		};
	} foreach _SelectionNames;
	
	//We have to figure out the average height of the doors.
	_DoorA sort true;
	private _DefaultHeight = (_DoorA#0)#0;

	{
		_DoorA set [_foreachindex,[((_x#0)-_DefaultHeight),(_x#1),(_x#2)]];
	} foreach _DoorA;


	{
		if (_x#0 < 1.5) then
		{
			_JustPositions pushBack (_x#2);
		};
	} foreach _DoorA;

	//Let's collect all the building exits
	private _BuildingExits = [];
	private _FindingExits = true;
	private _ExitCount = 0;
	while {_FindingExits} do
	{
		private _BuildingExitPos = _Building buildingExit _ExitCount;
		_ExitCount = _ExitCount + 1;
		if !(_BuildingExitPos isEqualTo [0,0,0]) then
		{
			_BuildingExits pushback _BuildingExitPos;
		}
		else
		{
			_FindingExits = false;
		};
	};
	
	{
		private _OutsideDist = [_BuildingExits,_x,true,"Test3"] call VCM_fnc_ClstObj;
		if (_OutsideDist distance2D _x > 5) then
		{
			_JustPositions = _JustPositions - [_x];
		};
	} foreach _JustPositions;
	
	//Order the 1st unit to go to the correct position
	private _AliveUnits = (units _Squad select {alive _x});	

	//Find the nearest position, this is going to be ground floor door
	private _Clst1STPos = [_JustPositions,(_AliveUnits#0),true,"Test3"] call VCM_fnc_ClstObj;
	_Clst1STPos = _Clst1STPos getpos [2,(_building getdir _Clst1STPos)];
	private _OGUnit = (_AliveUnits#0);
	_OGUnit setCombatBehaviour "SAFE"; 
	_OGUnit setUnitCombatMode "BLUE";	
	[_OGUnit,_Clst1STPos,1.5,60,-1] spawn VCM_fnc_ForceMoveFSM;
	
	
	_AliveUnits = _AliveUnits - [_OGUnit];
	{
		_Clst1STPos = _Clst1STPos getpos [2,((getdir _building)-90)];
		_x setCombatBehaviour "SAFE"; 
		_x setUnitCombatMode "BLUE";	
		[_x,_Clst1STPos,1.5,60,-1] spawn VCM_fnc_ForceMoveFSM;			
	} foreach _AliveUnits;
	

	private _AllStopped = false;
	
	sleep 15;
	private _TimeOut = time + 60;
	waituntil 
	{
		private _PplMoving = [];
		{
			if (_x distance2D _Clst1STPos < 5) then
			{
				_PplMoving pushback _x;
			};
		} foreach _AliveUnits;
		
		if (count _PplMoving == (count _AliveUnits)) then
		{
			_AllStopped = true;
		};
		
		(_AllStopped || (count (units _Squad select {alive _x}) < 1) || time > _TimeOut)
	};
	
	
	private _AllBPositions = [_building] call BIS_fnc_buildingPositions;
	private _ClstEnemyPosition = [_AllBPositions,_enemy,true,"ClearBuilding"] call VCM_fnc_ClstObj;

	_AliveUnits pushback _OGUnit;
	
	{
		[_x,false] spawn VCM_fnc_ForceGrenadeFire;
	} foreach _AliveUnits;
	
	sleep 10;
	_OGUnit playactionnow "gesturePoint";

	{
		_x setCombatBehaviour "AWARE"; 
		_x setUnitCombatMode "GREEN";
		_x forcespeed -1;
		dostop _x;
		_x domove (getposATL _enemy);
		_x moveto (getposATL _enemy);
		sleep 0.5;
	} foreach _AliveUnits;

	sleep 30;
	_SquadFSM setFSMVariable ["_ActivelyClearing",false];
	
};
