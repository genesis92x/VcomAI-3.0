//This function will determine if the player is alive and if we should be considering an IR laser or not. This function may be expanded later to consider flashlights and the like.
while {alive player && {Vcm_ActivateAI}} do
{
	if (player isIRLaserOn currentWeapon player) then
	{
		private _Side = side player;
		
		private _WepDir = (player weaponDirection currentWeapon player) vectorMultiply 1000;
		private _EyePosS = eyePos player;
		private _EyePosB = [_EyePosS select 0,_EyePosS select 1,(_EyePosS select 2 - 0.25)];
		private _EndSight = _EyePosB vectoradd _WepDir;
		private _LineInter = lineIntersectsSurfaces [_EyePosB, _EndSight, player, player, true, 1];
		
		if !(_LineInter isEqualTo []) then
		{
			private _FinalPos = (_LineInter select 0 select 0);
			private _Enemies = allUnits select {[_Side,(side _x)] call BIS_fnc_sideIsEnemy && (currentVisionMode _x isEqualTo 1)};
			private _DirPlayer = getdir Player;
			if !(_Enemies isEqualTo []) then
			{
				private _StartPos = (getpos player);
				private _ToalDist = _Startpos distance2D _FinalPos;
				private _Chunks = round (_ToalDist/100);
				private _ChunkN = 0;
				while {_Chunks > _ChunkN} do
				{
					_StartPos = [_StartPos,100,_DirPlayer] call BIS_fnc_relPos;
					private _NE = [_Enemies,_StartPos,true,"IR"] call VCM_fnc_ClstObj;
					if (_NE distance2D _Startpos < 65) exitWith 
					{				
						[
							[_NE,player],
							{
								params ["_NE","_unit"];
								if (local _NE) then
								{
									private _kv = _NE knowsAbout _unit;
									_NE reveal [_unit,(_kv + 0.4)];
								};								
							}
						] remoteExec ["bis_fnc_call",0];		
					};					
					_ChunkN = _ChunkN + 1;
					sleep 0.1;
				};			
			};
			sleep 0.25;
		};	
	};
	sleep 0.25;
};