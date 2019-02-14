
/*
	Author: Genesis

	Description:
		This function will edit the knowledge of a unit for a specific side.

	Parameter(s):
		0: ARRAY
		1: OBJECT - Unit that will be revealed to above array
		2: NUMBER - Knowledge value to add
		3: NUMBER - Maximum knowsAbout value added
	
	Returns:
		NOTHING
*/

params ["_snda","_unit","_toAdd", "_limit"];
if (isNil "_toAdd") then {_toAdd = 0.25};
if (isNil "_limit") then {_limit = 1.5};
{
	if (local _x) then
	{
		private _kv = _x knowsAbout _unit;
		if (_kv < _limit) then 
		{
			_x reveal [_unit,(_kv + _toAdd)];
			if (VCM_Debug) then {diag_log (format ["VCOM: %1 knowledge of %2 is at %3",_x,_unit,(_kv + _toAdd)])};
		};
	};
} foreach _snda;