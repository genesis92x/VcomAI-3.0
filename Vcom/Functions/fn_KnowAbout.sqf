//This function will edit the knowledge of a unit for a specific side.
params ["_SNDA","_Unit"];

{
	if (local _x) then
	{
		private _kv = _x knowsAbout _unit;
		_x reveal [_unit,(_kv + 0.25)];
		if (VCM_Debug) then {diag_log (format ["%1 knowledge of %2 is at %3",_x,_Unit,(_kv + 0.25)])};
	};
} foreach _SNDA;