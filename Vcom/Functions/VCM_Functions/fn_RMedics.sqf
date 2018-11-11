
/*
	Author: Genesis

	Description:
		Function to find all medics within a group.

	Parameter(s):
		0: GROUP

	Returns:
		ARRAY
*/

private _mList = [];
{
	if (isNull objectParent _x) then
	{
		if (_x getUnitTrait "Medic") then
		{
			_mList pushBack _x;
		};
	};
	true;
} count (units _this);

_mList