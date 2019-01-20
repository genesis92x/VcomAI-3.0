class VCOM
{
	tag = "VCM";
	
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
		class CBA_Settings
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
	};
	
	class Functions 
	{
		file = "Vcom\Functions\VCM_Functions";
		
		// [unitToRearm, rearmLocation] spawn VCM_fnc_ActRearm
		class ActRearm {};
		
		// [unit, source, damage, instigator] call VCM_fnc_AIHIT;
		class AIHIT {};
		
		// [group] call VCM_fnc_ArmStatics;
		class ArmStatics {};
		
		// [callGroup, enemyGroup] call VCM_fnc_ArtyCall;
		class ArtyCall {};
		
		// group call VCM_fnc_ArtyManage;
		class ArtyManage {};
		
		// [entity, unit] call VCM_fnc_BoxNrst;
		class BoxNrst {};
		
		// unit call VCM_fnc_CheckArty;
		class CheckArty {};
		
		// [string] call VCM_fnc_Classname;
		class Classname {};
		
		// [group, enemy] call VCM_fnc_ClearBuilding;
		class ClearBuilding {};
		
		// unit call VCM_fnc_ClstEmy;
		class ClstEmy {};
		
		// [list, object, order, script] call VCM_fnc_ClstObj;
		class ClstObj {};
		
		// [unit, killer] call VCM_fnc_ClstWarn;
		class ClstWarn {};
		
		// [group, searchDistance] call VCM_fnc_EmptyStatic;
		class EmptyStatic {};
		
		// unit call VCM_fnc_EnemyArray;
		class EnemyArray {};
		
		// [groupLeader, moveDistance] call VCM_fnc_FindCover;
		class FindCover {};
		
		// [groupLeader] spawn VCM_fnc_FlankMove;
		class FlankMove {};
		
		// [groupLeader, moveDistance] call VCM_fnc_ForceMove;
		class ForceMove {};
		
		// unit call VCM_fnc_FriendlyArray;
		class FriendlyArray {};
		
		// unit call VCM_fnc_FrmChnge;
		class FrmChnge {};
		
		// group spawn VCM_fnc_Garrison;
		class Garrison {};
		
		// group call VCM_fnc_GarrisonLight;
		class GarrisonLight {};
		
		// unit call VCM_fnc_HasMine;
		class HasMine {};
		
		// unit call VCM_fnc_HealSelf;
		class HealSelf {};
		
		// [unit, weapon, muzzle, mode, ammo, magazine, bullet, gunner] call VCM_fnc_HearingAids;
		class HearingAids {};
		
		// [object, searchRadius, precision, sortingOrder] call VCM_fnc_Heights;
		class Heights {};
		
		// [] call VCM_fnc_IRCHECK;
		class IRCHECK {};
		
		// group call VCM_fnc_KitChk;
		class KitChk {};
		
		// [array, unitToReveal, revealAmount, _revealLimit] call VCM_fnc_KnowAbout;
		class KnowAbout {};
		
		// group call VCM_fnc_MedicalHandler
		class MedicalHandler {};
		
		//[medic, injuredUnit] spawn VCM_fnc_MedicHeal;
		class MedicHeal {};
		
		// [] spawn VCM_fnc_MineMonitor;
		class MineMonitor {};
		
		// [unit, mineArray] spawn VCM_fnc_MinePlant;
		class MinePlant {};
		
		// [gunner, backpackClassname, staticWeapon] call VCM_fnc_PackStatic;
		class PackStatic {};
		
		// group call VCM_fnc_RearmSelf;
		class RearmSelf {};
		
		// group call VCM_fnc_RMedics;
		class RMedics {};
		
		// group call VCM_fnc_RStatics;
		class RStatics {};
		
		// [unit, satchelArray] spawn VCM_fnc_SatchelPlant;
		class SatchelPlant {};
		
		// group call VCM_fnc_SquadExc;
		class SquadExc {};
		
		// group call VCM_fnc_WyptChk;
		class WyptChk {};	
		
		// unit call VCM_fnc_IsDriver;
		class IsDriver {};			

		//unit call VCM_fnc_VehicleDetection;
		class VehicleDetection {};
		
		//[unit,4] call VCM_fnc_MovePrediction;
		class MovePrediction {};
		
		//[] call VCM_fnc_UpdateDrivers;
		class UpdateDrivers {};
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