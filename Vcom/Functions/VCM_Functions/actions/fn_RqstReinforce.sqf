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

if (!(_group call VCM_fnc_GroupHasRadio) || _group getVariable ["VCM_TOUGHSQUAD", false]) exitWith {_rtrn};

// Calculate enemy forces value
private _knownEnemyG = ([_leader, 500, false] call VCM_fnc_KnownEnemyGroupArray);
private _enemyValue = 0;
{
	_enemyValue = _enemyValue + (_x call VCM_fnc_GroupValue);
}forEach _knownEnemyG;

// Add a bit of +- inaccuracy
_enemyValue = (_enemyValue * (0.75 + random 0.5));

// Calculate friendly forces value in vincinity
private _knownFriendlyG = ([_leader, false, 500] call VCM_fnc_FriendlyGroupArray);
private _friendlyValue = 0;
{
	_friendlyValue = _friendlyValue + (_x call VCM_fnc_GroupValue);
}forEach _knownFriendlyG;

// Friendly forces are superior to enemies
if ((_friendlyValue * 1.25) > _enemyValue) exitWith {_rtrn};

if VCM_DEBUG then {systemChat format ["VCOM: %1 calling for support", _group]};

// Find eligible groups
private _targetValue = (_enemyValue - (_friendlyValue * 1.25));
private _eligibleSquads = [];
private _eligibleSquadsValue = 0;
{
	if (_eligibleSquadsValue > _targetValue) exitWith {};
	if (_x call VCM_fnc_CanReinforce) then
	{
		_eligibleSquadsValue = (_eligibleSquadsValue + (_x call VCM_fnc_GroupValue));
		_eligibleSquads pushBack _x;
	};
} forEach ([_leader, true, VCM_WARNDIST] call VCM_fnc_FriendlyGroupArray);

if (count _eligibleSquads isEqualTo 0) exitWith {_rtrn};

//Create waypoints
{
	if !(_x call VCM_fnc_CheckSituation isEqualTo "REINFORCE") then {
		private _leader = leader _x;
		if VCM_DEBUG then {systemChat format ["VCOM: %1 moving to reinforce %2", _x, _group]};
		private _wp = (_x addWaypoint [position _leader, 100]);
		_wp setWaypointSpeed "FULL";
		if (behaviour _leader isEqualTo "SAFE") then {_x setBehaviour "AWARE"};
		[_x, "REINFORCE"] call VCM_fnc_SetSituation;
	};
}forEach _eligibleSquads;
_rtrn = true;
_rtrn