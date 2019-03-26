/*
	Author: Genesis

	Description:
		Changes group formation dependent on surroundings and behaviour

	Parameter(s):
		OBJECT - Unit whose group to change formation

	Returns:
		BOOLEAN
*/

//Pull the unit
private _unit = _this;

//Grab the group of the unit
private _group = group _unit;
private _rtrn = false;

//Vehicular groups in "SAFE" behaviour will move in convoys
if (!isNull objectParent _unit && {behaviour _unit == "SAFE"}) exitWith 
{
	if (formation _group != "FILE") then {_group setFormation "FILE"};
	//Set the units variable so they dont try changing formations too frequently.
	_rtrn = true;
	_rtrn
};

//Grab the nearest "City" from the unit
private _nearestCity = nearestLocation [getPosASL _unit, "nameCity"];

//Lets grab the location position
private _locationPos = locationPosition _nearestCity;

//If the unit is less than 500 meters from the location exit with the following code
if ((_locationPos distance _unit) < 500) exitWith 
{
	
	//Check if the unit is in a vehicle or not
	if (!isNull objectParent _unit) then
	{
		if (formation _group != "COLUMN") then {_group setFormation "COLUMN"}; 
	}
	else
	{
		if (formation _group != "STAG COLUMN") then {_group setFormation "STAG COLUMN"};
	};

	//Set the units variable so they dont try changing formations too frequently.
	_rtrn = true;
	_rtrn
	
};

//The rest of the commands follow the same logic. Commenting where necessary.
private _nearestVillage = nearestLocation [getPosASL _unit, "NameVillage"];
private _locationPos2 = locationPosition _nearestVillage;

if ((_locationPos2 distance _unit) < 500) exitWith 
{
	if ((vehicle _unit) != _unit) then
	{
		if (formation _group != "COLUMN") then {_group setFormation "COLUMN"};
	}
	else
	{
		if (formation _group != "STAG COLUMN") then {_group setFormation "STAG COLUMN"};
	};
	
		_rtrn = true;
		_rtrn

};


private _nearestHill = nearestLocation [getPosASL _unit, "Hill"];
private _locationPos4 = locationPosition _nearestHill;

if ((_locationPos4 distance _unit) < 500) exitWith 
{
	if (formation _group != "LINE") then {_group setFormation "LINE"};

	_rtrn = true;
	_rtrn
};


private _nearestLocal = nearestLocation [getPosASL _unit, "NameLocal"];
private _locationPos3 = locationPosition _nearestLocal;

if ((_locationPos3 distance _unit) < 300) exitWith 
{
	if (formation _group != "COLUMN") then {_group setFormation "COLUMN"}; 
	
	_rtrn = true;
	_rtrn
};


//Execute this code only when all the above were NOT true. Return to wedge formation
if (formation _group != "WEDGE") then {_group setFormation "WEDGE"};
 
_rtrn = true;

_rtrn
