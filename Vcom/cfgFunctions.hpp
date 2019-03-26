class VCOM
{
	tag = "VCM";
	
	// Initialization functions. These should only run once on startup.
	class Init
	{
		class VcomInit
		{
			file = "Vcom\VcomInit.sqf";
			postInit = 1;
		};
		class VcomInitClient
		{
			file = "Vcom\VcomInitClient.sqf";
			postInit = 1;
		};
		class CBA_Settings // Only executed if CBA is present
		{
			file = "Vcom\Functions\VCM_CBASettings.sqf";
		};
	};
	
	class FSM
	{
		file = "Vcom\FSMS";
		
		// group spawn VCM_fnc_SQUADBEH
		class SQUADBEH 
		{
			ext = ".fsm";
		};
		
		// [] spawn VCM_fnc_AIDRIVEBEHAVIOR
		class AIDRIVEBEHAVIOR
		{
			ext = ".fsm";
		};
		
		// [] spawn VCM_fnc_HANDLECURATORS
		class HANDLECURATORS
		{
			ext = ".fsm";
		};
		
		// unit spawn VCM_fnc_UNITSUPPRESSION
		class UNITSUPPRESSION
		{
			ext = ".fsm";
		};
	};
	
	// Generic functions
	class Functions 
	{
		file = "Vcom\Functions\VCM_Functions";
		
		// [string] call VCM_fnc_Classname;
		class Classname {};
		
		// [unit, weapon, muzzle, mode, ammo, magazine, bullet, gunner] call VCM_fnc_HearingAids;
		class HearingAids {};
		
		// group call VCM_fnc_KitChk;
		class KitChk {};
		
		// group call VCM_fnc_MedicalHandler
		class MedicalHandler {};
		
		// group call VCM_fnc_RMedics;
		class RMedics {};
		
		// group call VCM_fnc_RStatics;
		class RStatics {};
		
		// group call VCM_fnc_SquadExc;
		class SquadExc {};
		
		// group call VCM_fnc_WyptChk;
		class WyptChk {};	
		
		// unit call VCM_fnc_IsDriver;
		class IsDriver {};
		
		// group call VCM_fnc_GroupValue
		class GroupValue {};
	};
	
	// Artillery related functions. Deprecated
	class Artillery
	{
		file = "Vcom\Functions\VCM_Functions\artillery";
		
		// unit call VCM_fnc_CheckArty;
		class CheckArty {};
		
		// [callGroup, enemyGroup] call VCM_fnc_ArtyCall;
		class ArtyCall {};
		
		// group call VCM_fnc_ArtyManage;
		class ArtyManage {};
	};
	
	// Acttions that can be undertaken by groups/units
	class Actions
	{
		file = "Vcom\Functions\VCM_Functions\actions";
		
		// [unitToRearm, rearmLocation] spawn VCM_fnc_ActRearm
		class ActRearm {};
		
		// [group] call VCM_fnc_ArmStatics;
		class ArmStatics {};
		
		// [group, enemy] call VCM_fnc_ClearBuilding;
		class ClearBuilding {};
		
		// [unit, killer] call VCM_fnc_ClstWarn;
		class ClstWarn {};
		
		// unit call VCM_fnc_HealSelf;
		class HealSelf {};
		
		//[medic, injuredUnit] spawn VCM_fnc_MedicHeal;
		class MedicHeal {};
		
		// [gunner, backpackClassname, staticWeapon] call VCM_fnc_PackStatic;
		class PackStatic {};
		
		// group call VCM_fnc_RearmSelf;
		class RearmSelf {};
		
		// group call VCM_fnc_RqstReinforce
		class RqstReinforce {};
	};
	
	// Driving related functions
	class Driving
	{
		file = "Vcom\Functions\VCM_Functions\driving";
		
		//unit call VCM_fnc_VehicleDetection;
		class VehicleDetection {};
		
		//[unit,4] call VCM_fnc_MovePrediction;
		class MovePrediction {};
		
		//[] call VCM_fnc_UpdateDrivers;
		class UpdateDrivers {};
	};
	
	// Explosives related functions
	class Explosives
	{
		file = "Vcom\Functions\VCM_Functions\explosives";
		
		// unit call VCM_fnc_HasMine;
		class HasMine {};
		
		// [] spawn VCM_fnc_MineMonitor;
		class MineMonitor {};
		
		// [unit, mineArray] spawn VCM_fnc_MinePlant;
		class MinePlant {};
		
		// [unit, satchelArray] spawn VCM_fnc_SatchelPlant;
		class SatchelPlant {};
	};
	
	// Garrison related functions
	class Garrison
	{
		file = "Vcom\Functions\VCM_Functions\garrison";
		
		// group call VCM_fnc_GarrisonLight;
		class GarrisonLight {};
		
		// group spawn VCM_fnc_Garrison;
		class Garrison {};
		
		// group call VCM_fnc_UnGarrisonL;
		class UnGarrisonL {};
	};
	
	class Movement
	{
		file = "Vcom\Functions\VCM_Functions\movement";
		
		// [group, closestEnemy] call VCM_fnc_CQCMovement;
		class CQCMovement {};
		
		// [groupLeader, moveDistance] call VCM_fnc_ForceMove;
		class ForceMove {};
		
		// [groupLeader, moveDistance] call VCM_fnc_FindCover;
		class FindCover {};
		
		// unit call VCM_fnc_FrmChnge;
		class FrmChnge {};
		
		// [groupLeader] spawn VCM_fnc_FlankMove;
		class FlankMove {};
	};
	
	// Commands related to the task/situation that the AI is currently in
	class Situation_Framework
	{
		file = "Vcom\Functions\VCM_Functions\situation";
		
		// group call CheckSituation;
		class CheckSituation {};
		
		// group call SetCQC;
		class SetCQC {};
		
		// group call SetSituation;
		class SetSituation {};
	};
	
	// These functions are generally used to scan for nearby objects, units, groups, etc
	class Scanning
	{
		file = "Vcom\Functions\VCM_Functions\scanning";
		
		// [entity, unit] call VCM_fnc_BoxNrst;
		class BoxNrst {};
		
		// [array, unitToReveal, revealAmount, _revealLimit] call VCM_fnc_KnowAbout;
		class KnowAbout {};
		
		// group call VCM_fnc_CanReinforce
		class CanReinforce {};
		
		// unit call VCM_fnc_ClstEmy;
		class ClstEmy {};
		
		// [list, object, order, script] call VCM_fnc_ClstObj;
		class ClstObj {};
		
		// unit call VCM_fnc_EnemyArray;
		class EnemyArray {};
		
		// unit call VCM_fnc_KnownEnemyArray
		class KnownEnemyArray {};
		
		// unit call VCM_fnc_EnemyGroupArray
		class EnemyGroupArray {};
		
		// unit call VCM_fnc_KnownEnemyGroupArray
		class KnownEnemyGroupArray {};
		
		// unit call VCM_fnc_FriendlyArray;
		class FriendlyArray {};
		
		// [unit, boolean] call VCM_fnc_FriendlyGroupArray
		class FriendlyGroupArray {};
		
		// [] call VCM_fnc_IRCHECK;
		class IRCHECK {};
		
		// unit call VCM_fnc_HasRadio;
		class HasRadio {};
		
		// group call VCM_fnc_GroupHasRadio;
		class GroupHasRadio {};
		
		// [object, searchRadius, precision, sortingOrder] call VCM_fnc_Heights;
		class Heights {};
		
		// [group, searchDistance] call VCM_fnc_EmptyStatic;
		class EmptyStatic {};
	};
	
	// Suppression related functions
	class Suppression
	{
		file = "Vcom\Functions\VCM_Functions\suppression";
		
		// [unit, number] call VCM_fnc_AddSuppression;
		class AddSuppression {};
		
		// [unit, number] call VCM_fnc_AddSuppressionNow;
		class AddSuppressionNow {};
		
		// [unit, source, damage, instigator] call VCM_fnc_AIHIT;
		class AIHIT {};
		
		// _group call VCM_fnc_FSMGetSuppression;
		class FSMGetSuppression {};
		
		// _unit call VCM_fnc_GetSuppression
		class GetSuppression {};
		
		// _group call VCM_fnc_GroupGetSuppression;
		class GroupGetSuppression {};
		
		// _unit spawn VCM_fnc_SuppressionDebug;
		class SuppressionDebug {};
	};
};


class RYD
{
	// Fire For Effect: The God of War
	class FFE_Functions
	{
		file = "Vcom\Functions\FFE_Functions";
		class AngTowards {};
		class ArtyMission {};
		class ArtyPrep {};
		class AutoConfig {};
		class CFF {};
		class CFF_FFE {};
		class CFF_Fire {};
		class CFF_TGT {};
		class PosTowards2D {};
		class ShellsInRadius {};
	};
	class FFE_Shellview
	{
		file = "Vcom\Functions\FFE_Shellview";
		class Shellview {};
	};
};