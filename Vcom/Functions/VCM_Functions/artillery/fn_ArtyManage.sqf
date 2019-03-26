
/*
	Author: Genesis

	Description:
		Scans group for artillery pieces, found artillery is added to VCM_ARTYLST.

	Parameter(s):
		0: GROUP - group to scan for artillery pieces

	Returns:
		NOTHING
	
	Note: 
		Deprecated in favour of Rydigiers "Fire for Effect: The God Of War"
*/

{
	private _veh = (vehicle _x);
	private _num = VCM_ARTYLST findIf {_x isEqualTo _veh};
	if (_num isEqualTo -1) then
	{
		private _class = typeOf _veh;
		if !(isNil ("_class")) then 
		{
			private _artyChk = getNumber(configfile/"CfgVehicles"/_class/"artilleryScanner");
			if (_artyChk isEqualTo 1) then
			{
				VCM_ARTYLST pushback _veh;
			};
		};
	};
} foreach (units _this);