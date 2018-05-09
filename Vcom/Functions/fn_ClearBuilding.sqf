//Function that allows AI to clear a garrisoned building
params ["_Group","_Enemy"];

private _nBuildingLst = nearestObjects [_Enemy, ["House", "Building"], 25];
if (count _nBuildingLst < 1) exitWith {};

private _BuildingPositions = [];

{
	if (count ([_x] call BIS_fnc_buildingPositions) > 3) then {_BuildingPositions pushback _x;};
} foreach _nBuildingLst;

if (count _BuildingPositions < 1) exitWith {};
private _FinalSel = [_BuildingPositions,_Enemy,true,"Clear0"] call VCM_fnc_ClstObj; 
private _TempA = _FinalSel call BIS_fnc_buildingPositions;
private _TempB = _TempA;

//Filter down the closest positions
private _UnitPosition = getposATL _Enemy;
private _AcceptableRange = _UnitPosition select 2;
{
	if ((_x select 2) < (_AcceptableRange - 1) || (_x select 2) > (_AcceptableRange + 1)) then
	{
		_TempA deleteAt _forEachIndex;
	};

} foreach _TempA;

if (_TempA isEqualTo []) then {_TempA = _TempB;};

private _ClstP = [_TempA,_Enemy,true,"Clear1"] call VCM_fnc_ClstObj;

{
	doStop _x;
	_x doMove _ClstP;	
} foreach (units _Group);