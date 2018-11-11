params ["_battery", "_pos", "_ammo", "_amount"];
private ["_guns","_vh","_mags","_amount0","_eta","_alive","_available","_perGun","_rest","_aGuns","_perGun1","_shots","_toFire","_rest0","_bad","_ammoC","_ws","_gun"];

_eta = -1;

_guns = [];

{
	if not (isNull _x) then
	{
		{
			_vh = vehicle _x;
			if not (_vh in _guns) then
			{
				_shots = 0;
				
				{
					if ((_x select 0) in _ammo) then
					{
						_shots = _shots + (_x select 1)
					}
				}
				foreach (magazinesAmmo _vh);
					
				_vh setVariable ["RydFFE_ShotsToFire",0];
				_vh setVariable ["RydFFE_MyShots",_shots];
					
				if (_shots > 0) then
				{
					_guns set [(count _guns),_vh]
				}
			}
		}
		foreach (units _x)
	}
}
foreach _battery;
	
_aGuns = count _guns;
	
if (_aGuns < 1) exitWith {-1};
if (_amount < 1) exitWith {-1};
	
_perGun = floor (_amount/_aGuns);
_rest = _amount - (_perGun * _aGuns);
			
{
	_shots = _x getVariable ["RydFFE_MyShots",0];
	if not (_shots > _perGun) then
	{
		_x setVariable ["RydFFE_ShotsToFire",_shots];
		_amount = _amount - _shots;
		_rest = _rest + (_perGun - _shots);
		_x setVariable ["RydFFE_MyShots",0]
	}
	else
	{				
		_x setVariable ["RydFFE_ShotsToFire",_perGun];
		_x setVariable ["RydFFE_MyShots",_shots - _perGun]
	};
}
foreach _guns;

_bad = false;

while {(_rest > 0)} do
{
	_rest0 = _rest;
	
	{
		if (_rest < 1) exitWith {};
		_shots = _x getVariable ["RydFFE_MyShots",0];
			
		if (_shots > 0) then
		{
			_toFire = _x getVariable ["RydFFE_ShotsToFire",0];

			_rest = _rest - 1;
				
			_x setVariable ["RydFFE_ShotsToFire",_toFire + 1];
			_x setVariable ["RydFFE_MyShots",_shots - 1]
		}		
	}
	foreach _guns;
		
	if (not (_rest0 > _rest) and (_rest > 0)) exitWith {_bad = true}
};
		
if (_bad) exitWith {-1};
		
{
	if not (isNull _x) then
	{
		_vh = vehicle _x;
		
		if ((_vh getVariable ["RydFFE_ShotsToFire",0]) > 0) then
		{
			_mags = getArtilleryAmmo [_vh];
			
			_ammoC = (magazines _vh) select 0;
			
			{
				if (_x in _ammo) exitWith
				{
					_ammoC = _x
				}
			}
			foreach (magazines _vh);	
			
			if (_ammoC in _mags) then
			{
				_amount = _amount - 1;
				
				_newEta = _vh getArtilleryETA [_pos,_ammoC];
				
				if (not (isNil "_newEta") and {((_newEta < _eta) or (_eta < 0))}) then
				{
					_eta = _newEta
				};

				[_vh,_pos,_ammoC] spawn
				{
					params ["_vh", "_pos", "_ammo"];
						
					if (_pos inRangeOfArtillery [[_vh],_ammo]) then
					{
						if (_ammo in (getArtilleryAmmo [_vh])) then
						{
							_vh setVariable ["RydFFE_GunFree",false];
							
							if not ((currentMagazine _vh) in [_ammo]) then
							{
								_vh loadMagazine [[0],currentWeapon _vh,_ammo]; 
								
								_ct = time;
								
								waitUntil
								{
									sleep 0.1;
									_ws = weaponState [_vh,[0]];
									_ws = _ws select 3;
									((_ws in [_ammo]) or ((time - _ct) > 30))
								};
								
								sleep ((getNumber (configFile >> "cfgWeapons" >> (currentWeapon _vh) >> "magazineReloadTime")) + 0.1)
							};
							
							if (_pos inRangeOfArtillery [[_vh],_ammo]) then
							{
								if (_ammo in (getArtilleryAmmo [_vh])) then
								{																				
									if (((toLower (typeOf _vh)) in ["uss_iowa_turret_c","uss_iowa_turret_b","uss_iowa_turret_a"]) or {RydFFE_IowaMode}) then
									{
										{
											_gun = vehicle _x;
											if not ((toLower (typeOf _gun)) isEqualTo "uss_iowa_battleship") then
											{
												_gun doArtilleryFire [_pos, _ammo,(_vh getVariable ["RydFFE_ShotsToFire",1])]
											}
										}
										foreach (units (group _vh))
									}
									else
									{
										_vh doArtilleryFire [_pos, _ammo,(_vh getVariable ["RydFFE_ShotsToFire",1])]
									};
										
									_ct = time;
										
									waitUntil
									{
										sleep 0.1;
										(not ((_vh getVariable ["RydFFE_ShotFired2",0]) < (_vh getVariable ["RydFFE_ShotsToFire",1])) or ((time - _ct) > 15))
									};
										
									_vh setVariable ["RydFFE_ShotFired",true];
									_vh setVariable ["RydFFE_ShotFired2",0];
								};
							};
							
							sleep ((getNumber (configFile >> "cfgWeapons" >> (currentWeapon _vh) >> "reloadTime")) + 0.5);
							
							_vh setVariable ["RydFFE_GunFree",true]
						}
					}
				}
			}
		}
	}
}
foreach _guns;

/*{
	if not (isNull _x) then
	{
		{
			(vehicle _x) setVariable ["RydFFE_GunFree",true]
		}
		foreach (units _x)
	}			
}
foreach _battery;*/

_eta