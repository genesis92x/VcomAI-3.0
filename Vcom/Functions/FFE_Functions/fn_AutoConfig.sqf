private ["_vh","_typeVh","_mags","_prim","_rare","_sec","_smoke","_illum","_maxHit","_ammo","_ammoC","_actHit","_subM","_mags0","_illumChosen","_smokeChosen","_rareChosen","_secChosen","_hit","_lc","_sim","_subM","_arr"];
	
params ["_allArty"];
	
{
	_vh = _x;
	
	if not (_vh getVariable ["RydFFE_CheckedOut",false]) then
	{
		_vh setVariable ["RydFFE_CheckedOut",true];
		_typeVh = toLower (typeOf _vh);
		
		if not (_typeVh in _allArty) then	
		{
			_mags = getArtilleryAmmo [_vh];
			
			if ((count _mags) > 0) then 
			{
				_prim = "";
				_rare = "";
				_sec = "";
				_smoke = "";
				_illum = "";
				
				_maxHit = 10;
				
				{
					_ammo = getText (configfile >> "CfgMagazines" >> _x >> "ammo");
					_ammoC = configfile >> "CfgAmmo" >> _ammo;
					
					_actHit = getNumber (_ammoC >> "indirectHitRange");
					_subM = toLower (getText (_ammoC >> "submunitionAmmo"));
					
					if (_actHit <= 10) then
					{
						if not (_subM isEqualTo "") then
						{
							_ammoC = configfile >> "CfgAmmo" >> _subM;
							_actHit = getNumber (_ammoC >> "indirectHitRange")
						}
					};
					
					if ((_actHit > _maxHit) and {_actHit < 100}) then
					{
						_maxHit = _actHit;
						_prim = _x
					}
				}
				foreach _mags;
				
				_mags = _mags - [_prim];
				_mags0 = +_mags;
				_illumChosen = false;
				_smokeChosen = false;
				_rareChosen = false;
				_secChosen = false;
				
				{
					_ammo = getText (configfile >> "CfgMagazines" >> _x >> "ammo");
					_ammoC = configfile >> "CfgAmmo" >> _ammo;
					
					_hit = getNumber (_ammoC >> "indirectHit");
					_lc = _ammoC >> "lightColor";
					_sim = toLower (getText (_ammoC >> "simulation"));
					_subM = toLower (getText (_ammoC >> "submunitionAmmo"));
					
					if (_hit <= 10) then
					{
						if not (_subM isEqualTo "") then
						{
							_ammoC = configfile >> "CfgAmmo" >> _subM;
							_hit = getNumber (_ammoC >> "indirectHit")
						}
					};

					switch (true) do
					{
						case ((isArray _lc) and {not (_illumChosen)}) : 
						{
							_illum = _x;
							_mags = _mags - [_x];
							_illumChosen = true
						};
					
					case ((_hit <= 10) and {(_subM isEqualTo "smokeshellarty") and {not (_smokeChosen)}}) : 
						{
							_smoke = _x;
							_mags = _mags - [_x];
							_smokeChosen = true
						};
					
					case ((_sim isEqualTo "shotsubmunitions") and {not (_rareChosen)}) : 
						{
							_rare = _x;
							_mags = _mags - [_x];
							_rareChosen = true
						};
					
					case ((_hit > 10) and {not ((_secChosen) or {(_rare == _x)})})  : 
						{
							_sec = _x;
							_mags = _mags - [_x];
							_secChosen = true
						}
					}
				}
				foreach _mags0;
				
				if (_sec isEqualTo "") then
				{
					_maxHit = 10;
					
					{
						_ammo = getText (configfile >> "CfgMagazines" >> _x >> "ammo");
						_ammoC = configfile >> "CfgAmmo" >> _ammo;
						_subAmmo = _ammoC >> "subMunitionAmmo";
						
						if ((isText _subAmmo) and {not ((getText _subAmmo) isEqualTo "")}) then
						{
							_ammoC = configfile >> "CfgAmmo" >> _subAmmo;
						};
					
						_actHit = getNumber (_ammoC >> "indirectHit");
					
						if (_actHit > _maxHit) then
						{
							_maxHit = _actHit;
							_sec = _x
						}
					}
					foreach _mags;
				};
				
				_arr = [_prim,_rare,_sec,_smoke,_illum];
				
				if (({_x isEqualTo ""} count _arr) < 5) then
				{
					RydFFE_Other pushBack [[_typeVh],_arr];
					_allArty pushBack _typeVh
				}
			}
		}
	}
}
foreach vehicles;

RydFFE_AllArty = _allArty;

_allArty