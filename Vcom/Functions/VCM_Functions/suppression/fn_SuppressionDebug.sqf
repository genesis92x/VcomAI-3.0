/*
	Author: Freddo, inspired by TPWCAS

	Description:
		Spawns a hovering ball above the target that changes colour depending on the amount of suppression.
		Script needs to be spawned

	Parameter(s):
		OBJECT - Unit
*/

private _unit = _this;
private _ball = "Sign_Sphere25cm_Geometry_F" createVehicleLocal [random 5, random 5, random 5];
private _suppression = 0;
_ball attachTo [_unit, [0, 0, 2]];

while {alive _unit && isNull objectParent _unit} do
{
	sleep 2.5;
	_suppression = _unit call VCM_fnc_GetSuppression;
	
	switch true do
	{
		case (group _unit call VCM_fnc_CheckSituation == "CQC"): {_ball setObjectTexture [0, "#(argb,8,8,3)color(1,0,1,1)"]};
		case (_suppression > 0.9): {_ball setObjectTexture [0, "#(argb,8,8,3)color(0,0,1,1)"]};
		case (_suppression > 0.5): {_ball setObjectTexture [0, "#(argb,8,8,3)color(1,0,0,1)"]};
		case (_suppression > 0.1): {_ball setObjectTexture [0, "#(argb,8,8,3)color(1,1,0,1)"]};
		default {_ball setObjectTexture [0, "#(argb,8,8,3)color(0,1,0,1)"]};
	};
};

deleteVehicle _ball;