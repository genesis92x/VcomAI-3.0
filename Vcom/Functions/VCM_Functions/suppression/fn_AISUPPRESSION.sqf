/*
	Author: Freddo

	Description:
		Basic spawned suppression script

	Parameter(s):
		OBJECT - Unit that will be affected by suppression

	Returns:
		NOTHING
*/
private _weaponType = "";
private _unit = _this;
while {alive _unit} do
{
	waitUntil {!alive _unit || {getSuppression _unit > 0.5 && {isNull objectParent _unit}};
	
	switch (currentWeapon _unit) do
	{
		case "": {"nothing"};
		case (primaryWeapon _unit): {_weaponType = "primary"};
		case (handgunWeapon _unit): {_weaponType = "handgun"};
		case (secondaryWeapon _unit): {_weaponType = "secondary"};
	};
	
	if (!(velocityModelSpace _unit isEqualTo [0,0,0]) && {_stance isEqualTo "STAND" || _stance isEqualTo "CROUCH"}) then 
	{
		if (_stance isEqualTo "STAND") then 
		{
			//Standing
			switch _weapontype do
			{
				case "primary": 
				{
					if (random 10 > 3) then
					{
						// Dive forward
						_unit playMoveNow "AmovPercMsprSlowWrflDf_AmovPpneMstpSrasWrflDnon";
					}
					else
					{
						// Fall to the side
						_unit playMoveNow selectRandom ["AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDright", "AmovPercMstpSrasWrflDnon_AadjPpneMstpSrasWrflDleft"];
						_unit spawn {sleep 3 + random 3; _unit playMoveNow "AmovPpneMevaSlowWrflDf"};
					};
				};
				case "handgun": {_unit playMoveNow "AmovPercMsprSlowWpstDf_AmovPpneMstpSrasWpstDnon"};
			};
			
		}
		else
		{
			// Crouched
			switch _weapontype do
			{
				case "primary": {_unit playMoveNow "AmovPercMsprSlowWrflDf_AmovPpneMstpSrasWrflDnon"};
				case "handgun": {_unit playMoveNow "AmovPercMsprSlowWpstDf_AmovPpneMstpSrasWpstDnon"};
			};
		};
		_unit setUnitPos "DOWN";
	}
	else
	{
		_unit setUnitPos "DOWN"
	};
	waitUntil {!alive _this || {getSuppression _this < 0.5}};
	_unit setUnitPos "AUTO";
};