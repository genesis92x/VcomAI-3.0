/*
	Author: Freddo

	Description:
		Returns current situation/task of the unit

	Parameter(s):
		GROUP - Group to check the situation of

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
if (isNil "_rtrn") then {_rtrn = "ERROR"}; //This generally occurs when the FSM has been suddenly stopped
_rtrn