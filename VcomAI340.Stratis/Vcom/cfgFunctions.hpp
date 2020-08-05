class VCOM
{
	tag = "VCM";
	
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
		
		// [] spawn VCM_fnc_PLAYERSQUAD
		class PLAYERSQUAD
		{
			ext = ".fsm";
		};		
		
	};
	
	class Functions 
	{
		file = "Vcom\Functions\VCM_Functions";
		
		//[] spawn VCM_fnc_VcomInit;
		class VcomInit {};
		
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
		
		// [groupLeader] call VCM_fnc_FindCover;
		class FindCover {};
		
		// [groupLeader] spawn VCM_fnc_FlankMove;
		class FlankMove {};
		
		// [groupLeader] call VCM_fnc_ForceMove;
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
		
		// [array, unitToReveal, revealAmount] call VCM_fnc_KnowAbout;
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
		
		//group call VCM_fnc_VehicleCommandeer;
		class vehiclecommandeer {};
		
		//group call VCM_fnc_VehicleCheck;
		class VehicleCheck {};

		//group call VCM_fnc_VehicleMove;
		class VehicleMove {};	

		//group call VCM_fnc_IsTransport;
		class IsTransport {};

		//[_pos,_dist,_params] call VCM_fnc_isFlatEmpty;
		class isFlatEmpty {};	

		//[] call VCM_fnc_CBASettings;
		class CBASettings {};
		
		//[] call VCM_fnc_SniperList
		class SniperList {};
		
		//[] spawn VCM_fnc_SniperEngage;
		class SniperEngage;
		
		//[] spawn VCM_fnc_RangeEngage;
		class RangeEngage;

		//[] call VCM_fnc_ClstKnwnEnmy;
		class ClstKnwnEnmy;

		// unit call VCM_fnc_IsDriver;
		class IsDriver {};			

		//unit call VCM_fnc_VehicleDetection;
		class VehicleDetection {};
		
		//[unit,4] call VCM_fnc_MovePrediction;
		class MovePrediction {};
		
		//[] call VCM_fnc_UpdateDrivers;
		class UpdateDrivers {};

		//[] call VCM_fnc_IdleAnimations;
		class IdleAnimations {};
		
		//[] call VCM_fnc_CoverDetect;
		class CoverDetect {};
		
		//[] call VCM_fnc_CoverControl;
		class CoverControl {};
				
		//[] call VCM_fnc_Scheduler;
		class Scheduler {};
		
		//[AIArray] call VCM_fnc_ResetAnimation;
		class ResetAnimation {};
		
		//[AI,TRUE] call VCM_fnc_ForceGrenadeFire; //0 = Unit to throw the grenade 1=true, throw grenade, false, throw smoke 
		class ForceGrenadeFire {};
		
		//[Unit,"Text"] call VCM_fnc_DebugText;
		class DebugText {};
		
		//[squadleader] call VCM_fnc_AISpeed;
		class AISpeed {};
				
		//[_StaticList] call VCM_fnc_StaticCheck;
		class StaticCheck {};
		
		//[_Unit,_Pos OR Obj] spawn VCM_fnc_DebugLine;
		class DebugLine {};
				
		//[_unit, true] spawn VCM_fnc_BabeOver; 
		class BabeOver {};
		
		//_Group spawn VCM_fnc_UseEM;
		class UseEM {};
		
		//["_Unit","_Array"] spawn VCM_fnc_3DPathDebug;
		class 3DPathDebug {};
	};		

};