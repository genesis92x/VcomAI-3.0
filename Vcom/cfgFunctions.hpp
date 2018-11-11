class VCOM
{
	tag = "VCM";
	class Functions 
	{
		file = "Vcom\Functions\VCM_Functions";
		//[] call VCM_fnc_SquadExc
		class SquadExc {};
		//[] call VCM_fnc_KitChk
		class KitChk {};	
		//[] call VCM_fnc_RMedics
		class RMedics {};
		//[] call VCM_fnc_RStatics
		class RStatics {};
		//[] call VCM_fnc_HasMine
		class HasMine {};
		//[] call VCM_fnc_Classname
		class Classname {};			
		// [] call VCM_fnc_CheckArty
		class CheckArty {};
		//[] call VCM_fnc_RearmSelf
		class RearmSelf {};
		//[] spawn VCM_fnc_ActRearm
		class ActRearm {};
		//[] spawn VCM_fnc_Garrison
		class Garrison {};
		//[] call VCM_fnc_ClstEmy
		class ClstEmy {};
		//[] call VCM_fnc_ClstObj
		class ClstObj {};
		//[] call VCM_fnc_BoxNrst
		class BoxNrst {};
		//[] call VCM_fnc_FindCover
		class FindCover {};
		//[] spawn VCM_fnc_FlankMove
		class FlankMove {};
		//[] call VCM_fnc_Heights
		class Heights {};
		//[] call VCM_fnc_GarrisonLight {};
		class GarrisonLight {};
		//[] call VCM_fnc_PackStatic {};
		class PackStatic {};
		//[] spawn VCM_fnc_SatchelPlant {};
		class SatchelPlant {};
		//[] spawn VCM_fnc_MinePlant {};
		class MinePlant {};
		//[] call VCM_fnc_EmptyStatic {};
		class EmptyStatic {};
		//[] call VCM_fnc_ArmStatics {};
		class ArmStatics {};
		//[] call VCM_fnc_ArtyManage {};
		class ArtyManage {};
		//[] call VCM_fnc_ArtyCall {};
		class ArtyCall {};
		//[] call VCM_fnc_AIHIT {};
		class AIHIT {};
		//[] call VCM_fnc_HearingAids {};
		class HearingAids {};
		//[] call VCM_fnc_EnemyArray {};
		class EnemyArray {};
		//[] call VCM_fnc_ClstWarn {};
		class ClstWarn {};
		//[] call VCM_fnc_FriendlyArray {};
		class FriendlyArray {};
		//[] call VCM_fnc_WyptChk {};
		class WyptChk {};
		//[] call VCM_fnc_FrmChnge {};
		class FrmChnge {};
		//[] call VCM_fnc_ForceMove
		class ForceMove {};
		//[] call VCM_fnc_ClearBuilding {};
		class ClearBuilding {};
		//[] call VCM_fnc_IRCHECK {};
		class IRCHECK {};
		//[] call VCM_fnc_KnowAbout
		class KnowAbout {};
		//[] spawn VCM_fnc_MineMonitor;
		class MineMonitor {};		
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