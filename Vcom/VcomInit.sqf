if (!isNil "VCMINITHANDLE" && {!scriptDone VCMINITHANDLE}) exitWith {};

//Global actions compiles
Vcm_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
Vcm_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
Vcm_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
VCM_PublicScript = compileFinal "[] call (_this select 0);";
VCM_ServerAsk = compileFinal "if (isServer) then {publicvariable (_this select 0);};";
VcmAI_ActiveList = []; //Leave this alone.

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


//Mod checks
//ACE CHECK
if (not isNil "ACE_Medical_enableFor" && {ACE_Medical_enableFor isEqualTo 1}) then {VCM_MEDICALACTIVE = false;} else {VCM_MEDICALACTIVE = true;};

VCOM_MINEARRAY = [];
[] spawn VCM_fnc_MineMonitor;
[] spawn VCM_fnc_HANDLECURATORS;

VCMINITHANDLE = [] spawn
{
	waitUntil {time > 2};
	sleep 5;
	if (isNil "VCM_SETTINGS" || {VCM_SETTINGS isEqualTo false}) then {[] call VCM_fnc_LoadConfig};
	
	//Begin Artillery function created by Rydygier - https://forums.bohemia.net/forums/topic/159152-fire-for-effect-the-god-of-war-smart-simple-ai-artillery/
	if (VCM_FFE) then {VCM_FFEHANDLE = [] spawn (compile preprocessFileLineNumbers "Vcom\RYD_FFE\FFE.sqf");};
	
	[] spawn VCM_fnc_AIDRIVEBEHAVIOR;
	
	//Below is loop to check for new AI spawning in to be added to the list
	while {true} do 
	{
		waitUntil {VCM_ACTIVE};
		
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
					_grp spawn VCM_fnc_SQUADTACTICS;
				};
			};
		} foreach allGroups;
		
		sleep 15;
	};
};