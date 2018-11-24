/*
	Author: Genesis, revamped by Freddo

	Description:
		Checks if a unit is driver

	Parameter(s):
		0: OBJECT - Unit to check

	Returns:
		BOOLEAN
	
*/

params ["_unit"];
private _rtrn = false;

if (!isNull objectParent _unit && {driver vehicle _unit isEqualTo _unit}) exitWith 
{
	_rtrn = true;
	_rtrn
};

_rtrn
