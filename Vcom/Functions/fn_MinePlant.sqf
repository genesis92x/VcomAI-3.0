if (VCM_MINECHANCE < (round (random 100))) exitWith {};

private _Unit = _this select 0;
private _MineArray = _this select 1;

private _MineType = _MineArray select 0;

//Let's see if we can place a scripted version of the item.
private _TestName = _MineType + "_scripted";
private _TestMine = _TestName createVehiclelocal [0,0,0];
if !(isNull _TestMine) then
{
	_MineType = _TestName;
};

private _MagazineName = _MineArray select 1;

if (_MineArray isEqualTo []) exitWith {};

_Unit removeMagazine _MagazineName;

//systemchat format ["I %1",_Unit];
private _NearestEnemy = _Unit call VCM_fnc_ClstEmy;
if (_NearestEnemy isEqualTo [] || {isNil "_NearestEnemy"}) exitWith {};

private _mine = "";

if (_NearestEnemy distance2D _Unit < 100) then
{
	//_mine = createMine [_MineType,getposATL _Unit, [], 2];
	private _MPos = _Unit modeltoworld [0,1,0.05];
	_mine = _MineType createVehicle _MPos;
	_mine setDir ([_mine, _NearestEnemy] call BIS_fnc_dirTo);
	_mine setpos _MPos;
	_mine setposATL (getposATL _mine);
	[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["Vcm_PMN",0];
}
else
{
	_NearRoads = _Unit nearRoads 50;
	if (count _NearRoads > 0) then 
	{
		private _ClosestRoad = [_NearRoads,_Unit,true,"2"] call VCM_fnc_ClstObj;
		doStop _Unit;
		_Unit doMove (getpos _ClosestRoad);
		waitUntil {!(alive _Unit) || _Unit distance2D _ClosestRoad < 7};
		private _MPos = _Unit modeltoworld [0,1,0.05];
		_mine = _MineType createVehicle _MPos;
		_mine setDir ([_mine, _NearestEnemy] call BIS_fnc_dirTo);
		_mine setpos _MPos;
		_mine setposATL (getposATL _mine);
		//_mine = createMine [_MineType,getposATL _ClosestRoad, [], 3];
		[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["Vcm_PMN",0];
	}
	else
	{
		//_mine = createMine [_MineType,getposATL _Unit, [], 3];
		private _MPos = _Unit modeltoworld [0,1,0.05];
		_mine = _MineType createVehicle _MPos;
		_mine setDir ([_mine, _NearestEnemy] call BIS_fnc_dirTo);
		_mine setpos _MPos;
		_mine setposATL (getposATL _mine);
		[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["Vcm_PMN",0];
	};
};

_UnitSide = (side _Unit);


if (_mine isEqualTo "") exitWith {};

[_mine,_UnitSide] spawn 
{
	params ["_Mine","_UnitSide"];
	
	private _NotSafe = true;
	_Mine enableSimulationGlobal false;
	while {alive _mine && {_NotSafe}} do 
	{
		private _Array1 = (allUnits select {!(side _x isEqualTo _UnitSide)});
		private _ClosestEnemy = [0,0,0];
		_ClosestEnemy = [_Array1,_Mine,true,"2"] call VCM_fnc_ClstObj;
		if (_ClosestEnemy distance _Mine < 2.5) then {_NotSafe = false;};
		sleep 0.15;	
	};
	_Mine enableSimulationGlobal true;
	_Mine setdamage 1;
};