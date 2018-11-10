//Script used to make AI attach explosives to buildings and bring them down if players garrison them.
params ["_Unit","_SatchelArray"];

private _SatchelObj = _SatchelArray select 0;
private _SatchelMag = _SatchelArray select 1;

//Let's see if we can place a scripted version of the item.
private _TestName = _SatchelObj + "_scripted";
private _TestMine = _TestName createVehiclelocal [0,0,0];
if !(isNull _TestMine) then
{
	_SatchelObj = _TestName;
};



private _Point = _Unit call VCM_fnc_ClstEmy;
if (_Point isEqualTo [] || {isNil "_Point"}) exitWith {};

if ((_Unit distance _Point) < 200) then 
{

	private _vehicle = vehicle _Point;
	
	if (_Point isEqualTo _vehicle) then 
	{

		private _nBuilding = (nearestObjects [_Point, ["House", "Building"], 50]) select 0;
		if (isNil "_nBuilding") exitWith {};
		if ((_nBuilding distance _Point) > 40) exitWith {};	
		[_Unit,_nBuilding,(group _Unit),_SatchelObj,_SatchelMag] spawn 
		{
			params ["_Unit","_nBuilding","_Group","_SatchelObj","_SatchelMag"];
			_Unit disableAI "TARGET";
			_Unit disableAI "AUTOTARGET";
			_Unit disableAI "CHECKVISIBLE";
			_Unit disableAI "COVER";
			_Unit disableAI "AUTOCOMBAT";
			doStop _Unit; _Unit doMove (getPos _nBuilding);
			
			private _Truth = true;
			while {_Truth} do 
			{
				if ((_Unit distance _nBuilding) <= 9) then {_Truth = false;};
				sleep 0.25;
			};

			_Unit removeMagazine _SatchelMag;
			private _mine = _SatchelObj createVehicle (getposATL _Unit);
			_mine setDir ([_mine, _nBuilding] call BIS_fnc_dirTo);
			[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["Vcm_PMN",0];
			 _Unit action ["SetTimer", _Unit, _mine];
			
			private _PlantPosition = getpos _mine;
			private _NotSafe = true;
			private _UnitSide = (side _Unit);
			_Unit doMove (getpos (leader _Group));
			_Unit enableAI "TARGET";
			_Unit enableAI "AUTOTARGET";
			_Unit enableAI "CHECKVISIBLE";
			_Unit enableAI "COVER";
			_Unit enableAI "AUTOCOMBAT";			

			while {_NotSafe} do
			{
				private _Array1 = [];
				{
					_Array1 pushback _x;
				} foreach (allUnits select {(side _x) isEqualTo _UnitSide && (alive _x)});			
				_ClosestFriendly = [_Array1,_PlantPosition,true,"Satch1"] call VCM_fnc_ClstObj;
				if !(isNil "_ClosestFriendly") then
				{
					if (_ClosestFriendly distance2D _PlantPosition > 10) then {_NotSafe = false;};
				}
				else
				{
					_NotSafe = false;
				};
				sleep 5;
			};
			_mine setdamage 1;
			sleep 3;
			_list = _PlantPosition nearObjects ["#crater",5]; 
			if (_list isEqualTo []) then
			{
				deleteVehicle _mine;
				private _mine2 = "SatchelCharge_Remote_Ammo" createVehicle _PlantPosition;
				_mine2 setdamage 1;
			};
			
		};
	};
};