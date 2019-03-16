/*
	Author: Freddo

	Description:
		Sets current situation/task of the unit

	Parameter(s):
		0: GROUP - Group to set the situation of
		1: STRING - Situation to set

	Returns:
		STRING
*/

params ["_grp", "_newSituation"];

private _fsm = _grp getVariable "VCM_SQUADFSM";
if !(isNil "_fsm") then 
{
	_fsm setFSMVariable ["_situation", _newSituation];
};