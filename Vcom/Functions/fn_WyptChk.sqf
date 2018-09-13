//This will tell our scripts if certain waypoints are set or not
//_WaypointCheck = _group call VCOMAI_Waypointcheck;
_GroupToInspect = _this;

_WaypointsToIncriminate = [];

_index = currentWaypoint _GroupToInspect;
_WaypointIs = waypointType [_GroupToInspect,_index];
{
	if (_WaypointIs isEqualTo _x) then {_WaypointsToIncriminate pushback _x};
} foreach ["HOLD","GUARD","UNLOAD","LOAD","TR UNLOAD","SENTRY","DESTROY"];



_WaypointsToIncriminate

