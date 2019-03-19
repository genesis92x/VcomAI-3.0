
/*
	Author: Freddo

	Description:
		Makes a unit heal itself.

	Parameter(s):
		0: OBJECT - Unit

	Returns:
		BOOLEAN - If unit able to treat self: TRUE, else FALSE
*/

private _rtrn = false;

if (alive _this && {"FirstAidKit" in items _this} && {{_x > 0.25} count (getAllHitPointsDamage _this select 2) != 0}) then 
{
	_this action ["HealSoldierSelf", _this];
	if VCM_DEBUG then {systemChat format ["VCOM: %1 healing self", _this]};
	_rtrn = true;
};

_rtrn