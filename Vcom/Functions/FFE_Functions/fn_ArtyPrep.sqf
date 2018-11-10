params ["_arty", "_amount"];
private ["_arty","_amount","_vh","_handled","_magTypes","_mags","_tp","_cnt"];	
	
_amount = ceil _amount;
//if (_amount < 2) exitWith {};

{		
	{
		_vh = vehicle _x;
		_handled = _vh getVariable ["RydFFEArtyAmmoHandled",false];
		
		if not (_handled) then
		{
			_vh setVariable ["RydFFEArtyAmmoHandled",true];
			
			_vh addEventHandler ["Fired",
				{
					(_this select 0) setVariable ["RydFFE_ShotFired",true];
					(_this select 0) setVariable ["RydFFE_ShotFired2",((_this select 0) getVariable ["RydFFE_ShotFired2",0]) + 1];
				
					//if ((RydFFE_SVStart) and (RydFFE_Debug)) then
					//{
					_shells = missionNameSpace getVariable ["RydFFE_FiredShells",[]];
					_shells set [(count _shells),(_this select 6)];
					missionNameSpace setVariable ["RydFFE_FiredShells",_shells];
					//}
				}];
			
			_magTypes = getArtilleryAmmo [_vh];
			_mags = magazines _vh;
			
			{
				_tp = _x;
				_cnt = {_x in [_tp]} count _mags;
				_vh addMagazines [_tp, _cnt * (_amount - 1)];
			}
			foreach _magTypes
		}
	}
	foreach (units _x)
}
foreach _arty;