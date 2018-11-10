private ["_UnitSide"];
_UnitSide = side (group _this);

_Array1 = [];
{
	private _TargetSide = side _x;
	if (!([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) && {!(_x in (units (group _this)))}) then {_Array1 pushback _x;};
} forEach allUnits;
_Array1