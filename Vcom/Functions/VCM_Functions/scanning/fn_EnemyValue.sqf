/*
	Author: Freddo

	Description:
		Returns total value of nearby enemy groups

	Parameter(s):
		0: OBJECT - Groups friendly to this unit will be added to return array.
		1: BOOLEAN - OPTIONAL, Check only for known groups : Default True
		2: NUMBER - OPTIONAL, Search range : Default 300

	Returns:
		NUMBER
		
	Note:
		todo: insert values
*/

params ["_unit", ["_knownOnly", true], ["_searchDist", 300]];
private _knownEnemyG = [];

if _knownOnly then
{
	_knownEnemyG = ([_unit, _searchDist, false] call VCM_fnc_KnownEnemyGroupArray);
}
else
{
	_knownEnemyG = ([_unit, _searchDist, false] call VCM_fnc_EnemyGroupArray);
};

private _enemyValue = 0;
{
	_enemyValue = _enemyValue + (_x call VCM_fnc_GroupValue);
}forEach _knownEnemyG;

_enemyValue
