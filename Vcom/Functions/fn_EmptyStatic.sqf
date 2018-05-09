//Function for finding all empty static weapons nearby.
private _Returned = false;
{
	private _Weap = nearestObject [(getpos _x),"StaticWeapon"];
	if (!(isNull _Weap) || {!((_Weap distance2D _x) > 100)}) exitWith
	{
		_Returned = true;
		_Returned
	}	
	
} foreach (units _this);

_Returned