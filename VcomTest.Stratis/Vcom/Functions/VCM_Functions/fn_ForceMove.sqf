
/*
	Author: Genesis
	Description:
		Forces AI to move towards enemies, failing that move towards waypoint.

	Parameter(s):
		0: OBJECT - Group leader to get moving
		1 (Optional): NUMBER - Distance to move

	Returns:
		NOTHING
*/
params ["_SquadLeader"];

private _Squad = (group _SquadLeader);

//_Squad setbehaviour "SAFE";
_Squad setCombatMode "BLUE";

private _Units = (units _Squad);

//Let's see if any of the units have fired recently, if not, get them moving without taking cover.
private _Engaged = false;

{
	if (((_x getvariable ["VCM_FTH",-60]) + 10) > time) exitwith {_Engaged = true;};
} foreach _Units;


//If we are engaged, then let's look for cover.
if (_Engaged) then
{
	private _NearbyCoverArray = [_SquadLeader,30] call VCM_fnc_CoverDetect;


	_NearbyCoverArray params ["_CenterUnitPos","_CoverObjects","_WPPos"];


	private _SavedCoverArray = _CoverObjects;
	private _NoCover = false;

	//Not much cover?
	if (count _CoverObjects < ((count _Units)/2)) then
	{
		_NoCover = true;
	};
	
	private _ClstEnemy = _SquadLeader call VCM_fnc_ClstEmy;
	{
	
		if (count _CoverObjects < 1 && {!(_NoCover)}) then
		{
			_CoverObjects = _SavedCoverArray;
		};
		
		_x setCombatBehaviour "SAFE"; 
		_x setUnitCombatMode "BLUE";
		
		
		//Find closest cover		
		private _Go2Pos = [0,0,0];
		if !(_NoCover) then
		{
			private _ClstCover = [_CoverObjects,_ClstEnemy,true,"Test2"] call VCM_fnc_ClstObj;		
			_CoverObjects = _CoverObjects - [_ClstCover];
			_Go2Pos = [_ClstCover,_x] call VCM_fnc_BoxNrst;
			if (VCM_Debug) then
			{
				systemchat "Cover found!";
			};
		}
		else
		{
			_Go2Pos = _x getpos [(10 + (random 10)),(_x getdir _WPPos)];
			if (VCM_Debug) then
			{
				systemchat "No Cover found!";
			};			
		};
		
		[_x,_Go2Pos,1.5,60] spawn VCM_fnc_ForceMoveFSM;

		
	} foreach (units _Squad);
}
else
{
			if (VCM_Debug) then
			{
				systemchat "Not engaged, let's move!";
			};
	//Let's make sure everyone can move.
	{	
		_x forcespeed -1;		
	} foreach (units _Squad);
};