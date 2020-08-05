
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

params ["_group","_enemy"];

private _nBuildingLst = nearestObjects [_enemy, ["House", "Building"], 25,true];
if (count _nBuildingLst < 1) exitWith {};

private _buildingPositions = [];


{
	if (count ([_x] call BIS_fnc_buildingPositions) > 3) then {_buildingPositions pushback _x;};
} foreach _nBuildingLst;




if (count _buildingPositions < 1) exitWith {};
private _finalSel = [_buildingPositions,_enemy,true,"Clear0"] call VCM_fnc_ClstObj; 

//Check to see if the enemy is within the bounds of the building, and not just outside of it
private _corners = _finalSel call BIS_fnc_boundingBoxCorner; //[[_x2, _y2, 0], [_x2, _y1, 0], [_x1, _y1, 0], [_x1, _y2, 0]]
_corners params ["_topright","_bottomright","_bottomleft","_Bottomright"];

private _unitPosition = getposATL _enemy; //[x,y,z]

if ((_unitPosition#0 > _bottomleft#0 && {_unitPosition#0 < _bottomright#0}) && (_unitPosition#1 > _bottomleft#1 && {_unitPosition#1 < _topright#1})) then
{
	//Unit is inside the hitbox of a building. Or close enough.
	private _tempA = _finalSel call BIS_fnc_buildingPositions;
	private _tempB = _tempA;
	
	//Filter down the closest positions
	private _acceptableRange = _unitPosition#2;
	{
		if ((_x#2) < (_acceptableRange - 1) || (_x#2) > (_acceptableRange + 1)) then
		{
			_tempA deleteAt _forEachIndex;
		};
	
	} foreach _tempA;
	
	if (_tempA isEqualTo []) then {_tempA = _tempB;};
	
	private _clstP = [_tempA,_enemy,true,"Clear1"] call VCM_fnc_ClstObj;
	
	{
		_x domove (getposATL _x);
		_x moveto (getposATL _X);
		doStop _x;_x forcespeed -1;
		_x doMove _clstP;
		_x moveTo _clstP;
		_x setDestination [_clstP, "FORMATION PLANNED", true];
	} foreach (units _group);
}; 