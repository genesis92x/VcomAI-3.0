private _T1 = serverTime + 1;
private _T2 = serverTime + 10;

waituntil
{

	//Every 1 second
	if (serverTime > _T1) then
	{
		[] call VCM_fnc_CoverControl;
		_T1 = serverTime + 1;
	};
	
	//Every 10 seconds
	if (serverTime > _T2) then
	{
		if (Vcm_ActivateAI) then
		{
			{
				if (local _x && {simulationEnabled (leader _x)} && {!(isplayer (leader _x))} && {(leader _x) isKindOf "Man"}) then 
				{
					private _Grp = _x;
						if !(_Grp in VcmAI_ActiveList) then //{!(VCM_SIDEENABLED findIf {_x isEqualTo (side _Grp)} isEqualTo -1)}
						{
							if !(((units _Grp) findIf {alive _x}) isEqualTo -1) then
							{
								_x call VCM_fnc_SquadExc;
							};
						};
				};
			} foreach allGroups;
		};
		_T2 = serverTime + 10;
	};	
	sleep 1;
	false;
};