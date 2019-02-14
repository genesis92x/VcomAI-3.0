/*
	Author: Freddo

	Description:
		Return array of known enemies.

	Parameter(s):
		OBJECT - Units enemy to this unit will be added to return array.
		
		OR
		
		0: OBJECT - Units enemy to this unit will be added to return array.
		1: NUMBER - Range of search
		2: BOOLEAN - OPTIONAL, Whether to sort by range (sorted in ascending order)

	Returns:
		ARRAY
*/

private _rtrnArr = [];

if (_this isEqualType []) then 
{
	
	params ["_unit", "_range", "_toSort"];
	
	{
		if ((_unit knowsAbout _x) >= 1.5) then
		{
			_rtrnArr pushBack _x;
		};
	}
	forEach (_this call VCM_fnc_EnemyArray);
	
} 
else
{
	
	{
		if ((_this knowsAbout _x) >= 1.5) then
		{
			_rtrnArr pushBack _x;
		};
	}
	forEach (_this call VCM_fnc_EnemyArray);
	
};

_rtrnArr