//Function for squads being able to warn their closest teammates about combat.
params ["_Unit","_Killer"];

private _UnitGroup = (group _Unit);

//If the squad is a TOUGH SQUAD, we just exit here.
if (_UnitGroup getVariable ["VCM_TOUGHSQUAD",false] || _UnitGroup getVariable ["Vcm_Disable",false] || _UnitGroup getVariable ["VCM_NOFLANK",false]) exitWith {};

//If the squad is already calling for help, don't do anything further.
if (_UnitGroup getVariable ["VCM_RQSTHELP",false]) exitWith {};
_UnitGroup setVariable ["VCM_RQSTHELP",true];

_UnitGroup spawn {sleep 300;_this setVariable ["VCM_RQSTHELP",false];};


private _TrgtPos = getpos _Killer;

//If this gets attached to a player, then exit before doing anything
if (isPlayer _Unit) exitWith {};

//Check to see if this unit should be moving to support others or not
//Check to see if this unit is garrisoned. If so, don't do anything
//Check to see if unit has radio. If the unit does not have a radio, then it will not move to support
private _CheckStatus = assignedItems _Unit;

if ((_Unit getVariable ["Vcm_Disable",false]) || {!("ItemRadio" in _CheckStatus)}) exitWith {};

private _ArrayOrg = _Unit call VCM_fnc_FriendlyArray;
_ArrayOrg = _ArrayOrg - VCM_ARTYLST;
//Remove players 
{if (isPlayer _x) then {_ArrayOrg deleteAt _foreachIndex;};} foreach _ArrayOrg;

private _Array2 = _Killer call VCM_fnc_FriendlyArray;
_Array2 = _Array2 - VCM_ARTYLST;
{
	if (_x distance _Killer > 501) then {_Array2 = _Array2 - [_x];};
} foreach _Array2;



sleep VCM_WARNDELAY;

private _EnemyCount = count _Array2;
private _RespondCount = 0;
private _aliveCount = {alive _x} count (units _UnitGroup);
if (_aliveCount > 0) then
{
	{
		if (_RespondCount < _EnemyCount) then
		{

			private _CheckStatus2 = assignedItems _x;
			

			if (!(isNil "_CheckStatus2") && {!(_x getVariable ["Vcm_Disable",false])} && {!(_x getVariable ["VCM_NOFLANK",false])} && {!(_x getVariable ["VCM_NORESCUE",false])} && {!(_x getVariable ["VCM_MOVE2SUP",false])} && {"ItemRadio" in _CheckStatus2}) then 
			{


						private _group	= group _x;
						if ((count (waypoints _group)) < 2) then 
						{

							private _WaypointCheck = _group call VCM_fnc_WyptChk;
							if (count _WaypointCheck < 1) then 
							{
							

								if ((_x distance2D _Unit) <= VCM_WARNDIST) then 
								{

											_x setbehaviour "AWARE";
											(group _x) setVariable ["VCM_MOVE2SUP",true];
											if (!(vehicle _x isEqualTo _x)) then
											{
													_RespondCount = _RespondCount + count (crew (vehicle _x));
													private _Driver = (driver (vehicle _x));
													//systemchat format ["_RespondCountDRIVER %1 GROUP: %2",[_EnemyCount,_RespondCount],(group _x)];
													_waypoint2 = (group _Driver) addwaypoint[_TrgtPos,15,150];
													_waypoint2 setwaypointtype "MOVE";
													_waypoint2 setWaypointSpeed "NORMAL";
													_waypoint2 setWaypointBehaviour "AWARE";												
											}
											else
											{
													_RespondCount = _RespondCount + (count (units (group _x)));
													//systemchat format ["_RespondCount %1 GROUP: %2",[_EnemyCount,_RespondCount],(group _x)];
													_waypoint2 = (group _x) addwaypoint[_TrgtPos,15,150];
													_waypoint2 setwaypointtype "MOVE";
													_waypoint2 setWaypointSpeed "NORMAL";
													_waypoint2 setWaypointBehaviour "AWARE";
														private _Driver = Driver (vehicle _x);
														_waypoint2 = (group _Driver) addwaypoint[_TrgtPos,15,150];
														_waypoint2 setwaypointtype "MOVE";
														_waypoint2 setWaypointSpeed "NORMAL";
														_waypoint2 setWaypointBehaviour "AWARE";											
											};


											(group _x) spawn 
											{
												sleep 300;
												_this setVariable ["VCM_MOVE2SUP",false];
											};
								
								};
							};
	
						};
						
						


	
			
			};	
		};
	} foreach _ArrayOrg;	
};
