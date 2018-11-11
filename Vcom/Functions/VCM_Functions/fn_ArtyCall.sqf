//Function for AI calling in artillery support.
params ["_CallGroup","_EnemyG"];
private _CallSide = (side _CallGroup);

//First let's remove any AI not actively in artillery pieces. Just in case something changed for them.

{
	private _Veh = _x;
	private _class = typeOf _Veh;
	if !(isNil ("_class")) then 
	{
		private _ArtyChk = getNumber(configfile/"CfgVehicles"/_class/"artilleryScanner");	
		if !(_ArtyChk isEqualTo 1) then
		{
			VCM_ARTYLST deleteAt (VCM_ARTYLST findif {_Veh isEqualTo _x});
		};		
	};
	
} foreach VCM_ARTYLST;

//Next let's only select AI units who are on our side or friendly.
private _ArtyArray = [];
{
	if ([(side _x),_CallSide] call BIS_fnc_sideIsFriendly) then
	{
		_ArtyArray pushback _x;
	};	
} foreach VCM_ARTYLST;

if (_ArtyArray isEqualTo []) exitWith {};

//Now with our completed array, lets find positions that can support.
private _ClstGrp = [_ArtyArray,(leader _CallGroup),true,"Arty1"] call VCM_fnc_ClstObj;
if (isNil "_ClstGrp") exitWith {};

private _AGrpUnits = units (group _ClstGrp);
private _AVehGrpUnits = [];
{_AVehGrpUnits pushback (vehicle _x)} foreach _AGrpUnits;

private _AmmoArray = getArtilleryAmmo _AVehGrpUnits;
if (isNil "_AmmoArray") exitWith {};

private _RandomAmmoArray = selectRandom _AmmoArray;
if (isNil "_RandomAmmoArray") exitWith {};


private _LeaderE = leader _EnemyG;
private _ContinueFiring = (getPos _LeaderE) inRangeOfArtillery [_AVehGrpUnits,_RandomAmmoArray];

if !(_ContinueFiring) exitWith {};

private _EnemyGroup = _EnemyG;
private _RoundsToFire = round (count (units _EnemyGroup)/4);

if (_RoundsToFire < 2) then {_RoundsToFire = 2};

{
	private _dist = random (15 + (random VCM_ARTYSPREAD));
	private _dir = random 360;
	private _pos = getpos _LeaderE;
	private _positions = [(_pos select 0) + (sin _dir) * _dist, (_pos select 1) + (cos _dir) * _dist, 0];
	_x doArtilleryFire [_positions,_RandomAmmoArray,_RoundsToFire];
	
} foreach _AVehGrpUnits;