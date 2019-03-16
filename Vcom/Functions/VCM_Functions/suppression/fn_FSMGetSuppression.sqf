/*
	Author: Freddo

	Description:
		Gets the current group suppression from FSM

	Parameter(s):
		GROUP - Group to check

	Returns:
		NUMBER - Groups current suppression level
*/

private _group = _this;
private _rtrn = 0;

private _fsm = (_group getVariable "VCM_SQUADFSM");
if (!isNil "_fsm" && {typeName _fsm != "SCRIPT"}) then 
{
	_rtrn = _fsm getFSMVariable ["_suppression", 0];
};
_rtrn