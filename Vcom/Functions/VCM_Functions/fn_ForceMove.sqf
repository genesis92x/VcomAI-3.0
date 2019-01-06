
/*
	Author: Genesis

	Description:
		Forces AI to move towards enemies, failing that move towards waypoint.

	Parameter(s):
		0: OBJECT - Group leader to get moving
		1 (Optional): NUMBER - Distance to move

	Returns:
		NOTHING
*/

params ["_leader","_moveDist"];
private ["_movePosition"];

if (isNil "_moveDist") then {private _moveDist = 100};

private _grp = (group _leader);
private _units = (units _grp) select {alive _x};
private _nearestEnemy = _leader findNearestEnemy _leader;

if (isNull _nearestEnemy) then
{
	_nearestEnemy = _leader call VCM_fnc_ClstEmy;	
};


private _wPos = waypointPosition [_grp, (currentWaypoint _grp)];
private _dir = _wPos;
if (_wPos isEqualTo [0,0,0]) then
{
	_wPos = (getpos _leader);
	_dir = _nearestEnemy;
};

if !((_wPos distance2D _dir) < _moveDist) then
{
	_movePosition = [_leader,_moveDist,([_leader, _dir] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
}
else
{
	_movePosition = _wPos; //Don't move further than necessary
};
if ((_wPos distance2D _leader) > 20 && {(_wPos distance2D _leader) < 500}) then 
{
	if (VCM_Debug) then {systemchat format ["VCOM: %1 MOVING UP", _grp];};
	{
		if (isNull objectParent _x) then
		{
			[_x,_movePosition] spawn
			{
				params ["_unit","_movePos"];
				sleep (1 + (random 10));
				dostop _unit;
				_unit forceSpeed -1;
				_unit domove _movePos;
			};
		};
	} foreach _units;
};