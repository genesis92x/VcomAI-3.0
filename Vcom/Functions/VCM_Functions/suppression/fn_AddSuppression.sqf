/*
	Author: Freddo

	Description:
		Sets a units current suppression

	Parameter(s):
		0: OBJECT - Unit to set
		1: NUMBER - Suppression to add, can be negative

	Returns:
		NUMBER - New suppression level
*/

params ["_unit", "_toAdd"];

private _newSuppression = ((getSuppression _unit + _toAdd) min 1);

_unit setSuppression _newSuppression;

_newSuppression