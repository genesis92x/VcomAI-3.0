
private ["_UnitSide","_Array1"];
_UnitSide = side (group _this);

_Array1 = [];
{
	_TargetSide = side _x;


	if ([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) then {_Array1 pushback _x;};

} forEach allUnits;
_Array1