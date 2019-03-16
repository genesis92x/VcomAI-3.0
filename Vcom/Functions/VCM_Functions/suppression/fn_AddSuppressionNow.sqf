/*
	Author: Freddo

	Description:
		Sets a units current suppression, and also forces it to perform suppression routines immediately.

	Parameter(s):
		0: OBJECT - Unit to set
		1: NUMBER - Suppression to add, can be negative

	Returns:
		NUMBER - New suppression level
*/

params ["_unit", "_toAdd"];

private _newSuppression = ((getSuppression _unit + _toAdd) min 1);

_unit setSuppression _newSuppression;
private _fsm = _unit getVariable "VCOMSUPPRESSION";

if !(isNil "_fsm") then
{
	_fsm setFSMVariable ["_exitNow", true]; // Skips usual 1 second timer and instead runs immediately
};

_newSuppression