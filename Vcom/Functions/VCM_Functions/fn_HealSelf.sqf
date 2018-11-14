
/*
	Author: Freddo

	Description:
		Makes a unit heal itself.

	Parameter(s):
		0: OBJECT - Unit

	Returns:
		BOOLEAN - If unit able to treat self: TRUE, else FALSE
*/

private "_rtrn";

if ("FirstAidKit" in items _this) then 
{
	_this action ["HealSoldierSelf", _this];
	if VCM_DEBUG then {systemChat format ["%1 healing self", _this]};
	_rtrn = true;
} else 
{
	_rtrn = false;
};

_rtrn