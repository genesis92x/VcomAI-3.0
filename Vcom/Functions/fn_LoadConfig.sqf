params [["_preInit", ""]];
if (!isServer && _preInit isEqualTo "preInit") exitWith {};

VCM_ACTIVE = 		["CfgVcomSettings", "VcomActive"] call BIS_fnc_getCfgDataBool;
VCM_DEBUG = 		["CfgVcomSettings", "Debug"] call BIS_fnc_getCfgDataBool;
VCM_SIDES = 		["CfgVcomSettings", "EnabledSides"] call BIS_fnc_getCfgDataArray;
VCM_SUPPRESS = 	["CfgVcomSettings", "SuppressionActive"] call BIS_fnc_getCfgDataBool;
VCM_HEALING = 		["CfgVcomSettings", "HealingActive"] call BIS_fnc_getCfgDataBool;
VCM_WPGEN = 		["CfgVcomSettings", "WaypointGeneration"] call BIS_fnc_getCfgDataBool;
VCM_FRMCHNG = 		["CfgVcomSettings", "FormationChange"] call BIS_fnc_getCfgDataBool;
VCM_FFE = 			["CfgVcomSettings", "FFEArtillery"] call BIS_fnc_getCfgDataBool;
VCM_FULLSPEED = 	["CfgVcomSettings", "FullSpeed"] call BIS_fnc_getCfgDataBool;
VCM_MAGLIMIT = 	["CfgVcomSettings", "MagLimit"] call BIS_fnc_getCfgData;
VCM_MINECHNC = 	["CfgVcomSettings", "MineChance"] call BIS_fnc_getCfgData;
VCM_LGARR = 		["CfgVcomSettings", "LightGarrisonChance"] call BIS_fnc_getCfgData;
VCM_RGDL = 			["CfgVcomSettings", "RagdollChance"] call BIS_fnc_getCfgData;
VCM_STEAL = 		["CfgVcomSettings", "VehicleStealing"] call BIS_fnc_getCfgDataBool;
VCM_STEALDIST = 	["CfgVcomSettings", "StealingDistance"] call BIS_fnc_getCfgData;
VCM_STEALCLASS = 	["CfgVcomSettings", "VehicleStealClassnames"] call BIS_fnc_getCfgDataBool;
VCM_HEARDIST = 	["CfgVcomSettings", "HearingDistance"] call BIS_fnc_getCfgData;
VCM_WARNDIST = 	["CfgVcomSettings", "WarnDistance"] call BIS_fnc_getCfgData;
VCM_WARNDELAY = 	["CfgVcomSettings", "WarnDelay"] call BIS_fnc_getCfgData;
VCM_STATICARMT = 	["CfgVcomSettings", "StaticArmTime"] call BIS_fnc_getCfgData;

VCM_DRIVING = 		["CfgVcomSettings", "DrivingActivate"] call BIS_fnc_getCfgDataBool;
VCM_DLIMIT = 		["CfgVcomSettings", "DriverLimit"] call BIS_fnc_getCfgData;
VCM_DDELAY = 		["CfgVcomSettings", "DrivingDelay"] call BIS_fnc_getCfgData;
VCM_DDIST = 		["CfgVcomSettings", "DrivingDist"] call BIS_fnc_getCfgData;


VCM_SKILLCHNG = 	["CfgVcomSettings", "SkillPresets", "Active"] call BIS_fnc_getCfgDataBool;
VCM_SKILL = [];
if VCM_SKILLCHNG then
{
	VCM_SPRESET = ["CfgVcomSettings", "SkillPresets", "SkillPreset"] call BIS_fnc_getCfgData;
	{
		VCM_SKILL pushBack (0.01 * (["CfgVcomSettings", "SkillPresets", VCM_SPRESET, _x] call BIS_fnc_getCfgData));
	} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
};

VCM_SIDESKILL = ["CfgVcomSettings", "SkillPresets", "SideSkill", "Active"] call BIS_fnc_getCfgDataBool;
VCM_WESTSKILL = [];
VCM_EASTSKILL = [];
VCM_INDSKILL = [];
if VCM_SIDESKILL then
{
	{
		VCM_WESTSKILL pushBack (0.01 * (["CfgVcomSettings", "SkillPresets", "SideSkill", "west", _x] call BIS_fnc_getCfgData));
	} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
	{
		VCM_EASTSKILL pushBack (0.01 * (["CfgVcomSettings", "SkillPresets", "SideSkill", "east", _x] call BIS_fnc_getCfgData));
	} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
	{
		VCM_INDSKILL pushBack (0.01 * (["CfgVcomSettings", "SkillPresets", "SideSkill", "resistance", _x] call BIS_fnc_getCfgData));
	} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
};

VCM_CLASSSKILL = ["CfgVcomSettings", "SkillPresets", "classnameSkill", "Active"] call BIS_fnc_getCfgDataBool;
VCM_SKILLCLASSES = [];
if VCM_CLASSSKILL then
{
	{
		private _arr = [_x];
		private _class = _x;
		{
			_arr pushBack (0.01 * (["CfgVcomSettings", "SkillPresets", "classnameSkill", "_class", _x] call BIS_fnc_getCfgData));
		} forEach ["aimingAccuracy", "aimingShake", "aimingSpeed", "commanding", "courage", "endurance", "general", "reloadSpeed", "spotDistance", "spotTime"];
		VCM_SKILLCLASSES pushBack _arr;
	} forEach (["CfgVcomSettings", "SkillPresets", "classnameSkill"] call BIS_fnc_getCfgSubClasses);
};

diag_log "VCOM: Loaded config";

if (isFilePatchingEnabled && {"" != loadFile "\userconfig\VCOM_AI\AISettingsV5.hpp"}) then
{
	[] call compile preprocessFileLineNumbers "\userconfig\VCOM_AI\AISettingsV5.hpp"; //Overwrite with userconfig
};

{
	if (_x isEqualType 0) then
	{
		VCM_SIDES set [_forEachIndex, _x call BIS_fnc_sideType];
	};
} forEach VCM_SIDES;

if (_preInit isEqualTo "preInit") then {
	publicVariable "VCM_ACTIVE";
	publicVariable "VCM_DEBUG";
	publicVariable "VCM_SIDES";
	publicVariable "VCM_SUPPRESS";
	publicVariable "VCM_HEALING";
	publicVariable "VCM_WPGEN";
	publicVariable "VCM_FRMCHNG";
	publicVariable "VCM_FFE";
	publicVariable "VCM_FULLSPEED";
	publicVariable "VCM_MAGLIMIT";
	publicVariable "VCM_MINECHNC";
	publicVariable "VCM_LGARR";
	publicVariable "VCM_RGDL";
	publicVariable "VCM_STEAL";
	publicVariable "VCM_STEALDIST";
	publicVariable "VCM_STEALCLASS";
	publicVariable "VCM_HEARDIST";
	publicVariable "VCM_WARNDIST";
	publicVariable "VCM_WARNDELAY";
	publicVariable "VCM_STATICARMT";
	publicVariable "VCM_SKILLCHNG";
	publicVariable "VCM_SPRESET";
	publicVariable "VCM_SKILL";
	publicVariable "VCM_SIDESKILL";
	publicVariable "VCM_WESTSKILL";
	publicVariable "VCM_EASTSKILL";
	publicVariable "VCM_INDSKILL";
	publicVariable "VCM_CLASSSKILL";
	publicVariable "VCM_SKILLCLASSES";
	publicVariable "VCM_DRIVING";
	publicVariable "VCM_DLIMIT";
	publicVariable "VCM_DDELAY";
	publicVariable "VCM_DDIST";

	VCM_SETTINGS = true;
	publicVariable "VCM_SETTINGS";

	diag_log "VCOM: Pushed variables to clients";
};