
/*
	Author: Genesis, improved by Freddo

	Description:
		Plays appropiate hit reactions on unit

	Parameter(s):
		0: OBJECT - Object affected
		1 (Optional): OBJECT - Object that caused damage
		2: NUMBER - Level of damage caused
		3: OBJECT - Object that pulled the trigger

	Returns:
		NOTHING

	Example1:
		this addEventHandler ["Hit", {
			_this call VCM_fnc_AIHIT;
		}];
	
	NOTE:
		Meant to be called from a "HIT" eventhandler
*/
params ["_unit", "_source", "_damage", "_instigator"];

/*
if 
(
	!(isNull objectParent _unit) || 
	{(missionNamespace getvariable ["ace_medical_enableUnconsciousnessAI", 0]) != 0} //Check if ACE3 makes AI go unconscious
) exitWith {};
*/
if (_damage > 0.1 && !(lifestate _unit isEqualTo "INCAPACITATED")) then 
{
	[_unit, 0.5] call VCM_fnc_AddSuppressionNow;
};

if (!(lifestate _unit isEqualTo "INCAPACITATED") && {5 < (random 10)}) then
{
	
	if (stance _unit isEqualTo "PRONE") then
	{
		//Find current weapon type
		private _currentWeapon = currentWeapon _unit;
		private _currentWeaponType = 0;
		if (_currentWeapon == primaryWeapon _unit) then {_currentWeaponType = 1};
		if (_currentWeapon == handgunWeapon _unit) then {_currentWeaponType = 2};
		if (_currentWeapon == Binocular _unit) then {_currentWeaponType = 3};
		
		switch (_currentWeaponType) do
		{
		
			//Rifle animations
			case 1: 
			{
				switch (floor random 2) do {
					case 0: {_unit playMoveNow "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl";}; //Roll left
					case 1: {_unit playMoveNow "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr";}; //Roll right
				};
			};
			
			//Handgun animations
			case 2:
			{
				switch (floor random 3) do {
					case 0: {_unit playMoveNow "amovppnemstpsraswpstdnon_amovppnemevaslowwpstdl";}; //Roll left
					case 1: {_unit playMoveNow "amovppnemstpsraswpstdnon_amovppnemevaslowwpstdr";}; //Roll right
				};
			};
			
			//Binocular animations
			case 3:
			{
				switch (floor random 2) do {
					case 0: {_unit playMoveNow "amovppnemstpsoptwbindnon_amovppnemevasoptwbindl";}; //Roll left
					case 1: {_unit playMoveNow "amovppnemstpsoptwbindnon_amovppnemevasoptwbindr";}; //Roll right
				};
			};
		};
	};
};
