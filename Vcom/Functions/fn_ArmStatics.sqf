//Function for getting AI in a squad to arm any nearby statics

private _Leader = (leader _this);
private _Weaps = nearestObjects [_Leader, ["StaticWeapon"], 250];
private _UnitsA = units _this;
if (count _Weaps < 0) exitWith {};
private _FA = [];
{
private _Unit = [_UnitsA,_x,true,"W1"] call VCM_fnc_ClstObj;
private _Foot = isNull objectParent _Unit;
if (_Foot) then
{
	if (_Unit distance2D _x < 100) then
	{
		_FA pushback [_Unit,_x];
		private _Del = (_UnitsA findIf {_x isEqualTo _Unit});
		_UnitsA deleteAt _Del;	
	};
};
} foreach _Weaps;

if (count _FA < 0) exitWith {};
{
	_x spawn
	{
		params ["_Unit","_Weap"];
		private _AssignedGunner = assignedGunner _Weap;
		if (isNull _AssignedGunner) then
		{
			_Unit doMove (getposATL _Weap);
			_Unit assignAsGunner _Weap;
			[_Unit] orderGetIn true;
			_Waiting = 0;
			while {(alive _Unit) && {_Unit distance _Weap > 4}} do
			{
				sleep 1;
			};
			_Unit moveInGunner _Weap;
			[_Unit,_Weap] spawn
			{
				params ["_Unit","_Weap"];
				private _StaticGreen = true;
				private _Statictime = VCM_STATICARMT;
				
				while {_StaticGreen && {alive _unit} && {alive _Weap} && {!(isNull (gunner _Weap))} && {_Unit distance2D (leader (group _Unit)) < 500}} do
				{
					sleep 5;
					private _Enemy = _Unit findNearestEnemy _Unit;
					if (!(isNull _Enemy)) then 
					{
							private _cansee = [_Unit, "VIEW"] checkVisibility [eyePos _Unit, eyePos _Enemy];
							if (_cansee > 0) then {_Statictime = _Statictime + 3;} else {_Statictime = _Statictime - 5;};
					}
					else
					{
						_Statictime = _Statictime - 5;
					};
					if (_Statictime < 1) then {_StaticGreen = false;};
				};				
				
				unassignVehicle _Unit;
				_Unit leaveVehicle _Weap;
				doGetOut _Unit;
			
			};
		};		
	};	
} foreach _FA;