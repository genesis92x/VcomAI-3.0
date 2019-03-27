/*
	Author: Freddo

	Description:
		Function for telling a group to leave a temporarily garrisoned structure

	Parameter(s):
		0: GROUP

	Returns:
		NOTHING
*/

private _grp = _this;

[_grp, "READY"] call VCM_fnc_SetSituation; 

{
	_x enableAI "PATH";
} forEach units _grp;

if VCM_DEBUG then {systemChat format ["VCOM: %1 UN-L-GARRISONING BUILDING", _grp]};