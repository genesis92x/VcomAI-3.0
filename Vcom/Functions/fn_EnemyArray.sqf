//This function quickly find the list of all enemy units for a specific side.

private _UnitSide = side (group _this);
private _TargetSide = "";
private _Array1 = [];
{
	_TargetSide = side _x;
	if ([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) then {_Array1 pushback _x;};

} forEach allUnits;
_Array1