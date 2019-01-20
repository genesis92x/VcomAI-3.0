if !(hasInterface) exitWith {};

[] spawn
{
	sleep 2;

	//Event handlers for players	
	player addEventHandler ["Fired",{_this call VCM_fnc_HearingAids;}];
	player spawn VCM_fnc_IRCHECK;
	player addEventHandler ["Respawn",{_this spawn VCM_fnc_IRCHECK;}];
};