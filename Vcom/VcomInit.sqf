//Parameters
VCM_PublicScript = compileFinal "[] call (_this select 0);";
VCM_ServerAsk = compileFinal "(_this select 1) publicVariableClient (_this select 0);";

if (isServer) then {

	if (isFilePatchingEnabled) then {
		private _fileCheck = loadFile "\userconfig\VCOM_AI\AISettingsV3.hpp";

		if !(_fileCheck isEqualTo "") then {
			[] call compile preprocessFileLineNumbers "\userconfig\VCOM_AI\AISettingsV3.hpp";
			[VCM_Settings] remoteExec ["VCM_PublicScript", 0, false];
		} else {
			[] call compile preprocessFileLineNumbers "Vcom\Functions\VCOMAI_DefaultSettings.sqf";
			[VCM_Settings] remoteExec ["VCM_PublicScript", 0, false];
		};
	} else {
		[] call compile preprocessFileLineNumbers "Vcom\Functions\VCOMAI_DefaultSettings.sqf";
		[VCM_Settings] remoteExec ["VCM_PublicScript", 0, false];
	};
} else {
	["Vcm_Settings", clientOwner] remoteExec ["VCM_ServerAsk", 2, false];

	waitUntil {!isNil "VCM_Settings"};
	[] call VCM_Settings;
};

waitUntil {!(isNil "VCM_AIMagLimit")};

//Mod Checks
if (!isNil "ACE_Medical_enableFor" && ACE_Medical_enableFor isEqualTo 1) then {VCM_MEDICALACTIVE = false} else {VCM_MEDICALACTIVE = true};
if (isClass (configFile >> "CfgPatches" >> "cba_main")) then {CBAACT = true} else {CBAACT = false};

//Global actions compiles
VCM_PMN = compileFinal "(_this select 0) playMoveNow (_this select 1);";
VCM_SM = compileFinal "(_this select 0) switchMove (_this select 1);";
VCM_PAN = compileFinal "(_this select 0) playActionNow (_this select 1);";
VCOM_MINEARRAY = [];

//OnEachFrame monitor for mines. Should make them more responsive, without a significant impact on FPS.
["VCMMINEMONITOR", "onEachFrame", {[] call VCM_fnc_MineMonitor}] call BIS_fnc_addStackedEventHandler;

[] spawn {
	if (hasInterface) then {
		//Event handlers for players
		player addEventHandler ["Fired",{_this call VCM_fnc_HearingAids;}];
		player spawn VCM_fnc_IRCHECK;
		player addEventHandler ["Respawn",{_this spawn VCM_fnc_IRCHECK;}];
	};

	while {true} do {
		if (VCM_ActivateAI) then {
			{
				if (!isPlayer leader _x && simulationEnabled leader _x) then {
					if !(_x in VcmAI_ActiveList) then {
						if !(units _x isEqualTo []) then {
							_x call VCM_fnc_SquadExc;
						};
					};
				};
			} foreach allGroups;
		};
		sleep 10;
	};
};
