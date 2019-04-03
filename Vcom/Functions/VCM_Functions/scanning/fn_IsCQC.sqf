/*
	Author: Freddo

	Description:
		Checks if group is in a CQC situation

	Parameter(s):
		GROUP - Group to check

	Returns:
		BOOLEAN
*/

private _group = _this;
private _side = side _group;
private _leader = leader _group;

// Exit if group contains only vehicles
if ((units _group) findIf {isNull objectParent _x} isEqualTo -1) exitWith {false};

_rtrn = (allUnits findIf {_leader knowsAbout _x > 1.4 && {side _x getFriend _side < 0.6} && {_x distance2D _leader < 100}} != -1);

_rtrn