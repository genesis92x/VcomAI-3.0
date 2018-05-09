//Find cover function!
//Needs the following params
// [_leader,_MoveDist]
params ["_leader","_MoveDist"];

private _Group = (group _leader);
private _NearestEnemy = _leader findNearestEnemy _leader;
if (isNull _NearestEnemy) then
{
	_NearestEnemy = _leader call VCM_fnc_ClstEmy;	
};
private _TypeListFinal = [];

private _WeakListFinal = [];
private _ClosestCover = [];
private _TypeListFinal = [];
private _Units = (units _Group) select {alive _x};

private _curwp = currentWaypoint _Group;
private _wPos = waypointPosition [_Group,_curwp];
private _Dir = _Wpos;
if (_WPos isEqualTo [0,0,0]) then
{
	_wPos = (getpos _leader);
	_Dir = _NearestEnemy;
};

private _MovePosition = [_leader,_MoveDist,([_leader, _Dir] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
if (VCM_Debug) then
{
	private _arrow = "Sign_Arrow_Green_F" createVehicle [0,0,0];
	_arrow setposATL _MovePosition;
	_arrow spawn 
	{
		_Counter = 0;
		_Position = getpos _this;
		_NewPos2 = _Position select 2;						
		while {_Counter < 60} do
		{
			_NewPos2 = _NewPos2 + 0.1;
			_this setpos [_Position select 0,_Position select 1,_NewPos2];
			_Counter = _Counter + 1;
			sleep 0.5;
		};
		deletevehicle _this;
	};					
};	
private _TypeList = nearestObjects [_MovePosition, [], (_MoveDist/2)];
private _Roads = _MovePosition nearRoads _MoveDist;
{
	private _Type = typeOf _x;
	if !(_type in ["#crater","#crateronvehicle","#soundonvehicle","#particlesource","#lightpoint","#slop","#mark","HoneyBee","Mosquito","HouseFly","FxWindPollen1","ButterFly_random","Snake_random_F","Rabbit_F","FxWindGrass2","FxWindLeaf1","FxWindGrass1","FxWindLeaf3","FxWindLeaf2"]) then
	{
		if (!(_x isKindOf "Man") && {!(_x isKindOf "Bird")} && {!(_x isKindOf "BulletCore")} && {!(_x isKindOf "Grenade")} && {!(_x isKindOf "WeaponHolder")}) then
		{
			private _BoundingArray = boundingBoxReal _x;
			private _p1 = _BoundingArray select 0;
			private _p2 = _BoundingArray select 1;
			private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
			private _maxLength = abs ((_p2 select 1) - (_p1 select 1));
			private _maxHeight = abs ((_p2 select 2) - (_p1 select 2));
			if (_maxWidth > 1.5 && {_maxLength > 1.5} && {_maxHeight > 1.5}) then
			{
				if (_type isEqualTo "") then 
				{
					_WeakListFinal pushback _x
				} 
				else
				{
					_TypeListFinal pushback _x;
				};
			};
		};
	};
	true;
} count ((_TypeList) - (_Roads));

if (_TypeListFinal isEqualTo [] && _WeakListFinal isEqualTo []) exitWith 
{
	//NO COVER
	{
		private _P = [[[_MovePosition, 50]],["water"]] call BIS_fnc_randomPos;
		_x forcespeed -1;
		_x doMove _P;		
	} foreach _Units;
};

//Now tell the AI to seek cover.
{
	private _Foot = isNull objectParent _x;
	if (_Foot) then
	{
		[_x,_TypeListFinal,_WeakListFinal,_NearestEnemy,_MoveDist,_MovePosition] spawn
		{
			params ["_Unit","_CoverL","_ConcealL","_NearestEnemy","_MoveDist","_MovePosition"];	
			private _PosCON = (getPosWorld _Unit);
			if (count _ConcealL > 0) then {_PosCON = selectRandom _ConcealL;}; //[_ConcealL,_Unit,true,"NrstPos"] call VCM_fnc_ClstObj;
			if (count _CoverL > 0) then {_PosCON = selectRandom _CoverL }; //_PosCON = [_CoverL,_Unit,true,"NrstPos"] call VCM_fnc_ClstObj;
				
				//Return fire for a few seconds, then move
				private _FNearestEnemy = _Unit findNearestEnemy _Unit;
				if (isNull _FNearestEnemy) then
				{
					_FNearestEnemy = _Unit call VCM_fnc_ClstEmy;	
				};
				_Unit doSuppressiveFire _FNearestEnemy;
				sleep (5 + (random 10));
				
				private _FPos = [_NearestEnemy, (_PosCON distance _NearestEnemy) + 2, ([_NearestEnemy, _PosCON] call BIS_fnc_dirTo)] call BIS_fnc_relPos;
				private _DistW = 2;
				if (_PosCON iskindof "AllVehicles") then {_DistW = 5;};
				if (VCM_Debug) then
				{
					private _arrow = "VR_3DSelector_01_exit_F" createVehicle [0,0,0];
					_arrow setposATL _FPos;
					_arrow spawn 
					{
						_Counter = 0;
						_Position = getpos _this;
						_NewPos2 = _Position select 2;						
						while {_Counter < 60} do
						{
							_NewPos2 = _NewPos2 + 0.1;
							_this setpos [_Position select 0,_Position select 1,_NewPos2];
							_Counter = _Counter + 1;
							sleep 0.5;
						};
						deletevehicle _this;
					};					
				};
				_Unit setUnitPos "MIDDLE";
				_Unit doWatch ObjNull;
				_unit disableAI "TARGET";
				_unit disableAI "WEAPONAIM";
				(group _Unit) setCombatMode "BLUE";
				_Unit forcespeed 5;
				sleep 0.2;
				_Unit doMove _FPos;
				sleep 1;
				//_Unit setDestination [_FPos,"LEADER PLANNED", true];								
				//We need the AI to STAY in the ordered position until ordered to move again.
				private _Cont = true;
				private _Fail = false;
				private _Cnt = 0;
				while {_Cont} do
				{
					if (_Unit distance2D _FPos < _DistW) then {_Cont = false;};
					if (!(alive _Unit) || _Cnt > 80) then {_Cont = false;_Fail = true;};
					_Cnt = _Cnt + 0.1;	
					sleep 0.1;
				};
				if !(_Fail) then {_Unit forcespeed 0;};
				_unit enableAI "TARGET";
				_unit enableAI "WEAPONAIM";
				_Unit setUnitPos "AUTO";
				(group _Unit) setCombatMode "RED";

		};
	};
} foreach _Units;





