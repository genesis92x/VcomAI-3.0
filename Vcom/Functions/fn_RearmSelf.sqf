//This function will determine if an group is low on ammo and needs to re-arm.
//This script passes _this. _this should be the group.
private _AL = VCM_AIMagLimit;
{
	private _OrgUnit = _x;
if !(vehicle _x isEqualTo _x) exitWith {};

//The first thing we want to do. Is figure out what ammo this unit is using.
private _CM = currentMagazine _x;

//Now, we want to compare this classname to all the other ammo classnames this unit may have and count the number.
private _mags = magazines _x;

//Count the total number of mags.
private _TC = 0;
{ if (_x isEqualTo _CM) then {_TC = _TC + 1};true;} count _mags;

//If unit has less than the wanted limit, then make the unit find ammo!
if (_TC < _AL) then {
	//Find closest men!
	_FB = _x nearEntities [["WeaponHolderSimulated", "Man", "Air", "Car", "Motorcycle", "Tank"], 200];
	_FB = _FB - [_x];
	{
		if (alive _x && {_x isKindOf "Man"}) then {_FB = _FB - [_x];};
		true;
	} count _FB;
	
	//If menz are around see if we can take ammo from them first.
	_Stop = false;
	if (count _FB != 0) then {
		{
			_mags = [];
			_Unit = _x;
			if (_Unit isKindOf "Man") then {
				_mags = magazines _Unit;
			} else {
				_mags = magazineCargo _Unit;
			};
			if (isNil "_mags") then {_mags = [];};
			{
				if (_x isEqualTo _CM) exitwith {
					[_OrgUnit,_Unit] spawn VCM_fnc_ActRearm; 
					_Stop = true;
				};
				true;
			} count _mags;
			if ( _Stop ) exitwith {};
			true;
		} count _FB;
	};
};
true;
}	count (units _this);