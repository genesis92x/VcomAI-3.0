//Function for finding the closest enemy to the passed unit 
//_this
private _UnitSide = (side _this);
private _A1 = [];
{
	private _TargetSide = side _x;
	if ([_UnitSide, _TargetSide] call BIS_fnc_sideIsEnemy) then {_A1 pushback _x;};
} forEach allUnits;

private _Rtrn = [_A1,_this,true,"1"] call VCM_fnc_ClstObj;
if (isNil "_Rtrn") then {_Rtrn = [0,0,0]};

_Rtrn