/*
	Author: Freddo

	Description:
		Return array of all friendly groups.

	Parameter(s):
		0: OBJECT - Groups friendly to this unit will be added to return array.
		1: BOOLEAN - OPTIONAL, Whether to sort by range (sorted in ascending order)
		2: NUMBER - OPTIONAL, Search range

	Returns:
		ARRAY
		
	Note:
		This function sorts by range to group leader.
*/

params ["_unit", "_toSort", "_range"];

if (isNil "_toSort") then {_toSort = false};
if (isNil "_range") then {_range = -1};

private _friendlyArray = [];
private _side = side _unit;
private _group = group _unit;

if _toSort then
{
	private _unsortArray = [];
	{
		if ([side _x, _side] call BIS_fnc_sideIsFriendly && !(_x isEqualTo _group)) then
		{
			_unsortArray pushBack _x;
		};
	} foreach allGroups;
	
	_friendlyArray = [_unsortArray, [], {(leader _x) distance2D _unit}] call BIS_fnc_sortBy;
}
else
{
	{
		if ([side _x, _side] call BIS_fnc_sideIsFriendly && {!(_x isEqualTo _group)} && {0 <= _range && {leader _x distance2D _unit < _range}}) then
		{
			_friendlyArray pushBack _x;
		};
	} foreach allGroups;
};

_friendlyArray