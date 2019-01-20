//_bArr = [_tgtPos,RydFFE_ArtG,"SADARM",6,leaderHQ] call RYD_fnc_ArtyMission;
params ["_pos","_arty","_ammoG","_amount","_FO"];
private ["_pos","_arty","_ammoG","_amount","_FO","_gp","_checked","_vh","_tp","_inRange","_pX","_pY","_pZ"];

private _ammo = "";
private _ammoArr = [];

private _hasAmmo = 0;
private _possible = false;
private _battery = [];
private _agp = [];

private _artyAv = [];
private _vehs = 0;
private _allAmmo = 0;

{
	_gp = _x; 
	if not (isNull _gp) then
	{
		if not (_gp getVariable ["RydFFE_BatteryBusy",false]) then
		{
			_hasAmmo = 0;
			_checked = [];
				
			{
				_vh = vehicle _x;
				if not (_vh in _checked) then
				{
					_checked set [(count _checked),_vh];
					
					_tp = toLower (typeOf _vh);
					
					switch (true) do
					{
						case (_tp in RydFFE_Mortar) : 
						{
							switch (_ammoG) do
							{
								case ("HE") : {_ammo = "8Rnd_82mm_Mo_shells"};
								case ("SPECIAL") : {_ammo = "8Rnd_82mm_Mo_shells"};
								case ("SECONDARY") : {_ammo = "8Rnd_82mm_Mo_shells"};
								case ("SMOKE") : {_ammo = "8Rnd_82mm_Mo_Smoke_white"};
								case ("ILLUM") : {_ammo = "8Rnd_82mm_Mo_Flare_white"};
							}
						};
						
						case (_tp in RydFFE_SPMortar) : 
						{
							_side = configfile >> "CfgVehicles" >> _tp >> "side";
							if ((not (isNumber _side)) or {not ((getNumber _side) == 0)}) then
							{
								switch (_ammoG) do
								{
									case ("HE") : {_ammo = "32Rnd_155mm_Mo_shells"};
									case ("SPECIAL") : {_ammo = "2Rnd_155mm_Mo_Cluster"};
									case ("SECONDARY") : {_ammo = "2Rnd_155mm_Mo_guided"};
									case ("SMOKE") : {_ammo = "6Rnd_155mm_Mo_smoke"};
									case ("ILLUM") : {_ammo = ""};
								};
							}
							else
							{
								switch (_ammoG) do
								{
									case ("HE") : {_ammo = "32Rnd_155mm_Mo_shells_O"};
									case ("SPECIAL") : {_ammo = "2Rnd_155mm_Mo_Cluster_O"};
									case ("SECONDARY") : {_ammo = "2Rnd_155mm_Mo_guided_O"};
									case ("SMOKE") : {_ammo = "6Rnd_155mm_Mo_smoke_O"};
									case ("ILLUM") : {_ammo = ""};
								};
							}
						};
						
						case (_tp in RydFFE_Rocket) :
						{
							switch (_ammoG) do
							{
								case ("HE") : {_ammo = "12Rnd_230mm_rockets"};
								case ("SPECIAL") : {_ammo = "12Rnd_230mm_rockets"};
								case ("SECONDARY") : {_ammo = "12Rnd_230mm_rockets"};
								case ("SMOKE") : {_ammo = ""};
								case ("ILLUM") : {_ammo = ""};
							};
						};
						
						default
						{
							if ((count RydFFE_Other) > 0) then
							{
								_arr = [];
								
								{
									if (_tp in (_x select 0)) exitWith {_arr = _x select 1}
								}
								foreach RydFFE_Other;
								
								if ((count _arr) > 0) then
								{
									switch (_ammoG) do
									{
										case ("HE") : {_ammo = _arr select 0};
										case ("SPECIAL") : {_ammo = _arr select 1};
										case ("SECONDARY") : {_ammo = _arr select 2};
										case ("SMOKE") : {_ammo = _arr select 3};
										case ("ILLUM") : {_ammo = _arr select 4};
									}
								}
							}						
						}
					};
					
					_inRange = _pos inRangeOfArtillery [[_vh],_ammo];
					
					if (_inRange) then
					{
						{
							if ((_x select 0) in [_ammo]) then
							{
								_hasAmmo = _hasAmmo + (_x select 1);
								_allAmmo = _allAmmo + (_x select 1);
								_ammoArr set [(count _ammoArr),_ammo];
								_vehs = _vehs + 1
							};
							
							if not (_hasAmmo < _amount) exitWith {};
							if not (_allAmmo < _amount) exitWith {}
						}
						foreach (magazinesAmmo _vh);
					}
				};

				if not (_vehs < _amount) exitWith {}
			}
			foreach (units _gp);

			if (_hasAmmo > 0) then
			{
				_artyAv set [(count _artyAv),_gp];
				_agp set [(count _agp),leader _gp]
			}
		}
	};
	
	if not (_hasAmmo < _amount) exitWith {};
	if not (_allAmmo < _amount) exitWith {}
}
foreach _arty;

if not ((count _artyAv) == 0) then
{
	_battery = _artyAv;
	
	_possible = true;
	
	if (_ammoG in ["ILLUM","SMOKE"]) then
	{
		{
			if not (isNull _x) then
			{
				_x setVariable ["RydFFE_BatteryBusy",true]
			}
		}
		foreach _battery;

		_pX = _pos select 0;
		_pY = _pos select 1;
		_pZ = _pos select 2;

		_pX = _pX + (random 100) - 50;
		_pY = _pY + (random 100) - 50;
		_pZ = _pZ + (random 20) - 10;

		_pos = [_pX,_pY,_pZ];
		//_i = [_pos,(random 1000),"markArty","ColorRed","ICON","mil_dot",_ammoG,"",[0.75,0.75]] call RYD_fnc_Mark;
		[_battery,_pos,_ammoArr,_FO,_amount,_ammoG] spawn
		{
			params ["_battery","_pos","_ammo","_FO","_amount","_ammoG"];

			if (_ammoG == "ILLUM") then 
			{
				[_battery,_pos,_ammo,_amount] call RYD_fnc_CFF_Fire;
			}
			else
			{
				_angle = [_FO,_pos,10] call RYD_fnc_AngTowards;
				_pos2 = [_pos,_angle + 110,200 + (random 100) - 50] call RYD_fnc_PosTowards2D;
				_pos3 = [_pos,_angle - 110,200 + (random 100) - 50] call RYD_fnc_PosTowards2D;
				//_i2 = [_pos2,(random 1000),"markArty","ColorRed","ICON","mil_dot",_ammoG,"",[0.75,0.75]] call RYD_Mark;
				//_i3 = [_pos3,(random 1000),"markArty","ColorRed","ICON","mil_dot",_ammoG,"",[0.75,0.75]] call RYD_Mark;

				{
					[_battery,_x,_ammo,ceil (_amount/3)] call RYD_fnc_CFF_Fire;
					
					_ct = 0;
					waitUntil 
					{
						sleep 0.1;
						_ct = _ct + 0.1;
						_busy = 0; 
						
						{
							if not (isNull _x) then
							{
								_busy = _busy + ({not ((vehicle _x) getVariable ["RydFFE_GunFree",true])} count (units _x))
							};
						}
						foreach _battery;
						
						((_busy == 0) or (_ct > 12))
					};
				}
				foreach [_pos,_pos2,_pos3]
			};
		
			_ct = 0;
			waitUntil 
			{
				sleep 0.1;
				_ct = _ct + 0.1;
				_busy = 0; 
				
				{
					if not (isNull _x) then
					{
						_add = {not ((vehicle _x) getVariable ["RydFFE_GunFree",true])} count (units _x);
						_busy = _busy + _add;
						if (_add == 0) then {_x setVariable ["RydFFE_BatteryBusy",false]}
					};
				}
				foreach _battery;
				
				((_busy == 0) or (_ct > 12))
			};
			
			{
				if not (isNull _x) then
				{
					_x setVariable ["RydFFE_BatteryBusy",false]
				}
			}
			foreach _battery
		}
	}
};

//diag_log format ["AM: %1",[_possible,_battery,_agp,_ammoArr]];

[_possible,_battery,_agp,_ammoArr,_allAmmo]