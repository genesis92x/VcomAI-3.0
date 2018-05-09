//Function for defining AI who are in artillery pieces
//Pull the vehicle the unit is in.

_Vehicle = (vehicle _this);
if (_Vehicle in Vcm_ArtilleryArray) exitWith {};

//Get the vehicles class name.
private _class = typeOf _Vehicle;
if (isNil ("_class")) exitWith {};

//Figure out if it is defined as artillery
private _ArtyScan = getNumber(configfile/"CfgVehicles"/_class/"artilleryScanner");

//Exit the script if it is not defined as artillery
if (isNil "_ArtyScan") exitWith 
{

//Check if unit somehow is in the Vcm_ArtilleryArray and remove them.  This can happen to units who were inside artillery pieces but ejected or moved out due to a divine intervention.
	if (_Vehicle in Vcm_ArtilleryArray) then 
	{
		private _T = Vcm_ArtilleryArray findIf {_Vehicle isEqualTo _x};
		Vcm_ArtilleryArray deleteAt _T;
	};

};

if (_ArtyScan isEqualTo 1) then 
{

	Vcm_ArtilleryArray pushBack _Vehicle;
};