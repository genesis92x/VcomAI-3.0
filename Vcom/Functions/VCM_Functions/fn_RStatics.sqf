//Function for defining the list of units with statics and etc.
private _StaticList = [];
private _SatchelList = [];
private _MineList = [];

{
	if (isNull objectParent _x) then
	{
		//Define static weapon
		private _CurrentBackPack = backpack _x;
		private _class = "";
		if !(_CurrentBackPack isEqualTo "") then 
		{
			_class = [_CurrentBackPack] call VCM_fnc_Classname;
			private _parents = [_class,true] call BIS_fnc_returnParents;
			if (!(isNil "_parents")) then 
			{
					if (("StaticWeapon" in _parents) || {("Weapon_Bag_Base" in _parents)}) then 
					{
						private _VCOM_HASUAV = false;
						if (["UAV",_CurrentBackPack,false] call BIS_fnc_inString) then {_VCOM_HASUAV = true;};
						_StaticList pushBack [_x,_CurrentBackPack,_VCOM_HASUAV];
					};
				};
		};
		//END STATIC WEAPON
		
		//_PushArray = [_VCOM_HASSATCHEL,_ActualObj,_VCOM_HasMine,_SatchelArray];
		private _MineArray = _x call VCM_fnc_HasMine;
		private _VCOM_HASSATCHEL = _MineArray select 0;
		private _Vcom_MineObject = _MineArray select 1;
		private _VCOM_HasMine = _MineArray select 2;
		private _SatchelArray = _MineArray select 3;
		
		if (_VCOM_HasMine) then
		{
			_MineList pushback [_x,(_Vcom_MineObject select 0)];
		};
		if (_VCOM_HASSATCHEL) then
		{
			_SatchelList pushback [_x,(_SatchelArray select 0)];
		};
		
		if (VCM_ARTYENABLE) then {_x call VCM_fnc_CheckArty;};
	};
	true;
} count (units _this);

private _FinalList = [_StaticList,_SatchelList,_MineList];
_FinalList