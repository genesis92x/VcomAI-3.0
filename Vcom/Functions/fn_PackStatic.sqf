//This function will constantly monitor the unit and see if the static weapon needs to be dissassembled or not. The amount of time on a static will be a base variable with additional time every time an enemy is spotted.
//Edited on: 8/8/2017 @ 0011

params ["_Unit","_Backpack","_StaticCreated"];

sleep 10;

private _StaticGreen = true;
private _Statictime = 180;

while {_StaticGreen && {alive _unit} && {alive _StaticCreated} && {!(isNull (gunner _StaticCreated))}} do
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

//Okay, time to move!
if (alive _Unit) then
{
	_Unit leaveVehicle _StaticCreated;
	[_Unit,"AinvPknlMstpSnonWnonDnon_Putdown_AmovPknlMstpSnonWnonDnon"] remoteExec ["Vcm_PMN",0];
	sleep 3;
	deleteVehicle _StaticCreated;
	sleep 1;
	_Unit addBackpackGlobal _Backpack;
};