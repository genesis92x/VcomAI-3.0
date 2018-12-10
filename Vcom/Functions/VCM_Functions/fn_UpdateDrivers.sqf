
/*
	Author: Freddo

	Description:
		Generates a list of drivers for VCM_fnc_VehicleDetection to process

	Parameter(s):
		NONE

	Returns:
		ARRAY - Array containing eligible drivers
	Example1:  [] call VCM_fnc_UpdateDrivers;
*/

scopeName "main"; // Used to breakOut

private _driverList = [];
{
	// Exit if limit for drivers have been reached
	if (count _driverList > VCM_DRIVERLIMIT) then {_driverList breakOut "main";};
	
	private _driver = (driver _x);
	
	if 
	(
		!isPlayer _driver &&
		{_x isKindOf "allvehicles"} && 
		{!(velocity _x isEqualTo [0,0,0])} &&
		{!(_x isKindOf "AIR")} && 
		{!(isNull _driver)} && 
		{local _driver} && 
		{!((group _driver) getvariable ["Vcm_Disable",false])} 
	) 
	then
	{
		_driverList pushback _x;
	};
} forEach vehicles;

_driverList