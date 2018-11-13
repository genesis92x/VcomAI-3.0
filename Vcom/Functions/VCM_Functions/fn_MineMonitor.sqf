
/*
	Author: Genesis

	Description:
		This function will monitor all placed Vcom mines. Better than each mine having its own spawn.

	Parameter(s):
		NONE

	Returns:
		NOTHING
*/

//This list is all local.
while {true} do
{
	private _RemoveLst = [];
	{
		private _Mine = _x select 0;
		if (alive _Mine) then
		{
			private _Side = _x select 1;
			private _EL = [];
			private _TargetSide = "";
			{
				_TargetSide = side _x;
				if ([_Side, _TargetSide] call BIS_fnc_sideIsEnemy) then {_EL pushback _x;};
			} forEach allUnits;
				
			private _CE = [_EL,_Mine,true,"2"] call VCM_fnc_ClstObj;
			
			if (_CE distance _Mine < 2.5) then 
			{
				[_Mine, true] remoteExecCall ["enableSimulationGlobal",2];
				sleep 0.25;
				_Mine setdamage 1;			
			};
		}
		else
		{
			_RemoveLst pushback _x;
		};
	
	
	
	
	
	
	} foreach VCOM_MINEARRAY;
	
	{
		private _A = _x;
		VCOM_MINEARRAY deleteAt (VCOM_MINEARRAY findIf {_A isEqualTo _x;});
	} foreach _RemoveLst;
	sleep 1.25;
};