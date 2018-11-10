//[RydFFE_ArtG,RydFFE_KnEnemies,(RydFFE_EnHArmor + RydFFE_EnMArmor + RydFFE_EnLArmor),RydFFE_Friends,RydFFE_Debug] call RYD_fnc_CFF;

params ["_artG", "_knEnemies", "_enArmor", "_friends", "_Debug", "_amount"];

private ["_CFFMissions","_tgt","_ammo","_bArr","_possible","_amnt"];


_CFFMissions = ceil (random (count _artG));

for "_i" from 1 to _CFFMissions do
{
	_tgt = [_knEnemies] call RYD_fnc_CFF_TGT;

	if not (isNull _tgt) then
	{
		_ammo = "HE";
		_amnt = _amount;
		if ((random 100) > 85) then {_ammo = "SPECIAL";_amnt = (ceil (_amount/3))};
		//if (_tgt in _enArmor) then {_ammo = "HE";_amnt = 6};

		_bArr = [(getPosATL _tgt),_artG,_ammo,_amnt,objNull] call RYD_fnc_ArtyMission;

		_possible = _bArr select 0;
		if (_possible) then
		{
			{
				if not (isNull _x) then
				{
					_x setVariable ["RydFFE_BatteryBusy",true]
				}
			}
			foreach (_bArr select 1);
		[_bArr select 1,_tgt,_bArr select 2,_bArr select 3,_friends,_Debug,_ammo,_amnt min (_bArr select 4)] spawn RYD_fnc_CFF_FFE
		}
		else
		{
			switch (true) do
			{
				case (_ammo in ["SPECIAL","SECONDARY"]) : {_ammo = "HE";_amnt = _amount};
				case (_ammo in ["HE"]) : {_ammo = "SECONDARY";_amnt = _amount};
			};

			_bArr = [(getPosATL _tgt),_artG,_ammo,_amnt,objNull] call RYD_fnc_ArtyMission;

			_possible = _bArr select 0;
			if (_possible) then
			{
				{
					if not (isNull _x) then
					{
						_x setVariable ["RydFFE_BatteryBusy",true]
					}
				}
				foreach (_bArr select 1);
				[_bArr select 1,_tgt,_bArr select 2,_bArr select 3,_friends,_Debug,_ammo,_amnt min (_bArr select 4)] spawn RYD_fnc_CFF_FFE
			}
		}
	};

	sleep (5 + (random 5))
}