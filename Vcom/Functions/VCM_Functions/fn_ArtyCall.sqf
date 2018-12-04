
/*
	Author: Genesis

	Description:
		Function for AI calling in artillery support.

	Parameter(s):
		0: GROUP - Group calling for support
		1: GROUP - Enemy group to be targetted

	Returns:
		NOTHING
		
	Note:
		Deprecated in favour of Rydigiers "Fire for Effect: The God Of War"
*/

params ["_callGrp","_enemyGrp"];
private _CallSide = (side _callGrp);

//First let's remove any AI not actively in artillery pieces. Just in case something changed for them.

{
	private _veh = _x;
	private _class = typeOf _veh;
	if !(isNil ("_class")) then 
	{
		private _artyChk = getNumber(configfile/"CfgVehicles"/_class/"artilleryScanner");	
		if !(_artyChk isEqualTo 1) then
		{
			VCM_ARTYLST deleteAt (VCM_ARTYLST findif {_veh isEqualTo _x});
		};
	};
	
} foreach VCM_ARTYLST;

//Next let's only select AI units who are on our side or friendly.
private _artyArray = [];
{
	if ([(side _x),_CallSide] call BIS_fnc_sideIsFriendly && {side _x in VCM_ARTYSIDES}) then
	{
		_artyArray pushback _x;
	};	
} foreach VCM_ARTYLST;

if (_artyArray isEqualTo []) exitWith {};

//Now with our completed array, lets find positions that can support.
private _clstGrp = [_artyArray,(leader _callGrp),true,"Arty1"] call VCM_fnc_ClstObj;
if (isNil "_clstGrp") exitWith {};

private _aGrpUnits = units (group _clstGrp);
private _aVehGrpUnits = [];
{_aVehGrpUnits pushback (vehicle _x)} foreach _aGrpUnits;

private _ammoArray = getArtilleryAmmo _aVehGrpUnits;
if (isNil "_ammoArray") exitWith {};

private _randomAmmoArray = selectRandom _ammoArray;
if (isNil "_randomAmmoArray") exitWith {};


private _leaderE = leader _enemyGrp;
private _continueFiring = (getPos _leaderE) inRangeOfArtillery [_aVehGrpUnits,_randomAmmoArray];

if !(_continueFiring) exitWith {};

private _enemyGrproup = _enemyGrp;
private _RoundsToFire = round (count (units _enemyGrproup)/4);

if (_RoundsToFire < 2) then {_RoundsToFire = 2};

{
	private _dist = random (15 + (random VCM_ARTYSPREAD));
	private _dir = random 360;
	private _pos = getpos _leaderE;
	private _positions = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
	_x doArtilleryFire [_positions,_randomAmmoArray,_RoundsToFire];
	
} foreach _aVehGrpUnits;