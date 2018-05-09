//Function for telling all AI to temporarily garrison a structure. The AI will leave it shortly after.

private _Unit = (leader _this);
private _nBuildingLst = nearestObjects [_Unit, ["House", "Building"], 50];
private _nBuilding = [0,0,0];
private _BuildingPositions = [];

{
	if (count ([_x] call BIS_fnc_buildingPositions) > 3) then {_BuildingPositions pushback _x;};
} foreach _nBuildingLst;


private _TempA = [selectRandom _BuildingPositions] call BIS_fnc_buildingPositions;
private _GroupUnits = units _this;
if (count _TempA > 0) then
{
	{
		private _Foot = isNull objectParent _x;
		if (_Foot) then
		{
			private _BuildingLocation = selectRandom _TempA;
			_x doMove _BuildingLocation;
			[_x,_BuildingLocation] spawn 
			{
				params ["_unit","_BuildingLocation"];
				if (isNil "_BuildingLocation") exitWith {};
				while {(alive _unit) && {_unit distance _BuildingLocation < 1.3}} do
				{
					sleep 3;
					_unit doMove _BuildingLocation;
				};
				_unit disableAI "PATH";
				sleep 120;
				if (alive _unit) then
				{
					_unit enableAI "PATH";
				};
			};
			private _RMV = _TempA findIf {_BuildingLocation isEqualTo _x};
			_TempA deleteAt _RMV;
		};
	} foreach _GroupUnits;
};