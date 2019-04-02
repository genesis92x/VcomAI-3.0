/*
	Author: Freddo

	Description:
		Applies VCOM skill settings to a unit

	Parameter(s):
		OBJECT - Unit to apply skill to

	Returns:
		NOTHING
*/

private _unit = _this;

if VCM_CLASSSKILL then
{
	private _typeOf = typeOf _unit;
	private _index = VCM_SKILLCLASSES findIf {_x select 0 isEqualTo _typeOf}; // isEqualTo is case sensitive - so they better type if correctly
	if (_index != -1) exitWith 
	{
		{
			_unit setSkill [_x, (VCM_SKILLCLASSES select _index) select (_forEachIndex + 1)];
		} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
	};
};
if VCM_SIDESKILL exitWith
{
	switch (side _unit) do
	{
		case west: 
		{
			{
				_unit setSkill [_x, VCM_WESTSKILL select _forEachIndex];
			} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
		};
		case east: 
		{
			{
				_unit setSkill [_x, VCM_EASTSKILL select _forEachIndex];
			} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
		};
		case resistance: 
		{
			{
				_unit setSkill [_x, VCM_INDSKILL select _forEachIndex];
			} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
		};
		case civilian: 
		{
			{
				_unit setSkill [_x, VCM_CIVSKILL select _forEachIndex];
			} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
		};
	};
};
if VCM_SKILLCHNG exitWith
{
	{
		_unit setSkill [_x, VCM_SKILL select _forEachIndex];
	} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
};