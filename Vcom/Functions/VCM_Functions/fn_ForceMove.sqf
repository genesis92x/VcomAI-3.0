//If we use the vanilla cover finding, we don't have to calcuate forced cover positions for the AI to move to. However, we can "force" them to move in the general direction of their active waypoint.
params ["_leader","_MoveDist"];
private _Group = (group _leader);
private _Units = (units _Group) select {alive _x};
private _NearestEnemy = _leader findNearestEnemy _leader;
if (isNull _NearestEnemy) then
{
	_NearestEnemy = _leader call VCM_fnc_ClstEmy;	
};


private _curwp = currentWaypoint _Group;
private _wPos = waypointPosition [_Group,_curwp];
private _Dir = _Wpos;
if (_WPos isEqualTo [0,0,0]) then
{
	_wPos = (getpos _leader);
	_Dir = _NearestEnemy;
};

private _MovePosition = [_leader,_MoveDist,([_leader, _Dir] call BIS_fnc_dirTo)] call BIS_fnc_relPos;

{
	if (isNull objectParent _x) then
	{
		[_x,_MovePosition] spawn
		{
			params ["_Unit","_MovePos"];
			sleep (1 + (random 10));
			dostop _Unit;
			_Unit domove _MovePos;
		};		
	};
} foreach _Units;
