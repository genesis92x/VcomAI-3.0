VCM_VISUALDEBUG = 
{
		params ["_Unit","_Array"];
	
	private _ArrowA = _Unit getVariable ["VCM_DBGA",[]];
	private _VisualA = _Unit getVariable ["VCM_DBGVI",[]];
	
	if (count _ArrowA > 0) then
	{
		{
			_x call BIS_fnc_drawArrow;
		} foreach _ArrowA;
	};
	if (count _VisualA > 0) then
	{
		{
			removeMissionEventHandler ["Draw3D",_x];
		} foreach _VisualA;
	};	
	_ArrowA = [];
	_VisualA = [];
	{
		private _Pos = _x;
		_Pos set [2,1];
		
		private _StartingPoint = _Pos;
		private _NextPoint = (_Array # (_foreachindex + 1));
		
		if !(isNil "_NextPoint") then
		{
			_NextPoint set [2,1];
			private _ID = addMissionEventHandler ["Draw3D", 
			format 
				[
				"
					drawLine3D [%1, %2, [1,0,0,1]];
				",
				_StartingPoint,_NextPoint
				]
			];
			
			private _ID2 = addMissionEventHandler ["Draw3D", 
			format [
			"	
				private _WH = linearConversion[0, 50, player distance2D %1, 2, 0, true];
				private _TS = linearConversion[0, 50, player distance2D %1, 0.05, 0, true];
				drawIcon3D ['\a3\characters_f_enoch\headgear\data\ui\icon_h_hat_tinfoil_f_ca.paa', [1,1,1,0.7], %1, _WH, _WH, 0, 'Point', 2, _TS, 'PuristaMedium'];
			",
			_NextPoint
			]];
		
			private _Arrow = [_StartingPoint, _NextPoint, [1,0,0,1], [1,1/5,5]] call BIS_fnc_drawArrow;
			_ArrowA pushback _Arrow;
			_VisualA pushback _ID;
			_VisualA pushback _ID2;
		
		};
	} foreach _Array;
	_Unit setVariable ["VCM_DBGA",_ArrowA];
	_Unit setVariable ["VCM_DBGVI",_VisualA];
	
};

VCM_TestFunc =
{
	params ["_Unit"];

	_Unit setVariable ["babe_em_vars", [false, false, true]]; 


	
	waitUntil 
	{
		private _MP = _Unit getVariable ["VCM_MVWP",[]];
		if (count _MP > 0 && {!(_Unit getVariable ["VCM_VAULT",false])}) then
		{
			private _CP = [_MP,_Unit,true,"EM"] call VCM_fnc_ClstObj;
			private _FinalPoint = (_MP# (count _MP - 1));
			if (_CP distance2D _Unit < 8) then
			{
				_Index = _MP findif {_CP isEqualTo _x};
				_MP deleteAt _Index;
				_a = _CP getDir _FinalPoint;
				private _NewPos = _CP getPos [25,_a];
				private _UH = (getPosASL _Unit)#2;
				_CP = AGLtoASL _CP;
				_NewPos = AGLtoASL _NewPos;
				_IObjA = lineintersectsSurfaces [[(_CP#0),(_CP#1),(_UH + 1)],[(_NewPos#0),(_NewPos#1),(_UH + 1)], _Unit, objNull, true, 1, "GEOM", "FIRE"];
				
				if (count _IObjA > 0) then
				{
					private _IPos = _IObjA#0#0;
					private _IObj = _IObjA#0#2;
					
					
					if (VCM_Debug) then
					{
						_abcd2 = createVehicle ["Sign_Arrow_F", _IPos, [], 0, "can_collide"];
						_abcd2 setposasl _IPos;
						_abcd2 spawn {sleep 5;deleteVehicle _this;};
					};					
					
					private _IsCloser = AGLtoASL (_IPos getPos [3,(_Unit getDir _IPos)]);
					private _list = _IsCloser nearObjects ["All",2];
					private _list2 = nearestTerrainObjects [_IsCloser, [], 2];
					
					
					private _OP1 = getposASL _IObj;
					private _OPD1 = getDir _IObj;
					private _OPDRP1 = AGLtoASL (_IObj getPos [5,_OPD1]);
					private _OPDRP2 =  AGLtoASL (_IObj getPos [5,(_OPD1 - 180)]);
					
					private _NearbyObjs = nearestObjects [_IObj, [], 5];
					_NearbyObjs deleteat (_NearbyObjs findif {_x isEqualTo _IObj});
					{
						private _Height = _x call BIS_fnc_objectHeight;
						if (_Height < 1) then
						{
							_NearbyObjs = _NearbyObjs - [_x];
						};
					} foreach _NearbyObjs;
					
					

					{
						if (_x isKindOf "MAN" || {_x isEqualTo _IObj}) then
						{
							_list = _list - [_x];
						};
					} foreach _list;
					
					{
						if (_x isEqualTo _IObj) then
						{
							_list2 = _list2 - [_x];
						};
					} foreach _list2;					
					
					
					if (VCM_Debug) then
					{
						[[_IObj],  [1,0,1,1], true] call BIS_fnc_drawBoundingBox;
					};					
					systemchat format ["_NearbyObjs: %1",_NearbyObjs];
					if (!(_IObj isKindOf "Man") && {!(isNull _IObj)} && {_IsCloser distance2D _FinalPoint < _IPos distance2D _FinalPoint} && {count _list isEqualTo 0} && {count _list2 isEqualTo 0} && {count _NearbyObjs > 1}) then
					{
						private _Height = _IObj call BIS_fnc_objectHeight;
						private _corners = _IObj call BIS_fnc_boundingBoxCorner;
						private _CD = ((_corners#0) distance2D (_corners#3));
						if (_Height < 6 && {_CD > 2}) then
						{
							_IPos = AGLtoASL (_IPos getPos [0.25,(_IPos getDir _Unit)]);
							
							
							if (VCM_Debug) then
							{
								_abcd = createVehicle ["Sign_Arrow_F", _IPos, [], 0, "can_collide"];
								_abcd setposasl _IPos;
								_abcd spawn {sleep 15;deleteVehicle _this;};
							};
							_Unit setVariable ["VCM_VAULT",true];
							_Unit domove _IPos;
							_Unit setVariable ["VCM_TO",diag_tickTime];
							
							waitUntil
							{
								_Unit distance2D _IPos < 3 || !(alive _Unit) || (diag_tickTime - (_Unit getVariable "VCM_TO")) > 15
							};
							
							If ((diag_tickTime - (_Unit getVariable "VCM_TO")) > 15 || !(alive _Unit)) exitwith {};
							
							waitUntil
							{
								[_Unit,_IObj, 0] call BIS_fnc_isInFrontOf || !(alive _Unit) || (diag_tickTime - (_Unit getVariable "VCM_TO")) > 15
							};
							
							If ((diag_tickTime - (_Unit getVariable "VCM_TO")) > 15 || !(alive _Unit)) exitwith {};
							
							_Unit disableAI "MOVE";
							_Unit setDir (_Unit getdir _IPos);
							waitUntil
							{
								If !(animationState _Unit isEqualTo "AmovPercMwlkSrasWrflDf") then
								{
									_Unit playMovenow "AmovPercMwlkSrasWrflDf";
								};
								sleep 0.1;
								_Unit distance2D _IPos < 1.2 || !(alive _Unit) || (diag_tickTime - (_Unit getVariable "VCM_TO")) > 15
							};
							
							If ((diag_tickTime - (_Unit getVariable "VCM_TO")) > 15 || !(alive _Unit)) exitwith {};
	
							[_Unit,true] spawn VCM_fnc_BabeOver;
							_Unit spawn
							{
								sleep 2;
								waitUntil
								{
									If !(animationState _this isEqualTo "AmovPercMwlkSrasWrflDf") then
									{
										_this playMovenow "AmovPercMwlkSrasWrflDf";
									};
									((getposATL _this)#2) < 0.1
								};
								_this domove (getpos _this);
								sleep 1;
								_this enableAI "MOVE";
								sleep 10;
								_This setVariable ["VCM_VAULT",false];
							};
						};
					};
					
				};
			};
		};		
		sleep 0.5;
		!(alive _Unit)
	};
	

};


{
	if !(isPlayer _x) then 
	{
		_x addEventHandler ["PathCalculated",
		{
			(_This#0) setVariable ["VCM_MVWP",(_this#1)];
			_this spawn VCM_VISUALDEBUG;
		}];
		
		_x spawn VCM_TestFunc;	
	};
} foreach allunits;

