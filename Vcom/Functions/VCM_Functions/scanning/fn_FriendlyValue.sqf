/*
	Author: Freddo

	Description:
		Returns total value of nearby friendly groups

	Parameter(s):
		0: OBJECT - Groups friendly to this unit will be added to return array.
		1: NUMBER - OPTIONAL, Search range

	Returns:
		NUMBER
		
	Note:
		todo: insert values
*/

params ["_unit", ["_searchDist", 300]];

private _knownFriendlyG = ([_unit, false, _searchDist] call VCM_fnc_FriendlyGroupArray);
private _friendlyValue = 0;
{
	_friendlyValue = _friendlyValue + (_x call VCM_fnc_GroupValue);
}forEach _knownFriendlyG;

_friendlyValue