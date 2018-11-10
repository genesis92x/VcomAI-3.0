//Function that executes when AI are hit.
params ["_unit", "_source", "_damage", "_instigator"];
if !(isNull objectParent _unit) exitWith {};

//Lay down
if (unitPos _unit == "AUTO") then
{
	_unit setUnitPos "DOWN";
	_unit spawn {sleep 30; _this setUnitPos "AUTO";};
};

if (VCM_RAGDOLL && {_damage > 0.1} && {_unit distance2D _instigator > 20} && {lifestate _unit != "INCAPACITATED"} && {VCM_RAGDOLLCHC > (random 100)}) then
{
	if (stance _unit != "PRONE") then
	{
		//Ragdoll unit
		_unit setUnconscious true;
		_unit spawn {sleep 2;_this setUnconscious false;};
	} else {
		switch (floor random 3) do {
			case 1: {_unit playMoveNow "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDl";}; //Roll left
			case 2: {_unit playMoveNow "AmovPpneMstpSrasWrflDnon_AmovPpneMevaSlowWrflDr";}; //Roll right
			default 
			{
				_unit playMoveNow "AadjPpneMstpSrasWrflDdown"; //Go as low as possible
				_unit spawn 
				{
					sleep 4;
					//Return to normal
					if (alive _this && {animationState _this == "aadjppnemstpsraswrflddown"}) then {_this playMoveNow "AadjPpneMstpSrasWrflDDown_AmovPpneMstpSrasWrflDnon"};
				};
			};
		};
	};
};
