/*
	Author: Freddo

	Description:
		Makes unit request support.

	Parameter(s):
		GROUP - Group that is requesting support.

	Returns:
		BOOLEAN
*/

private _group = _this;
private _leader = leader _group;
private _rtrn = false;

if !(side _leader in [west, east, resistance]) exitWith {_rtrn};
if (!(_group call VCM_fnc_GroupHasRadio) || _group getVariable ["VCM_TOUGHSQUAD", false]) exitWith {_rtrn};

private _enemyValue = (([_leader, true, 300] call VCM_fnc_EnemyValue) * (random 0.5 + 0.9));
private _friendlyValue = [_leader, 300] call VCM_fnc_FriendlyValue;

if (_friendlyValue > _enemyValue * 1.25) exitWith {_rtrn};

if VCM_DEBUG then {systemChat format ["VCOM: %1 calling for support", _group]};

// Find eligible groups
private _targetValue = ((_enemyValue * 1.25) - _friendlyValue);
private _eligibleSquads = [];
private _eligibleSquadsValue = 0;
{
	scopeName "loop";
	if (_eligibleSquadsValue > _targetValue) then {breakOut "loop"};
	if (_x call VCM_fnc_CanReinforce) then
	{
		_eligibleSquadsValue = (_eligibleSquadsValue + (_x call VCM_fnc_GroupValue));
		_eligibleSquads pushBack _x;
	};
} forEach (([_leader, true, VCM_WARNDIST] call VCM_fnc_FriendlyGroupArray) - [_group]);

if (count _eligibleSquads isEqualTo 0) exitWith {_rtrn};

//Create waypoints
{
	if !((_x call VCM_fnc_CheckSituation) isEqualTo "REINFORCE") then
	{
		private _reinfLeader = leader _x;
		if VCM_DEBUG then {systemChat format ["VCOM: %1 moving to reinforce %2", _x, _group]};
		private _wp = (_x addWaypoint [position _leader, 100]);
		_wp setWaypointSpeed "FULL";
		_wp setWaypointStatements 
		[
			"true", 
			"if (group this call VCM_fnc_CheckSituation isEqualTo 'REINFORCE') then {[group this, 'READY'] call VCM_fnc_SetSituation}"
		];
		if (behaviour _reinfLeader isEqualTo "SAFE") then {_x setBehaviour "AWARE"};
		[_x, "REINFORCE"] call VCM_fnc_SetSituation;
	}
}forEach _eligibleSquads;
_rtrn = true;
_rtrn