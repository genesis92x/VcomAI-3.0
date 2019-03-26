/*
	Author: Freddo

	Description:
		Return array of enemy groups.

	Parameter(s):
		OBJECT - Groups enemy to this unit will be added to return array.
		
		OR
		
		0: OBJECT - Groups enemy to this unit will be added to return array.
		1: NUMBER - Range of search
		2: BOOLEAN - OPTIONAL, Whether to sort by range (sorted in ascending order)

	Returns:
		ARRAY
		
	Note:
		This function only checks if any unit from the group is in range, not entire group or leader.
*/

private _arr = _this call VCM_fnc_EnemyArray;
private _rtrn = [];
{
	_arr pushBackUnique (group _x);
} forEach _arr;

_rtrn