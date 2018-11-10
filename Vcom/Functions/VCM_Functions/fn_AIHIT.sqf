//Function that executes when AI are hit.
private _Unit = _this select 0;
if !(isNull objectParent _Unit) exitWith {};

//Lay down
_Unit setUnitPos "DOWN";_Unit spawn {sleep 30; _this setUnitPos "AUTO";};

if (VCM_RAGDOLL && {VCM_RAGDOLLCHC > (random 100)}) then
{
	_unit setUnconscious true;
	_unit spawn {sleep 2;_this setUnconscious false;};
};
