
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
private _foundBuildings = [];
private _units = units _group;

{
	if (count ([_x] call BIS_fnc_buildingPositions) > count _units) then {_foundBuildings pushback _x;};
} foreach (nearestObjects [_leader, ["House", "Building"], 50]);

//Exit if no compatible buildings found
if (_foundBuildings isEqualTo []) exitWith {false};

private _buildingPositions = [_foundBuildings select 0] call BIS_fnc_buildingPositions;

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
			};
			
			// If move times out or unit dies, skip.
			if 
			(
				(_unit distance _buildingPos < 1.3)
			) then
			{
				_unit disableAI "PATH";
				waitUntil 
				{
					sleep 10; 
					!((_group call VCM_fnc_CheckSituation) isEqualTo "LGARRISON") && 
					{
						if (leader _unit isEqualTo _unit && {_t + 150 > time}) then 
						{
							_group call VCM_fnc_UnGarrisonL;
						};
					}
				};
			};
			
		};
		private _rmv = _buildingPositions findIf {_buildingPos isEqualTo _x};
		_buildingPositions deleteAt _rmv;
	};
} foreach _units;

true