
/*
	Author: Freddo

	Description:
		Makes a unit heal itself.

	Parameter(s):
		0: OBJECT - Unit

	Returns:
		BOOLEAN - If unit able to treat self: TRUE, else FALSE
*/

if ("FirstAidKit" in items _this && damage _this < 0.75) then 
{
	_this action ["HealSoldierSelf", _this];
	if VCM_DEBUG then {systemChat format ["%1 healing self", _this]};
} else {if true exitwith {false}};

true