if (!isNil "VCMINITHANDLE" && {!scriptDone VCMINITHANDLE}) exitWith {};

//Global actions compiles
Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
VCM_PublicScript = compileFinal "[] call (_this select 0);";
VCM_ServerAsk = compileFinal "if (isServer) then {publicvariable (_this select 0);};";


/*
Reasoning for removal: It's best to have Vcom running for ALL clients. Vcom was designed from the ground up to ONLY run on AI LOCAL to the machine running the commands. This enables HC support, hotswapping of AI between CPUS, and better consistency over several hours with multiple disconnects/changes of HC's or AI owners.

if 
!(
	isServer || 
	!hasInterface || 
	allCurators findIf {getAssignedCuratorUnit _x == player} == -1
) exitWith {};
*/

//Parameters
[] call compile preprocessFileLineNumbers "Vcom\Functions\VCOMAI_DefaultSettings.sqf"; //Load default settings
if (isFilePatchingEnabled && {"" != loadFile "\userconfig\VCOM_AI\AISettingsV4.hpp"}) then
{
	[] call compile preprocessFileLineNumbers "\userconfig\VCOM_AI\AISettingsV4.hpp"; //Overwrite with userconfig
};
if (isClass (configfile >> "CfgPatches" >> "cba_settings")) then {[] call VCM_fnc_CBA_Settings}; //Overwrite with CBA settings

//Mod checks
//ACE CHECK
if (not isNil "ACE_Medical_enableFor" && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;} else {VCM_MEDICALACTIVE = true;};

VCOM_MINEARRAY = [];
[] spawn VCM_fnc_MineMonitor;
[] spawn VCM_fnc_HANDLECURATORS;

VCMINITHANDLE = [] spawn
{
	waitUntil {time > 2};
	sleep 2;
	
	//Begin Artillery function created by Rydygier - https://forums.bohemia.net/forums/topic/159152-fire-for-effect-the-god-of-war-smart-simple-ai-artillery/
	if (VCM_FFEARTILLERY) then {VCM_FFEHANDLE = [] spawn (compile preprocessFileLineNumbers "Vcom\RYD_FFE\FFE.sqf");VCM_ARTYENABLE = false;};
	
	[] spawn VCM_fnc_AIDRIVEBEHAVIOR;
	
	//Below is loop to check for new AI spawning in to be added to the list
	while {true} do 
	{
		waitUntil {Vcm_ActivateAI};
		
		{
			private _fsmHandle = _x getVariable "VCM_SQUADFSM";
			if 
			(
				(isNil {completedFSM _fsmHandle} || {completedFSM _fsmHandle}) && 
				{local _x} && 
				{simulationEnabled (leader _x)} && 
				{(units _x) findIf {isPlayer _x} isEqualTo -1} && 
				{(leader _x) isKindOf "Man"}
			) then
			{
				private _grp = _x;
				if !(((units _grp) findIf {alive _x}) isEqualTo -1) then
				{
					_grp spawn VCM_fnc_SQUADBEH;
				};
			};
		} foreach allGroups;
		
		
		//This system is definitely a cool idea - however running an FSM per AI is going to be heavy. I would like to take a further look into performance impact.
		if (VCM_SUPPRESSACTIVE) then
		{
			{
				private _fsmHandle = _x getVariable "VCMSUPPRESSION";
				if
				(
					(isNil {completedFSM _fsmHandle} || {completedFSM _fsmHandle}) &&
					{isNull objectParent _x} &&
					{local _x} &&
					{simulationEnabled _x} &&
					{!isPlayer _x} &&
					{_x isKindOf "Man"} &&
					{alive _x}
				) then
				{
					_x spawn VCM_fnc_UNITSUPPRESSION;
				};
			} foreach allUnits;
		};
		
		sleep 15;
	};
};