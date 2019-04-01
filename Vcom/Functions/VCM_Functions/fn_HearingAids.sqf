
/*
	Author: Genesis

	Description:
		Firing unsuppressed shots reveals unit.

	Parameter(s):
		0: OBJECT - Unit that fired
		1: STRING - Weapon fired
		2: STRING - Muzzle used
		3: STRING - Firing mode
		4: STRING - Ammo used
		5: STRING - Magazine used
		6: OBJECT - Projectile created
		7: OBJECT - Gunner whose weapon was fired (For use with vehicles)

	Returns:
		NOTHING
		
	Note:
		For use with "Fired" eventhandler
		
	Example1:
		this addEventHandler ["Fired", {
			_this call VCM_fnc_HearingAids;
		}];
*/

params ["_unit","_weapon","_muzzle","_mode","_ammo","_magazine","_bullet","_gunner"];

if (_weapon isEqualTo "Put" || {_weapon isEqualTo "Throw"}) exitwith {};

private _timeShot = _unit getVariable ["VCM_FTH",-60];
_unit setVariable ["VCMLASTFIRED", time, false];
[_unit, 0] call VCM_fnc_AddSuppressionNow; //Immediately set stance

if ((_timeShot + 20) < time) then 
{
	
	if ((group _unit) getVariable ["VCM_NOFLANK",false]) exitWith {};
	
	//Check if unit has suppressor on weapon.
	private _mzl = currentMuzzle _unit;
	private _mzl = if (_mzl isEqualType "") then {_mzl} else {""};
	private _atch = _unit weaponAccessories _mzl param [0, ""];
	private _return = (!(_atch isEqualTo "")) && {getNumber(configFile >> "CfgWeapons" >> _atch >> "ItemInfo" >> "AmmoCoef" >> "audibleFire") < 1};
	
	if (VCM_DEBUG) then {diag_log (format ["VCOM: %2: WEAPON SUPRRESSED - %1",_return,_unit])};
	
	//systemchat format ["%1",_sup];
	if !(_return) then 
	{
		private _array1 = _unit call VCM_fnc_EnemyArray;
		private _snda = [];
		private _Grps = [];
		{
			if ((_x distance2D _unit) < VCM_HEARDIST) then
			{
				_snda pushback _x;
				_Grps pushBackUnique (group _x);
			};
		} foreach _array1;
		
		if (count _snda > 0) then
		{
			[_snda,_unit, random 0.25 + 0.15, 10] remoteExec ["VCM_fnc_KnowAbout",_unit];
			{
				if (behaviour _x isEqualTo "SAFE") then {_x setBehaviour "AWARE"};
			} foreach _Grps;
			
		};
		
		_unit setVariable ["VCM_FTH",time];
	};
	
};



