/*
	Author: Freddo

	Description:
		Checks if a group is eligible to reinforce other units.

	Parameter(s):
		GROUP - Group to check.

	Returns:
		BOOLEAN
*/

private _group = _this;
private _units = units _group;
private _rtrn = true;

if 
(
	(_group call VCM_fnc_GroupHasRadio) ||
	behaviour leader _group == "CARELESS" || 
	_group getVariable ["VCM_NORESCUE", false]
) exitWith {_rtrn = false; _rtrn};

switch (_group call VCM_fnc_CheckSituation) do
{
	case "READY": {};
	case "REINFORCE": {};
	default {_rtrn = false};
};

if _rtrn then
{
	{
		if 
		(
			!(canMove _x) ||
			{_x in VCM_ARTYLST} ||
			{vehicle _x isKindOf "StaticWeapon"}
		) exitWith {_rtrn = false; _rtrn};
	} forEach _units;
};
_rtrn