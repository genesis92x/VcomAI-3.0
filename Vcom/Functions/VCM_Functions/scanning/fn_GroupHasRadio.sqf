/*
	Author: Genesis

	Description:
		Checks if group has a radio

	Parameter(s):
		GROUP - Group to check for radios

	Returns:
		BOOLEAN
*/

private _group = _this;
private _units = units _group;
private _rtrn = false;

private _rtrn = !((_units findIf {_x call VCM_fnc_HasRadio}) == -1;

_rtrn