//Function for generating waypoints.
params ["_Leader"];

private _Group = group _Leader;
if (_Group getVariable ["VCM_NOFLANK",false]) exitWith {};

//Lets define types of attack we can do.
private _WayPointType = selectRandom ["Assault","High","Low","Retreat","Flank","FlankL"];

private _NearestEnemy = _leader findNearestEnemy _leader;
if (isNull _NearestEnemy) then
{
	_NearestEnemy = _leader call VCM_fnc_ClstEmy;	
};

if (isNil "_NearestEnemy" || _NearestEnemy isEqualTo [0,0,0]) exitWith {};
if ((vehicle _NearestEnemy) isKindOf "Air") exitWith {};

_Group setBehaviour "COMBAT";
//If they don't know about the enemy position, then just exit the function
private _Knows = _Group knowsAbout _NearestEnemy;
if (_Knows < 2) exitwith 
{
	sleep 10;
	[_Leader] spawn VCM_fnc_FlankMove;
};


if ((count (waypoints _Group)) >= 3) exitWith {};
//If first waypoint is DESTROY, DO NOT change waypoints.
private _index = currentWaypoint _Group;
private _WType = waypointType [_Group,_index];
if (_WType isEqualTo "DESTROY" || _WType isEqualTo "SAD" || _WType isEqualTo "SCRIPTED") exitWith {};

while {(count (waypoints _Group)) > 1} do
{
 deleteWaypoint ((waypoints _Group) select 0);
 sleep 0.25;
};

switch (_WayPointType) do {
    case "Assault": 
		{
			private _waypoint0 = _group addwaypoint [(getpos _NearestEnemy),0];
			_waypoint0 setwaypointtype "MOVE";
			_waypoint0 setWaypointSpeed "FULL";
			_group setCurrentWaypoint [_group,(_waypoint0 select 1)];			
			private _waypoint0 = _group addwaypoint [(getpos _NearestEnemy),0];
			_waypoint0 setwaypointtype "MOVE";			
			_waypoint0 setWaypointSpeed "FULL";
		};
    case "High": 
		{
			private _HighP = ([_Leader,500,50,false] call VCM_fnc_Heights) select 0 select 1;
			private _FinalP = [[[_HighP, 50]],["water"]] call BIS_fnc_randomPos;
			_FinalP set [2,0];
			private _waypoint0 = _group addwaypoint [_FinalP,0];
			_waypoint0 setwaypointtype "MOVE";
			_waypoint0 setWaypointSpeed "FULL";
			_group setCurrentWaypoint [_group,(_waypoint0 select 1)];			
			private _waypoint0 = _group addwaypoint [_FinalP,0];
			_waypoint0 setwaypointtype "MOVE";	
			_waypoint0 setWaypointSpeed "FULL";
		}; 
    case "Low": 
		{
			private _HighP = ([_Leader,500,50,true] call VCM_fnc_Heights) select 0 select 1;
			private _FinalP = [[[_HighP, 50]],["water"]] call BIS_fnc_randomPos;
			_FinalP set [2,0];
			private _waypoint0 = _group addwaypoint [_FinalP,0];
			_waypoint0 setwaypointtype "MOVE";
			_waypoint0 setWaypointSpeed "FULL";
			_group setCurrentWaypoint [_group,(_waypoint0 select 1)];			
			private _waypoint0 = _group addwaypoint [_FinalP,0];
			_waypoint0 setwaypointtype "MOVE";	
_waypoint0 setWaypointSpeed "FULL";			
		}; 
    case "Retreat": 
		{
			private _MovePosition = [_NearestEnemy,(_NearestEnemy distance2D _leader),([_NearestEnemy, _leader] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
			private _FinalP = [[[_MovePosition, 50]],["water"]] call BIS_fnc_randomPos;
			_FinalP set [2,0];
			private _waypoint0 = _group addwaypoint [_FinalP,0];
			_waypoint0 setwaypointtype "MOVE";
			_waypoint0 setWaypointSpeed "FULL";
			_group setCurrentWaypoint [_group,(_waypoint0 select 1)];			
			private _waypoint0 = _group addwaypoint [_FinalP,0];
			_waypoint0 setwaypointtype "MOVE";	
			_waypoint0 setWaypointSpeed "FULL";
		}; 
    case "Flank": 
		{
			private _myEnemyPos = getpos _NearestEnemy;
			private _rnd = random 100;
			private _dist = (_rnd + 100);
			private _dir = random 360;
			private _positions = [(_myEnemyPos select 0) + (sin _dir) * _dist, (_myEnemyPos select 1) + (cos _dir) * _dist, 0];
			private _myPlaces = selectBestPlaces [_myEnemyPos, 250,"((6*hills + 2*forest + 4*houses + 2*meadow) - sea + (2*trees)) - (1000*deadbody)", 100, 5];
			if (_myPlaces isEqualTo []) then {_myPlaces = [_positions];};
			private _RandomArray = _myPlaces call BIS_fnc_selectrandom;
			private _RandomLocation = _RandomArray select 0;
			_RandomLocation set [2,0];
			private _FinalP = [[[_RandomLocation, 50]],["water"]] call BIS_fnc_randomPos;
			_FinalP set [2,0];
			_waypoint0 = _group addwaypoint [_FinalP,0];	
			_waypoint0 setWaypointSpeed "FULL";
			_group setCurrentWaypoint [_group,(_waypoint0 select 1)];
			_waypoint0 = _group addwaypoint [_myEnemyPos,0];	
			_waypoint0 setWaypointSpeed "FULL";			
		}; 
    case "FlankL": 
		{
			private _myEnemyPos = getpos _NearestEnemy;
			private _rnd = random 100;
			private _dist = (_rnd + 100);
			private _dir = random 360;
			private _LeaderPos = getpos _Leader;
			private _positions = [(_myEnemyPos select 0) + (sin _dir) * _dist, (_myEnemyPos select 1) + (cos _dir) * _dist, 0];
			private _positionsL = [(_LeaderPos select 0) + (sin _dir) * _dist, (_LeaderPos select 1) + (cos _dir) * _dist, 0];
			private _myPlaces = selectBestPlaces [_myEnemyPos, 250,"((6*hills + 2*forest + 4*houses + 2*meadow) - sea + (2*trees)) - (1000*deadbody)", 100, 5];
			private _myPlacesL = selectBestPlaces [_LeaderPos, 250,"((6*hills + 2*forest + 4*houses + 2*meadow) - sea + (2*trees)) - (1000*deadbody)", 100, 5];
			if (_myPlaces isEqualTo []) then {_myPlaces = [_positions];};
			if (_myPlacesL isEqualTo []) then {_myPlaces = [_positionsL];};
			private _RandomArray = _myPlaces call BIS_fnc_selectrandom;
			private _RandomArray2 = _myPlacesL call BIS_fnc_selectrandom;
			private _RandomLocation = _RandomArray select 0;
			private _RandomLocationL = _RandomArray2 select 0;
			_RandomLocation set [2,0];
			_RandomLocationL set [2,0];
			private _FinalP = [[[_RandomLocationL, 50]],["water"]] call BIS_fnc_randomPos;
			private _FinalP2 = [[[_RandomLocation, 50]],["water"]] call BIS_fnc_randomPos;
			_FinalP set [2,0];
			_FinalP2 set [2,0];
			_waypoint0 = _group addwaypoint [_FinalP,0];	
			_waypoint0 setWaypointSpeed "FULL";			
			_waypoint0 = _group addwaypoint [_FinalP2,0];	
			_waypoint0 setWaypointSpeed "FULL";
			_group setCurrentWaypoint [_group,(_waypoint0 select 1)];
			_waypoint0 = _group addwaypoint [_myEnemyPos,0];	
			_waypoint0 setWaypointSpeed "FULL";			
		}; 
};