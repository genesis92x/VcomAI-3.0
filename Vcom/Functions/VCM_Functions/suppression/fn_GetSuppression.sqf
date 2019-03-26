/*
	Author: Freddo

	Description:
		Gets units slowSuppression value.

	Parameter(s):
		OBJECT - Unit to set

	Returns:
		NUMBER - Slow Suppression value
*/

private _unit = _this;
private _fsm = _unit getVariable "VCMSUPPRESSION";
private _rtrn = -1;
if (isNil "_fsm" || {completedFSM _fsm}) exitWith {_rtrn};

_rtrn = _fsm getFSMVariable ["_slowSuppression", -1];

_rtrn