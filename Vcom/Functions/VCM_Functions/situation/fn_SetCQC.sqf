/*
	Author: Freddo

	Description:
		Sets current situation as Close Quarters Combat, and spawns scripts to eventually exit it

	Parameter(s):
		0: GROUP - Group to set the situation of
		1: OBJECT - Nearest enemy

	Returns:
		NOTHING
*/
params ["_group", "_nearestEnemy"];
private _units = units _group;
{_x enableAI "AUTOCOMBAT"} forEach _units;

[_group, _nearestEnemy] call VCM_fnc_CQCMovement;

_group spawn //Handle to eventually exit script
{
	params ["_group", "_handle"];
	private _group = _this;
	private _units = units _group;
	while {true} do
	{
		sleep (15 + random 10);
		private _situation = _group call VCM_fnc_CheckSituation;
		private _leader = leader _group;
		if (_units findIf {alive _x} isEqualTo -1 || _situation isEqualTo "BREAKING") exitWith 
		{
			_group enableAttack false; 
			{_x doFollow _leader} forEach _units;
		};
		private _nearestEnemy = _leader findNearestEnemy _leader;
		if (!isNull _nearestEnemy && {_nearestEnemy distance _leader > 120}) exitWith 
		{
			[_group, "READY"] call VCM_fnc_SetSituation;
			_group enableAttack false;
			{
				_x doFollow (leader _group);
				_x disableAI "AUTOCOMBAT";
			} forEach _units;
			_group setSpeedMode "NORMAL";
		};
	}
};