/*
	Author: Freddo

	Description:
		Gets the current average suppression of a group

	Parameter(s):
		GROUP - Group to check

	Returns:
		NUMBER - Average suppression
*/

private _group = _this;
private _units = units _group;
private _rtrn = 0;
private _totalSuppression = 0;

{
	if (!isNull _x && alive _x) then
	{
		_totalSuppression = (_totalSuppression + getSuppression _x);
	};
} forEach _units;

_rtrn = _totalSuppression / ({!isNull _x && alive _x} count _units);

_rtrn