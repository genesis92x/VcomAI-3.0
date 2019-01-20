
[
    "VCM_ActivateAI", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Vcom Active", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ActivateAI = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_Debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable Debug Mode. Mostly systemchat messages.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	false,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_Debug = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_SIDEENABLED", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    "Sides impacted by Vcom.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [[[west,east,resistance],[west,east],[west],[east],[resistance],[resistance,west],[resistance,east]],[["West, East, Resistance"],["West, East"],["West"],["East"],["Resistance"],["Resistance, West"],["Resistance, East"]],0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_SIDEENABLED = _this;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYENABLE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable AI use of Artillery", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ARTYENABLE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYSIDES", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "LIST", // setting type
    "Sides that will use FFE/VCOM Artillery", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [[[west,east,resistance],[west,east],[west],[east],[resistance],[resistance,west],[resistance,east]],[["West, East, Resistance"],["West, East"],["West"],["East"],["Resistance"],["Resistance, West"],["Resistance, East"]],0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ARTYSIDES = _this;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_StealVeh", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI steal empty/unlocked vehicles?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_StealVeh = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ForceSpeed", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enforce AI Speed 'FULL'?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_FullSpeed = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ADVANCEDMOVEMENT", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI generate new waypoints to flank.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ADVANCEDMOVEMENT = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_FRMCHANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI change formations based on location.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_FRMCHANGE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_AIDISTANCEVEHPATH", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI will steal vehicles from.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1000,100,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AIDISTANCEVEHPATH = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_RAGDOLL", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI Ragdoll when hit?", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_RAGDOLL = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_RAGDOLLCHC", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Chance for AI to ragdoll when hit.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,100,50,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_RAGDOLLCHC = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AIHEALING", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["VCOM handle healing", "Makes AI heal themselves without being ordered. Disabled when ACE medical for AI is active"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AIHEALING = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_HEARINGDISTANCE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI can hear gunfire.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1500,800,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_HEARINGDISTANCE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_WARNDIST", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Distance AI will call for reinforcements from.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,2500,1000,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_WARNDIST = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_WARNDELAY", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Time (seconds) AI wait before support called.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,300,30,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_WARNDELAY = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_STATICARMT", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Time (seconds) AI stay on unarmed Static Weapons", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,10000,300,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_STATICARMT = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_MINECHANCE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["AI mine placing chance", "This is checked every 30 seconds while in combat. 0 = disabled"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,100,10,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_MINECHANCE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_LGARRISONCHANCE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Chance for AI to temporarily garrison buildings", "This is checked every five minutes. 0 = Disabled."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,100,20,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_LGARRISONCHANCE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYDELAY", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Delay before artillery requests. SIDE BASED.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,5000,300,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ARTYDELAY = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_ARTYSPREAD", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "Spread, in meters, for artillery rounds.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,5000,400,0], // data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_ARTYSPREAD = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;


[
    "VCM_AIMagLimit", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Mag count AI begin to look for additional mags.","Set to 0 to disable"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,5,2,0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AIMagLimit = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////VCOM Driving Settings////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

[
    "VCM_DrivingActivated", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable Enhanced AI Driving (Experimental)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM DRIVING", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	false,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_DrivingActivated = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_DrivingDelay", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Script cycle time", "How often the script will look for obstacles"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM DRIVING", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.5,3,0.75,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_DrivingDelay = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_DrivingDist", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Distance to search for obstacles", "How far from predicted position to search for obstacles. Predicted position varies depending on vehicle speed."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM DRIVING", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [5,30,10,1], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_DrivingDist = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_DRIVERLIMIT", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["Driver execution limit", "How many drivers the code should run for at every cycle"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM DRIVING", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1,10,4,0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {  
        params ["_value"];
        VCM_DRIVERLIMIT = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////Ryd FFE settings/////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////

[
    "RydFFE_Active", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "FFE Active (Replaces VCOM Artillery)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		VCM_FFEARTILLERY = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_Debug", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "FFE Debug", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_Debug = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_FO_string", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "EDITBOX", // setting type
    ["FFE Forward Observer"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    "", // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_FO = [];
		{RydFFE_FO pushBack (missionNamespace getVariable _x)} forEach (_value splitstring ", ");
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_FOClass_string", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "EDITBOX", // setting type
    ["FFE Forward Observer Classes", "this array holds class names (lowercase only!) of leaders of groups, that will be automatically added to the RydFFE_FO array, if that array already is not empty (means if limited spotting is active)"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    "i_spotter_f, o_spotter_f, b_spotter_f, o_recon_jtac_f, b_recon_jtac_f, i_sniper_f, o_sniper_f, b_sniper_f, i_soldier_m_f, o_soldier_m_f, b_g_soldier_m_f, b_soldier_m_f, o_recon_m_f, b_recon_m_f, o_soldieru_m_f, i_uav_01_f, i_uav_02_cas_f, i_uav_02_f, o_uav_01_f, o_uav_02_cas_f, o_uav_02_f, b_uav_01_f, b_uav_02_cas_f, b_uav_02_f", // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_FOClass = _value splitstring ", ";
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_OnePhase", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["FFE One Phase", "By default, spotters will fire 1/6 of salvo as adjustment salvo, with the next one being 'Fire For Effect'. Enabling this skips that."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_OnePhase = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_2PhWithoutFO", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["FFE Two Phase without Forward Observer", "Will fire in two phase mode also in 'Unlimited Spotting Mode', as described above."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_2PhWithoutFO = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_Acc", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["FFE Accuracy", "Multiplier of whole salvo drift radius. The bigger value, the bigger the radius."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 4, 2, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_Acc = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_Safe", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["FFE Safe Zone", "Salvo will be not planned for coordinates located within this radius (in meters) around any allied group leader."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [20, 300, 100, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_Safe = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_Monogamy", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["FFE Monogamy", "Each group can only be targeted by one battery."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    true, // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_Monogamy = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_Amount", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "FFE Barrage Size", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [1, 12, 6, 0], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_Amount = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_ShellView", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["FFE Shellview", "if set to true, in debug mode there is available a tool, that allows to watch shells during their flight marked with orange “drops” in chosen meter radius around position clicked (LMB) on map. Shift + LMB removes that watching circle"], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    false, // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_ShellView = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "RydFFE_FoAccGain", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    ["FFE Forward Observer Accuracy Gain", "Additional accuracy multiplier in second, FFE step of fire mission due to adjustments after first step. The lesser value, the greater accuracy, must be not negative. It is multiplied by spotter adjustments factor for FFE stage: (0.2 + (random 0.2)) that changes salvo drift radius."], // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "Fire For Effect", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0.5,3,1,1], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
		RydFFE_FoAccGain = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//AI SKILL SETTINGS
[
    "VCM_SKILLCHANGE", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "AI impacted by Vcom skill settings.", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	  true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_SKILLCHANGE = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_SIDESPECIFICSKILL", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    "Enable Side Specific Skill Parameters", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
	  true,// data for this setting:
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_SIDESPECIFICSKILL = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//Aiming Accuracy
[
    "VCM_AISKILL_AIMINGACCURACY_W", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Accuracy (West)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.25,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGACCURACY_W = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AISKILL_AIMINGACCURACY_E", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Accuracy (East)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.25,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGACCURACY_E = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AISKILL_AIMINGACCURACY_R", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Accuracy (Ind)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.25,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGACCURACY_R = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//Aiming Shake
[
    "VCM_AISKILL_AIMINGSHAKE_W", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Shake (West)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.15,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGSHAKE_W = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AISKILL_AIMINGSHAKE_E", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Shake (East)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.15,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGSHAKE_E = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AISKILL_AIMINGSHAKE_R", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Shake (Ind)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.15,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGSHAKE_R = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//Aiming Speed
[
    "VCM_AISKILL_AIMINGSPEED_W", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Speed (West)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.35,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGSPEED_W = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AISKILL_AIMINGSPEED_E", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Speed (East)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.35,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGSPEED_E = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

[
    "VCM_AISKILL_AIMINGSPEED_R", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "SLIDER", // setting type
    "AI Aiming Speed (Ind)", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
    "VCOM SKILL SETTINGS", // Pretty name of the category where the setting can be found. Can be stringtable entry.
    [0,1,0.35,2], // data for this setting: [min, max, default, number of shown trailing decimals]
    true, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
    {
        params ["_value"];
        VCM_AISKILL_AIMINGSPEED_R = _value;
    } // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

diag_log "VCOM: Loaded CBA settings";
