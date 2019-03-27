/*
	Author: Freddo

	Description:
		Checks if a group is eligible to reinforce other units.

	Parameter(s):
		GROUP - Group to check.

	Returns:
		BOOLEAN
*/

private _group = _this;
private _units = units _group;
private _rtrn = true;

_rtrn =  
(
	(_group call VCM_fnc_GroupHasRadio) &&
	behaviour leader _group != "CARELESS" && 
	!(_group getVariable ["VCM_NORESCUE", false]) &&
	(
		switch (_group call VCM_fnc_CheckSituation) do
		{
			case "READY";
			case "REINFORCE";
		}
	) &&
	!(count waypoints _group > 1) &&
	((waypoints _group) findIf {_x in VCM_IGNOREWAYPOINTS} isEqualTo -1)
);



if _rtrn then
{
	_rtrn = (_units findIf {!canMove _x || {vehicle _x isKindOf "StaticWeapon"}} == -1);
};
_rtrn