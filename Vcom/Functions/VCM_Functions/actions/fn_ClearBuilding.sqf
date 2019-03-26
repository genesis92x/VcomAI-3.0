
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

private _building = (nearestObject [_enemy, "House"]);

private _buildingPositions = [_building] call BIS_fnc_buildingPositions;

// Not enterable
if (count _buildingPositions < 3) exitWith {};

private _bbr = boundingBoxReal _building; // TODO: Replace 'boundingBoxReal' with '0 BoundingBoxReal' on devbranch
private _p1 = _bbr select 0;
private _p2 = _bbr select 1;
// Check if unit is inside of the closest building
if 
!(
	_enemy inArea 
	[
		getPos _building, 								// Center of building
		(abs ((_p2 select 0) - (_p1 select 0)) / 2),	// Maximum Width / 2
		(abs ((_p2 select 1) - (_p1 select 1)) / 2), 	// Maximum Length / 2
		getDir _building, 								// Building facing
		true											// Is rectangular
	]
) exitWith {};

if VCM_Debug then {systemChat format ["VCOM: %1 clearing out %2", _group, _enemy]};

private _finalPositions = [];
_finalPositions = (_buildingPositions inAreaArray [getPosATL _enemy, 3, 3, 0, false, 1.5]);

if (_finalPositions isEqualTo []) then 
{
	// Settle for the three closest
	private _temp = [_buildingPositions, [], {_x distance _enemy}] call BIS_fnc_sortBy;
	for "_i" from 0 to 2 do {_finalPositions pushBack (_temp select _i)};
};

{
	doStop _x;
	_x doMove selectRandom _finalPositions;
} foreach (units _group);