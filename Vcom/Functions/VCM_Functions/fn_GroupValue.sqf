/*
	Author: Freddo

	Description:
		Returns groups value calculated from different factors.

	Parameter(s):
		GROUP - Group to calculate value of.

	Returns:
		NUMBER
	
	Note:
		0 per unarmed vehicle
		1 per soldier
		2 per AT soldier
		4 per armed "car"
		8 per "tank"
		12 per "aircraft"
*/

private _group = _this;
private _units = units _group;
private _vehicles = [];
private _rtrnValue = 0;

{
	_vehicles pushBackUnique assignedVehicle _x;
	if (secondaryWeapon _x isEqualTo "") then
	{
		_rtrnValue = _rtrnValue + 1;
	}
	else
	{
		_rtrnValue = _rtrnValue + 2;
	};
} forEach _units;


// Someone clean this up
{
	if (_x isKindOf "car") then
	{
		if (canFire _x) then 
		{
			_rtrnValue = _rtrnValue + 4;
		};
	} else {
		if (_x isKindOf "tank") then 
		{
			_rtrnValue = _rtrnValue + 8;
		}
		else
		{
			if (_x isKindOf "air") then
			{
				_rtrnValue = _rtrnValue + 12;
			};
		};
	};
} forEach _vehicles;

_rtrnValue