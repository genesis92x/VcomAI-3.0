/*
	Author: Freddo

	Description:
		Creates CQC waypoints depending on the situation.

	Parameter(s):
		0: GROUP - Group to generate waypoints for
		1: OBJECT - Closest enemy

	Returns:
		NOTHING
*/
params ["_group", "_closestEnemy"];
private _leader = leader _group;
if (isNil "_closestEnemy") then 
{
	_closestEnemy = _leader findNearestEnemy _leader;
};

// Zeus placed waypoints
if !((waypoints _group) findIf {_x in VCM_IGNOREWAYPOINTS} isEqualTo -1) exitWith {};
if (_group getVariable ["VCM_NOFLANK", false]) exitWith {};

if (_leader distance _closestEnemy < 120) then 
{ 
	for "_i" from ((count waypoints _group) - 1) to 1 do {deleteWaypoint [_group, _i]};
	
	// Copied from VCM_fnc_RqstReinforce
	// Checks if friendlies outnumber the enemy
	private _knownEnemyG = ([_leader, 200, false] call VCM_fnc_KnownEnemyGroupArray);
	private _enemyValue = 0;
	{
		_enemyValue = _enemyValue + (_x call VCM_fnc_GroupValue);
	}forEach _knownEnemyG;

	// Add a bit of +- inaccuracy
	_enemyValue = (_enemyValue * (0.75 + random 0.5));

	// Calculate friendly forces value in vincinity
	private _knownFriendlyG = ([_leader, false, 200] call VCM_fnc_FriendlyGroupArray);
	private _friendlyValue = 0;
	{
		_friendlyValue = _friendlyValue + (_x call VCM_fnc_GroupValue);
	}forEach _knownFriendlyG;
	
	if ((_friendlyValue * 1.25) > _enemyValue) then
	{
		// Push the advantage
		private _wp = _group addWaypoint [position _closestEnemy, 25];
		_wp setWaypointType "SAD";
		_wp setWaypointSpeed "FULL";
		_wp setWaypointStatements ["this", "[group this] call VCM_fnc_CQCMovement"];
		_group setCurrentWaypoint _wp;
		_group enableAttack true;
	}
	else
	{
		// Fall back
		private _direction = _closestEnemy getDir _leader;
		private _position = position _leader getPos [200, _direction];
		private _wp = _group addWaypoint [_position, 25];
		_wp setWaypointSpeed "FULL";
		_wp setWaypointStatements ["this", "[group this call VCM_fnc_CQCMovement]"];
		_group setCurrentWaypoint _wp;
		_group enableAttack false;
		private _units = units _group;
		{
			// Regroup
			doStop _x;
			_x doFollow _leader;
		} forEach _units;
	};
};