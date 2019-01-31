/*
	Author: Freddo

	Description:
		Returns current situation/task of the unit

	Parameter(s):
		0: GROUP - Group to check the situation of

	Returns:
		STRING
*/

private _grp = _this;
private _rtrn = "BUSY";

private _fsm = _grp getVariable "VCM_SQUADFSM";
if !(isNil "_fsm") then 
{
	_rtrn = _fsm getFSMVariable "_situation";
};

_rtrn