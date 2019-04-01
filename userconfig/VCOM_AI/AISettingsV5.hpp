
/*
	ADDITIONAL COMMANDS
	(group this) setVariable ["VCM_NOFLANK",true]; //This command will stop the AI squad from executing advanced movement maneuvers.
	(group this) setVariable ["VCM_NORESCUE",true]; //This command will stop the AI squad from responding to calls for backup.
	(group this) setVariable ["VCM_TOUGHSQUAD",true]; //This command will stop the AI squad from calling for backup.
	(group this) setVariable ["Vcm_Disable",true]; //This command will disable Vcom AI on a group entirely.
	(group this) setVariable ["VCM_DisableForm",true]; //This command will disable AI group from changing formations.
	(group this) setVariable ["VCM_Skilldisable",true]; //This command will disable an AI group from being impacted by Vcom AI skill changes.
*/
/*
	If any of these are left blank, then default settings will be used as defined in CfgVcomSettings
	Priority is as follows:
	mission set variables > userconfig > description.ext > config.cpp
*/

VCM_ACTIVE = true; // Set to false to disable VCOM. Can be reenabled by changing to true
VCM_SUPPRESS = true; //Set to false to disable AI suppression system
VCM_MAGLIMIT = 2; //Number of mags remaining before AI looks for ammo.
VCM_DEBUG = false; //Enable debug mode.
VCM_MINECHNC = 10; //Chance to lay a mine
VCM_LGARR = 20; //Chance to perform a temporary garrison. 0 = disabled

//Fire For Effect Artillery handling. Only one kind of advanced artillery can be used at a time. - https://forums.bohemia.net/forums/topic/159152-fire-for-effect-the-god-of-war-smart-simple-ai-artillery/
VCM_FFE = true;

VCM_SIDES = [west,east,resistance]; //Sides VCOM will affect. civilian can be added if they are hostile
VCM_RGDL = 50; //CHANCE AI RAGDOLL
VCM_HEALING = true; //Makes AI heal themselves
VCM_FULLSPEED = true; //Enforce full speedmode during combat (Does not reset after combat end)
VCM_HEARDIST = 800; //Distance AI hear unsuppressed gunshots.
VCM_WARNDIST = 1000; //How far AI can request help from other groups.
VCM_WARNDELAY = 30; //How long the AI have to survive before they can call in for support. This activates once the AI enter combat.
VCM_STATICARMT = 300; //How long AI stay on static weapons when initially arming them. This is just for AI WITHOUT static bags. They will stay for this duration when NO ENEMIES ARE SEEN, or their group gets FAR away.
VCM_STEAL = true; //Will the AI steal vehicles.
VCM_STEALDIST = 100; //Distance AI check from the squad leader to steal vehicles
VCM_WPGEN = true; //True means AI will actively generate waypoints if no other waypoints are generated for the AI group (2 or more). False disables this advanced movements.
VCM_FRMCHNG = true; //AI GROUPS WILL CHANGE FORMATIONS TO THEIR BEST GUESS.
VCM_SKILLCHNG = true; //AI Groups will have their skills changed by Vcom.

//VCOM DRIVING. Experimental feature

VCM_DRIVING = false; //Set this to false to disable VcomAI driving from executing.
VCM_DDIST = 10; // Distance from predicted path to search for objects. High numbers may cause instability.
VCM_DDELAY = 0.75; // How often the script should look for obstacles
VCM_DLIMIT = 4; // How many drivers should be calculated at each cycle

//VCOM Skill Settings
VCM_SKILLCHNG = true; // Whether VCOM should change skills

// 100 = highest, 0 = lowest
// Format = [aimingAccuracy, aimingShake, aimingSpeed, commanding, courage, endurance, general, reloadSpeed, spotDistance, spotTime]
//VCM_SKILL = [15, 10, 25, 100, 100, 100, 100, 100, 100, 85, 85]; // Low preset
VCM_SKILL = [25, 15, 35, 100, 100, 100, 100, 100, 100, 85, 85]; // Medium prest
//VCM_SKILL = [35, 40, 45, 100, 100, 100, 100, 100, 100, 85, 85]; // High preset

VCM_SIDESKILL = false; // Whether VCOM should change skills based on side.
// Overwrites VCM_SKILLCHNG
VCM_WESTSKILL = [25, 15, 35, 100, 100, 100, 100, 100, 100, 85, 85];
VCM_EASTSKILL = [25, 15, 35, 100, 100, 100, 100, 100, 100, 85, 85];
VCM_INDSKILL = [25, 15, 35, 100, 100, 100, 100, 100, 100, 85, 85];
VCM_CIVSKILL = [25, 15, 35, 100, 100, 100, 100, 100, 100, 85, 85];

VCM_CLASSSKILL = false; // Whether VCOM should change skills based on classname.
// Overwrites both of the above
VCM_SKILLCLASSES = [["B_Story_SF_Captain_F", 35, 40, 45, 100, 100, 100, 100, 100, 85, 85]];

diag_log "VCOM: Loaded Userconfig";
