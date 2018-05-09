//Function for adding/removing units from the artillery list
//VCM_ARTYLST
//Group is passed

{
	private _Veh = (vehicle _x);
	private _Num = VCM_ARTYLST findIf {_x isEqualTo _Veh};
	if (_Num isEqualTo -1) then
	{
		private _class = typeOf _Veh;
		if !(isNil ("_class")) then 
		{
			private _ArtyChk = getNumber(configfile/"CfgVehicles"/_class/"artilleryScanner");
			if (_ArtyChk isEqualTo 1) then
			{
				VCM_ARTYLST pushback _Veh;
			};
		};
	};
} foreach (units _this);