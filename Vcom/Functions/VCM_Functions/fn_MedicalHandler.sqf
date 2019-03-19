/*
	Author: Freddo

	Description:
		Makes group check medical status, and order medics about

	Parameter(s):
		0: GROUP

	Returns:
		NOTHING
*/

if !(VCM_MEDICALACTIVE) exitWith {};

params ["_group"];
private _units = units _group;
private _medics = _group call VCM_fnc_RMedics;
if (isNil "_medics") then {_medics = []};

{
	if (isNull objectParent _x && {damage _x != 0}) then 
	{
		[_x, _medics] spawn 
		{
			params ["_unit", "_medicArr"];
			sleep random 10;
			if !(_unit call VCM_fnc_HealSelf) then // VCM_fnc_HealSelf returns false if unit unable to heal self
			{
				if (count _medicArr isEqualTo 0) exitWith {};
				private _medic = selectRandom _medicArr;
				if !(_medic getVariable ["VCM_MBUSY", false]) then // Check if medic is busy
				{
					[_medic ,_unit] call VCM_fnc_MedicHeal;
				};
			};
		};
	};
} forEach _units;