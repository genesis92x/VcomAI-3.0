
/*
	Author: Genesis, overhauled by Freddo

	Description:
		Function for telling a group to temporarily garrison a structure. The group will leave it shortly after.

	Parameter(s):
		0: GROUP

	Returns:
		NOTHING
*/

private _group = _this;
private _leader = (leader _group);
private _units = units _group;

private _nearbyBuildings = nearestObjects [_leader, ["House", "Building"], 50];
private _foundBuilding = _nearbyBuildings findIf {count ([_x] call BIS_fnc_buildingPositions) > count _units};

//Exit if no compatible buildings found
if (_foundBuilding isEqualTo -1) exitWith {false};

private _buildingPositions = [_nearbyBuildings select _foundBuilding] call BIS_fnc_buildingPositions;

if VCM_DEBUG then {systemChat format ["VCOM: %1 PERFORMING LIGHT GARRISON", _group]};
{
	if (isNull objectParent _x) then
	{
		private _buildingPos = selectRandom _buildingPositions;
		_x doMove _buildingPos;
		[_x,_buildingPos] spawn 
		{
			params ["_unit","_buildingPos"];
			private _group = group _unit;
			if (isNil "_buildingPos") exitWith {};
			private _t = time; // Break out of loop if time passes certain amount
			// Move to building position
			while 
			{
				(alive _unit) && 
				{_t + 60 > time} && 
				{_unit distance _buildingPos > 1.3} &&
				{(_group call VCM_fnc_CheckSituation) isEqualTo "LGARRISON"}
			} do
			{
				sleep 3;
				_unit doMove _buildingPos;
				if (_unit distance _buildingPos < 1.3) exitWith {_unit disableAI "PATH"};
			};
			
		};
		_buildingPositions deleteAt (_buildingPositions findIf {_buildingPos isEqualTo _x});
	};
} foreach _units;

true