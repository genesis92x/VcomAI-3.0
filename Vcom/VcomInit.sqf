
//Global actions compiles
Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
VCM_PublicScript = compileFinal "[] call (_this select 0);";
VCM_ServerAsk = compileFinal "if (isServer) then {publicvariable (_this select 0);};";

if !(isServer) exitWith {};

//Parameters
[] call compile preprocessFileLineNumbers "Vcom\Functions\VCOMAI_DefaultSettings.sqf"; //Load default settings
if (isFilePatchingEnabled && {"" != loadFile "\userconfig\VCOM_AI\AISettingsV4.hpp"}) then
{
	[] call compile preprocessFileLineNumbers "\userconfig\VCOM_AI\AISettingsV4.hpp"; //Overwrite with userconfig
};
[] call VCM_fnc_CBA_Settings; //Overwrite with CBA settings

//Mod checks
//ACE CHECK
if (not isNil "ACE_Medical_enableFor" && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;} else {VCM_MEDICALACTIVE = true;};

VCOM_MINEARRAY = [];
[] spawn VCM_fnc_MineMonitor;
[] spawn VCM_fnc_HANDLECURATORS;

[] spawn
{
	waitUntil {time > 2};
	sleep 2;
	
	//Begin Artillery function created by Rydygier - https://forums.bohemia.net/forums/topic/159152-fire-for-effect-the-god-of-war-smart-simple-ai-artillery/
	if (VCM_FFEARTILLERY) then {nul = [] execVM "Vcom\RYD_FFE\FFE.sqf";VCM_ARTYENABLE = false;};
	
	[] spawn VCM_fnc_AIDRIVEBEHAVIOR;
	
	//Below is loop to check for new AI spawning in to be added to the list
	while {true} do 
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
		sleep 10;
	};
};