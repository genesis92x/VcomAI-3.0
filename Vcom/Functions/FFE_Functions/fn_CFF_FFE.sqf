//[_battery,_tgt,_batlead,"SADARM",RydFFE_Friends,RydFFE_Debug] spawn RYD_fnc_CFF_FFE
params ["_battery", "_target", "_batlead", "_Ammo", "_friends", "_Debug", "_ammoG", "_amount"];

private ["_batname","_first","_phaseF","_targlead","_againF","_dispF","_accF","_Rate","_FMType","_againcheck","_Aunit",
"_RydAccF","_TTI","_amount1","_amount2","_template","_targetPos","_X0","_Y0","_X1","_Y1","_X2","_Y2","_Xav","_Yav","_transspeed","_transdir","_Xhd","_Yhd","_impactpos","_safebase","_distance",
"_safe","_safecheck","_gauss1","_gauss09","_gauss04","_gauss2","_distance2","_DdistF","_DdamageF","_DweatherF","_DskillF","_anotherD","_Dreduct","_spawndisp","_dispersion","_disp","_RydAccF",
"_gauss1b","_gauss2b","_AdistF","_AweatherF","_AdamageF","_AskillF","_Areduct","_spotterF","_anotherA","_acc","_finalimpact","_posX","_posY","_i","_dX","_dY","_angle","_dXb","_dYb","_posX2",
"_posY2","_AmmoN","_exDst","_exPX","_exPY","_onRoad","_exPos","_nR","_stRS","_dMin","_dAct","_dSum","_checkedRS","_RSArr","_angle","_rPos","_actRS","_ammocheck","_artyGp","_ammoCount","_dstAct",
"_maxRange","_minRange","_isTaken","_batlead","_alive","_waitFor","_UL","_ammoC","_add","_myFO","_assumedPos","_eta"];	


_myFO = _target getVariable ["RydFFE_MyFO",objNull];
_assumedPos = (getPosATL _target);
if not (isNull _myFO) then
{
	_assumedPos = _myFO getHideFrom _target;
};
		
_markers = [];
	
_battery1 = _battery select 0;

_batLead1 = leader _battery1;

_batname = str _battery1;

//_first = _battery getVariable [("FIRST" + _batname),1];

//_artyGp = group _batlead;

_isTaken = (group _target) getVariable ["CFF_Taken",false];
if ((_isTaken) and (RydFFE_Monogamy)) exitWith 
{
	{
		if not (isNull _x) then
		{
			_x setVariable ["RydFFE_BatteryBusy",false]
		}
	}
	foreach _battery
};

(group _target) setVariable ["CFF_Taken",true];

_phaseF = [1,2];
if ((RydFFE_OnePhase) or ((count RydFFE_FO) == 0) and not (RydFFE_2PhWithoutFO)) then {_phaseF = [1]};

_targlead = vehicle (leader _target);

_waitFor = true;
	
_amount1 = ceil (_amount/6);
_amount2 = _amount - _amount1;

{
	if (isNil ("_myFO")) exitwith {_waitFor = false};
	if (isNull _myFO) exitwith {_waitFor = false};
	if not (alive _myFO) exitwith {_waitFor = false};
	
	if (isNil ("_target")) exitwith {_waitFor = false};
	if (isNull _target) exitwith {_waitFor = false};
	if not (alive _target) exitwith {_waitFor = false};
	
	if (({not (isNull _x)} count _batlead) < 1) exitwith {_waitFor = false};
	if (isNull _battery1) exitWith {_waitFor = false};
	if (({(alive _x)} count _batlead) < 1)  exitwith {_waitFor = false};

	if ((abs (speed _target)) > 50) exitWith {_waitFor = false};
	if ((_assumedPos select 2) > 20)  exitWith {_waitFor = false};
	
	if ((_assumedPos distance [0,0,0]) == 0) exitWith {_waitFor = false};
	
	_againF = 0.85;
	_accF = RydFFE_Acc;

	_againcheck = _battery1 getVariable [("CFF_Trg" + _batname),objNull];
	if not ((str _againcheck) == (str _target)) then {_againF = 1};

	_RydAccF = 1;

	//if (isNil ("RydFFE_Amount")) then {_amount = _this select 7} else {_amount = RydFFE_Amount};
	//if (isNil ("RydFFE_Acc")) then {_accF = 2} else {_accF = RydFFE_Acc};

	//if (_ammoG in ["SPECIAL","SECONDARY"]) then {_amount = ceil (_amount/3)};

	if ((count _phaseF) == 2) then
	{
		if (_x == 1) then
		{
			_amount = _amount1
		}
		else
		{
			_amount = _amount2
		}
	};

	if (_amount == 0) exitwith {_waitFor = false};

	if not (isNull _myFO) then
	{
		_assumedPos = _myFO getHideFrom _target;
	};
	
	if ((_assumedPos distance [0,0,0]) == 0) exitWith {_waitFor = false};

	_targetPosATL = _assumedPos;
	_targetPos = ATLtoASL _assumedPos;
	
	_eta = -1;
	
	{
		{
			_vh = vehicle _x;
			_vhMags = magazines _vh; 
			if (not (_vh isEqualTo _x) and {(count _vhMags) > 0}) then
			{
				_ammoC = _vhMags select 0;
				
				{
					if (_x in _ammo) exitWith
					{
						_ammoC = _x
					}
				}
				foreach _vhMags;
				
				_newEta = _vh getArtilleryETA [_targetPosATL,_ammoC];
				
				if (not (isNil "_newEta") and {((_newEta < _eta) or (_eta < 0))}) then
				{
					_eta = _newEta
				}
			}
		}
		foreach (units _x)
	}
	foreach _battery;
		
	if (_eta == -1) exitWith {_waitFor = false};

	_X0 = (_targetpos select 0);
	_Y0 = (_targetpos select 1);
	
	sleep 10;
	
	if (
		isNil ("_myFO") ||
		{isNull _myFO} ||
		{not (alive _myFO)} ||

		{isNull _target} ||
		{not (alive _target)} ||
	
		{({not (isNull _x)} count _batlead) < 1} ||
		{isNull _battery1} ||
		{({(alive _x)} count _batlead) < 1} ||
		
		{(abs (speed _target)) > 50} ||
		{(_assumedPos select 2) > 20}
	) exitWith {_waitFor = false};

	if not (isNull _myFO) then
	{
		_assumedPos = _myFO getHideFrom _target;
	};
	
	if (_assumedPos isEqualTo [0,0,0]) exitWith {_waitFor = false};

	_targetPos = ATLtoASL _assumedPos;
	
	_X1 = (_targetpos select 0);
	_Y1 = (_targetpos select 1);
	
	sleep 10;
	
	if 
	(
		isNil "_myFO" ||
		{isNull _myFO} ||
		{not (alive _myFO)} ||
	
		{isNull _target} ||
		{not (alive _target)} ||
	
		{({not (isNull _x)} count _batlead) < 1} ||
		{isNull _battery1} ||
		{({(alive _x)} count _batlead) < 1} ||
		
		{(abs (speed _target)) > 50} ||
		{(_assumedPos select 2) > 20}
	) exitWith {_waitFor = false};

	if not (isNull _myFO) then
	{
		_assumedPos = _myFO getHideFrom _target;
	};
	
	if ((_assumedPos distance [0,0,0]) == 0) exitWith {_waitFor = false};

	_targetPos = ATLtoASL _assumedPos;
		
	_X2 = (_targetpos select 0);
	_Y2 = (_targetpos select 1);

	_onRoad = isOnRoad _targlead;

	_Xav = (_X1+_X2)/2;
	_Yav = (_Y1+_Y2)/2;

	_transspeed = ([_X0,_Y0] distance [_Xav,_Yav])/15;
	_transdir = (_Xav - _X0) atan2 (_Yav - _Y0);
		
	_add = 16/(1 + (_transspeed));

	_Xhd = _transspeed * (sin _transdir) * (_eta + _add);
	_Yhd = _transspeed * (cos _transdir) * (_eta + _add);
	_impactpos = _targetpos;
	_safebase = 100;

	_exPX = (_targetPos select 0) + _Xhd;
	_exPY = (_targetPos select 1) + _Yhd;

	_exPos = [_exPX,_exPY,getTerrainHeightASL [_exPX,_exPY]];
	_exTargetPosATL = ASLtoATL _exPos;
		
	_eta = -1;
		
	{
		{
			_vh = vehicle _x;
			_vhMags = magazines _vh; 
			if (not (_vh isEqualTo _x) and {(count _vhMags) > 0}) then
			{
				_ammoC = _vhMags select 0;
				
				{
					if (_x in _ammo) exitWith
					{
						_ammoC = _x
					}
				}
				foreach _vhMags;
				
				_newEta = _vh getArtilleryETA [_exTargetPosATL,_ammoC];
				
				if (not (isNil "_newEta") and {((_newEta < _eta) or (_eta < 0))}) then
				{
					_eta = _newEta
				}
			}
		}
		foreach (units _x)
	}
	foreach _battery;
	
	if (_eta == -1) exitWith {_waitFor = false};
	
	_Xhd = _transspeed * (sin _transdir) * (_eta + _add);
	_Yhd = _transspeed * (cos _transdir) * (_eta + _add);

	_exPX = (_targetPos select 0) + _Xhd;
	_exPY = (_targetPos select 1) + _Yhd;

	_exPos = [_exPX,_exPY,getTerrainHeightASL [_exPX,_exPY]];

	_exDst = _targetPos distance _exPos;

	if (isNil ("RydFFE_Safe")) then {_safebase = 100} else {_safebase = RydFFE_Safe};

	_safe = _safebase * _RydAccf * (1 + overcast);

	_safecheck = true;

	if not (_onRoad) then
	{
		{
			if (([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x))) < _safe) exitwith 
			{
				_Xhd = _Xhd/2;
				_Yhd = _Yhd/2
			}
		}
		foreach _friends;
		
		{
			if ([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x)) < _safe) exitwith {_safecheck = false};
		}
		foreach _friends;

		if not (_safecheck) then 
		{
			_Xhd = _Xhd/2;
			_Yhd = _Yhd/2;
			_safecheck = true;
			{
				if ([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x)) < _safe) exitwith {_safecheck = false};
			}
			foreach _friends;
			if not (_safecheck) then 
			{
				_Xhd = _Xhd/5;
				_Yhd = _Yhd/5;
				_safecheck = true;
				{
					if ([(_impactpos select 0) + _Xhd, (_impactpos select 1) + _Yhd] distance (vehicle (leader _x)) < _safe) exitwith {_safecheck = false};
				}
				foreach _friends
			}
		};

		_impactpos = [(_targetpos select 0) + _Xhd, (_targetpos select 1) + _Yhd];
	}
	else
	{
		_nR = _targlead nearRoads 30;

		_stRS = _nR select 0;
		_dMin = _stRS distance _exPos;

		{
			_dAct = _x distance _exPos;
			if (_dAct < _dMin) then {_dMin = _dAct;_stRS = _x}
		}
		foreach _nR;

		_dSum = _assumedPos distance _stRS;
		_checkedRS = [_stRS];
		_actRS = _stRS;

		while {_dSum < _exDst} do
		{
			_RSArr = (roadsConnectedTo _actRS) - _checkedRS;
			if ((count _RSArr) == 0) exitWith {};
			_stRS = _RSArr select 0;
			_dMin = _stRS distance _exPos;

			{
				_dAct = _x distance _exPos;
				if (_dAct < _dMin) then {_dMin = _dAct;_stRS = _x}
			}
			foreach _RSArr;

			_dSum = _dSum + (_stRS distance _actRS);

			_actRS = _stRS;

			_checkedRS set [(count _checkedRS),_stRS];
		};

		if (_dSum < _exDst) then
		{
			//if (_transdir < 0) then {_transdir = _transdir + 360};
			_angle = [_targetPos,(getPosASL _stRS),1] call RYD_fnc_AngTowards;
			_impactPos = [(getPosASL _stRS),_angle,(_exDst - _dSum)] call RYD_fnc_PosTowards2D
		}
		else
		{
			_rPos = getPosASL _stRS;
			_impactPos = [_rPos select 0,_rPos select 1]
		};
			
		{
			if ((_impactpos distance (vehicle (leader _x))) < _safe) exitwith 
			{
				_safeCheck = false;
				_impactpos = [((_impactpos select 0) + (_targetPos select 0))/2,((_impactpos select 1) + (_targetPos select 1))/2]
			}
		}
	foreach _friends
	};

	if not (_safeCheck) then
	{
		_safeCheck = true;

		{
			if ((_impactpos distance (vehicle (leader _x))) < _safe) exitwith 
			{
				_safeCheck = false
			}
		}
	foreach _friends
	};

	if not (_safecheck) exitwith {(group _target) setVariable ["CFF_Taken",false];_waitFor = false};

	_distance2 = _impactPos distance (getPosATL (vehicle _batlead1));
	_DweatherF = 1 + overcast;
	_gauss09 = (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) + (random 0.09) +  (random 0.09) + (random 0.09);

	//_gauss1 = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) +  (random 0.1) + (random 0.1);
	//_gauss04 = (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) + (random 0.04) +  (random 0.04) + (random 0.04);
	//_gauss2 = (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) +  (random 0.2) + (random 0.2);
	//_DdistF = (_distance2/10) * (0.1 + _gauss04);
	//_DdamageF = 1 + 0.5 * (damage _batlead1);
	//_DskillF = 2 * (skill _batlead1);
	//_anotherD = 1 + _gauss1;
	//_Dreduct = (1 + _gauss2) + _DskillF;
		 
	//_spawndisp = _dispF * ((_RydAccf * _DdistF * _DdamageF) + (50 * _DweatherF * _anotherD)) / _Dreduct;
	//_dispersion = 10000 * (_spawndisp atan2 _distance2) / 57.3;

	//_disp = _dispersion;
	//if (isNil ("RydFFE_SpawnM")) then {_disp = _dispersion} else {_disp = _spawndisp};

	//[_battery,_disp] call BIS_ARTY_F_SetDispersion;
		
	_RydAccF = 1;

	_gauss1b = (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) + (random 0.1) +  (random 0.1) + (random 0.1);
	_gauss2b = (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) + (random 0.2) +  (random 0.2) + (random 0.2);
	_AdistF = (_distance2/10) * (0.1 + _gauss09);
	_AweatherF = _DweatherF;
	_AdamageF = 1 + 0.1 * (damage (vehicle _batlead1));
	_AskillF = 5 * (_batlead1 skill "aimingAccuracy");
	_Areduct = (1 + _gauss2b) + _AskillF;
	_spotterF = 0.2 + (random 0.2);
	_anotherA = 1 + _gauss1b;
	if not (isNil ("RydFFE_FOAccGain")) then {_spotterF = RydFFE_FOAccGain + (random 0.2)};
	if (((count _phaseF) == 2) and (_x == 1) or ((count _phaseF) == 1)) then {_spotterF = 1};

	_acc = _spotterF * _againF * _accF * ((_AdistF * _AdamageF) + (50 * _AweatherF * _anotherA)) / _Areduct;

	_finalimpact = [(_impactpos select 0) + (random (2 * _acc)) - _acc,(_impactpos select 1) + (random (2 * _acc)) - _acc];

	if not (isNull _myFO) then
	{
		_assumedPos = _myFO getHideFrom _target;
	};

	if (isNull _target) exitwith {_waitFor = false};
	if not (alive _target) exitwith {_waitFor = false};
		
	if (({not (isNull _x)} count _batlead) < 1) exitwith {_waitFor = false};
	if (isNull _battery1) exitWith {_waitFor = false};
	if (({(alive _x)} count _batlead) < 1)  exitwith {_waitFor = false};

	if ((abs (speed _target)) > 50) exitWith {_waitFor = false};
	if ((_assumedPos select 2) > 20) exitWith {_waitFor = false};

	//_dstAct = _impactpos vectorDistance _batlead;
		
	{
		if not (isNull _x) then
		{
			{
				(vehicle _x) setVariable ["RydFFE_ShotFired",false]
			}
			foreach (units _x)
		};
	}
	foreach _battery;

	sleep 0.2;
	_posX = 0;
	_posY = 0;
	
	_distance = _impactPos distance _finalimpact;
	
	(_battery select 0) setVariable ["RydFFE_Break",false];
	
	if (_Debug) then 
	{
		_posM1 = getposATL (vehicle _batlead1);
		_posM1 set [2,0];
		_impactPosM = +_impactPos;
		_impactPosM set [2,0];
		_finalimpactM = +_finalimpact;
		_finalimpactM set [2,0];
		
		_text = getText (configFile >> "CfgVehicles" >> (typeOf (vehicle _batlead1)) >> "displayName");
		_i = "markBat" + str (_battery1);
		_i = createMarker [_i,_posM1];
		_i setMarkerColor "ColorBlack";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_circle";
		_i setMarkerSize [0.4,0.4];
		_i setMarkerText ("Firing battery - " + _text);
		
		_markers pushBack _i;
		
		_distance = _impactPosM vectorDistance _finalimpactM;
		_distance2 = _impactPosM vectorDistance _posM1;
		_i = "mark0" + str (_battery1);
		_i = createMarker [_i,_impactPos];
		_i setMarkerColor "ColorBlue";
		_i setMarkerShape "ELLIPSE";
		_i setMarkerSize [_distance, _distance];
		_i setMarkerBrush "Border";
		
		_markers pushBack _i;

		_dX = (_impactPosM select 0) - (_posM1 select 0);
		_dY = (_impactPosM select 1) - (_posM1 select 1);
		_angle = _dX atan2 _dY;
		if (_angle >= 180) then {_angle = _angle - 180};
		_dXb = (_distance2/2) * (sin _angle);
		_dYb = (_distance2/2) * (cos _angle);
		_posX = (_posM1 select 0) + _dXb;
		_posY = (_posM1 select 1) + _dYb;

		_i = "mark1" + str (_battery1);
		_i = createMarker [_i,[_posX,_posY]];
		_i setMarkerColor "ColorBlack";
		_i setMarkerShape "RECTANGLE";
		_i setMarkerSize [0.5,_distance2/2];
		_i setMarkerBrush "Solid";
		_i setMarkerdir _angle;
		
		_markers pushBack _i;

		_dX = (_finalimpactM select 0) - (_impactPosM select 0);
		_dY = (_finalimpactM select 1) - (_impactPosM select 1);
		_angle = _dX atan2 _dY;
		if (_angle >= 180) then {_angle = _angle - 180};
		_dXb = (_distance/2) * (sin _angle);
		_dYb = (_distance/2) * (cos _angle);
		_posX2 = (_impactPosM select 0) + _dXb;
		_posY2 = (_impactPosM select 1) + _dYb;

		_i = "mark2" + str (_battery1);
		_i = createMarker [_i,[_posX2,_posY2]];
		_i setMarkerColor "ColorBlack";
		_i setMarkerShape "RECTANGLE";
		_i setMarkerSize [0.5,_distance/2];
		_i setMarkerBrush "Solid";
		_i setMarkerdir _angle;
		
		_markers pushBack _i;

		_i = "mark3" + str (_battery1);
		_i = createMarker [_i,_impactPosM];
		_i setMarkerColor "ColorBlack";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_dot";
		
		_markers pushBack _i;

		_i = "mark4" + str (_battery1);
		_i = createMarker [_i,_finalimpactM];
		_i setMarkerColor "ColorRed";
		_i setMarkerShape "ICON";
		_i setMarkerType "mil_dot";
		_i setMarkerText (str (round _distance) + "m" + " - ETA: " + str (round _eta) + " - " + _ammoG);
			
		_markers pushBack _i;
			
		/*_i = "mark5" + str (_battery);
		_i = createMarker [_i,_finalimpactM];
		_i setMarkerColor "ColorRedAlpha";
		_i setMarkerShape "ELLIPSE";
		_i setMarkerSize [_spawndisp,_spawndisp];*/
	};
	
	[_battery,_distance,_eta,_ammoG,_batlead,_target,_markers] spawn
	{
		params ["_battery", "_distance", "_eta", "_ammoG", "_batlead", "_target", "_markers"];
		private ["_mark", "_Ammo","_alive","_stoper","_TOF"];
		
		_battery1 = _battery select 0;

		_alive = true;
		_shot = false;

		waitUntil 
		{
			sleep 0.1;
			if (
				{not (isNull _x)} count _batlead < 1 ||
				{isNull _battery1} ||
				{({(alive _x)} count _batlead) < 1}	||
				{_battery1 getVariable ["RydFFE_Break",false]}
			) then {_alive = false};
				
			{
				if not (isNull _x) then
				{
					{
						if ((vehicle _x) getVariable ["RydFFE_ShotFired",false]) exitWith {_shot = true}
					}
					foreach (units _x)
				};
					
				if (_shot) exitWith {}
			}
			foreach _battery;
			
			((_shot) or not (_alive))
		};
		
		{
			if not (isNull _x) then
			{
				{
					(vehicle _x) setVariable ["RydFFE_ShotFired",false]
				}
				foreach (units _x)
			};
		}
		foreach _battery;

		_stoper = time;
		_TOF = 0;
		_rEta = _eta;
		_mark = "";
			
		if ((count _markers) > 0) then
		{
			_mark = _markers select ((count _markers) -1);
		};

		while {(not (_rEta < 5) and not (_TOF > 200) and (_alive))} do
		{
			if (
				({not (isNull _x)} count _batlead) < 1 ||
				{isNull _battery1} ||
				{({(alive _x)} count _batlead) < 1} ||
				{_battery1 getVariable ["RydFFE_Break",false]}
			) exitWith {_alive = false};

				_TOF = (round (10 * (time - _stoper)))/10;
				_rEta = _eta - _TOF;
				
				if ((count _markers) > 0) then
				{
					_mark setMarkerText (str (round _distance) + "m" + " - ETA: " + str (round _rEta) + " - TOF: " + (str _TOF) + " - " + _ammoG);
				};
				
				sleep 0.1
			};

			if not (_alive) exitWith 
			{
				(group _target) setvariable ["CFF_Taken",false];
				
				{
				deleteMarker _x;
				}
				foreach _markers;
			};
				
			_battery1 setVariable ["RydFFE_SPLASH",true];

			if ((count _markers) > 0) then
				{
				_mark setMarkerText (str (round _distance) + "m"  + " - SPLASH!" + " - " + _ammoG);
				};
			};

		_eta = [_battery,_finalimpact,_ammo,_amount] call RYD_fnc_CFF_Fire;
					
		_UL = _batlead1;

		_alive = (_eta > 0);
		
		if not (_alive) then {(_battery select 0) setVariable ["RydFFE_Break",true]};

		waituntil 
		{
			sleep 1;

			_available = true;
			if (
				{not (isNull _x)} count _batlead < 1 ||
				{isNull _battery1} ||
				{({(alive _x)} count _batlead) < 1}
			) then {_alive = false};
						
			{
				if not (isNull _x) then
				{
					{
						if not ((vehicle _x) getVariable ["RydFFE_GunFree",true]) exitWith {_available = false}
					}
					foreach (units _x)
				};
				
				if not (_available) exitWith {}
			}
			foreach _battery;
			
			((_available) or not (_alive))
		};

		if not (_alive) exitWith {_waitFor = false};

		if (((count _phaseF) == 2) and (_x == 1)) then 
		{
			_alive = true;
			_splash = false;

			waitUntil 
			{
				sleep 1;

				if (({not (isNull _x)} count _batlead) < 1) then {_alive = false};
				if (isNull _battery1) then {_alive = false};
				if (({(alive _x)} count _batlead) < 1) then {_alive = false};
				if not (isNull _battery1) then {_splash = _battery1 getVariable ["RydFFE_SPLASH",false]};
				
				((_splash) or not (_alive))
			};
				
			if not (isNull _battery1) then {_battery1 setVariable ["RydFFE_SPLASH",false]};

			sleep 10;
			
			{
				deleteMarker _x;
			}
			foreach _markers
		};

	if not (_alive) exitWith {_waitFor = false};
}
foreach _phaseF;

_battery1 setVariable [("CFF_Trg" + _batname),_target];

_alive = true;
_splash = false;

if (_waitFor) then
{
	waitUntil 
	{
		sleep 1;

		if 
		(
			({not (isNull _x)} count _batlead) < 1 ||
			{isNull _battery1 } ||
			{({(alive _x)} count _batlead) < 1}
		) then {_alive = false};
		
		if not (isNull _battery1) then {_splash = _battery1 getVariable ["RydFFE_SPLASH",false]};
			
		((_splash) or not (_alive))
	};
				
	if not (isNull _battery1) then {_battery1 setVariable ["RydFFE_SPLASH",false]};

	sleep 10
};

{
	deleteMarker _x;
}
foreach _markers;

(group _target) setVariable ["CFF_Taken",false];
	
_alive = true;

waitUntil 
{
	sleep 1;

	_available = true;
	//if (isNull _battery1) then {_alive = false};
	if (({not (isNull _x)} count _batlead) < 1 || {({(alive _x)} count _batlead) < 1}) then {_alive = false};
					
	{
		if not (isNull _x) then
		{
			{
				if not ((vehicle _x) getVariable ["RydFFE_GunFree",true]) exitWith {_available = false}
			}
			foreach (units _x)
		};
	
		if not (_available) exitWith {}
	}
	foreach _battery;
		
	((_available) or not (_alive))
};

//if not (_alive) exitWith {};

{
	if not (isNull _x) then
	{
		_x setVariable ["RydFFE_BatteryBusy",false]
	}
}
foreach _battery