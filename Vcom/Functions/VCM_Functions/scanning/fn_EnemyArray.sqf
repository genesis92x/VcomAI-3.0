
/*
	Author: Genesis, overhauled by Freddo

	Description:
		Return array containing all enemies of unit.

	Parameter(s):
		OBJECT - Units enemy to this unit will be added to return array
		
		OR
		
		0: OBJECT - Units enemy to this unit will be added to return array
		1: NUMBER - Range of search
		2: BOOLEAN - OPTIONAL Whether to sort the array by range, closest to furthest

	Returns:
		ARRAY
*/
private _array = [];

if (_this isEqualType []) then 
{
	params ["_unit", "_range", "_toSort"];
	
	if (isNil "_toSort") then {_toSort = false};
	
	if (_toSort isEqualTo false) then
	{
		// Return unsorted array of all enemies within defined range
		private _unitSide = side (group _unit);
		{
			
			if ([_unitSide, (side _x)] call BIS_fnc_sideIsEnemy && {(_unit distance2D _x) < _range}) then 
			{
				_array pushback _x;
			};
			
		} forEach allUnits;
		
	} 
	else
	{
		// TODO: Optimise
		
		// Return sorted array of all enemies within defined range
		private _unitSide = side (group _unit);
		private _range2d = 0;
		private _unsortArr = [];
		// Find eligible units
		{
			
			if ([_unitSide, (side _x)] call BIS_fnc_sideIsEnemy) then 
			{
				_range2d = (_unit distance2D _x);
				if (_range2d < _range) then
				{
					// In order to be able to be sorted, it is stored in a two dimensional array
					_unsortArr pushback [_range2d, _x];
				};
			};
		} forEach allUnits;
		// Sort the thing
		_sortArr = ([_unsortArr, [], {_x select 0}] call BIS_fnc_sortBy);
		{_array pushBack (_x select 1)} forEach _sortArr;
	};
} 
else 
{
	// Just return all enemies in the mission
	private _unitSide = side (group _this);
	{
		
		if ([_unitSide, (side _x)] call BIS_fnc_sideIsEnemy) then 
		{
			_array pushback _x;
		};
		
	} forEach allUnits;
};

_array