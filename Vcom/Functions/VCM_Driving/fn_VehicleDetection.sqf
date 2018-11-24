/*
	Author: Genesis, revamped by Freddo

	Description:
		Improves AI collision detection by adding additional points of contact

	Parameter(s):
		0: OBJECT - Driver

	Returns:
		NOTHING
	
	Notes:
		This is still experimental, and may be highly taxing on performance. Use with caution.
*/

private ["_vel", "_posASL", "_velX", "_velY", "_predictX", "_predictY", "_predictPos", "_posX", "_posY", "_obstacles", "_veh", "_hlprArray", "_hlpPosArray", "_boundBox", "_p2", "_p2MaxX", "_p2MaxX", "_p2MaxZ"];
params ["_unit"];

if (isPlayer _unit || {_unit getVariable ["VCM_driver", false]} || {vehicle _unit isKindOf "AIR"}) exitWith {};

_unit setVariable ["VCM_driver", true, false];

while {!isNull _unit && {alive _unit} && {!isNull objectParent _unit}} do
{
	_veh = objectParent _unit;
	
	// Check if vehicle is stationary or moving too fast
	_velModel = velocityModelSpace _unit;
	if !(_velModel select 1 < 3 || {_velModel select 1 > 40}) then
	{
		
		// Generate predicted position
		_vel = velocity _unit;
		_velX = _vel select 0;
		_velY = _vel select 1;
		
		_posASL = getPosASL _unit;
		_posX = _posASL select 0;
		_posY = _posASL select 1;
		
		if (_velY < 10) then
		{
			_predictX = (_posX + (_velX * 2.5));
			_predictY = (_posY + (_velY * 2.5));
		} 
		else
		{
			_predictX = _posX + _velX;
			_predictY = _posY + _velY;
		};
		
		_predictPos = [_predictX,_predictY,0.2];
		
		if (VCM_Debug) then
		{
			_predictPos spawn 
			{
				private _arrow = "Sign_Arrow_Cyan_F" createVehicle [0,0,0];
				_arrow setPos _this;
				sleep 2;
				deleteVehicle _arrow;
			};
		};
		
		
		//Create an array of objects near predicted path
		_obstacles = _predictPos nearObjects ["ALL", 10];
		
		//Add terrain objects (Rocks) to obstacles array
		//{
		//	_obstacles pushBackUnique _x;
		//} forEach nearestTerrainObjects [_predictPos, ["ROCK", "ROCKS"], 10, false]; //TODO: Find way to avoid walls without breaking them with physics
		
		//Remove gates, bridges and units vehicle from obstacles
		{
			if (_veh isEqualTo _x || {["gate",(str _x)] call BIS_fnc_inString} || {["bridge",(str _x)] call BIS_fnc_inString}) then
			{
				_obstacles = _obstacles - [_x];
			};
		} forEach _obstacles;
		
		// Helper array to contain helper objects
		_hlprArray = [];
		
		{
			
			if !(_x getVariable ["VCM_AVOID", false] || {_x isKindOf "man"} || {_x isKindOf "Helper_Base_F"} || {_x isKindOf "Logic"}) then 
			{
				// Vcom ignore this object until loop complete
				_x setVariable ["VCM_AVOID", true];
				
				// Positions to spawn helper objects
				_hlpPosArray = [];
				
				_boundBox = boundingBoxReal _x;
				_p2 = _boundBox select 1;
				
				_p2MaxX = _p2 select 0;
				_p2MaxY = _p2 select 1;
				_p2MaxZ = _p2 select 2;
				
				// Find corners of building bounding box
				_hlpPosArray pushBack (_x modelToWorld [_p2MaxX,_p2MaxY,-_p2MaxZ + 0.1]);
				_hlpPosArray pushBack (_x modelToWorld [-_p2MaxX,_p2MaxY,-_p2MaxZ + 0.1]);
				_hlpPosArray pushBack (_x modelToWorld [-_p2MaxX,-_p2MaxY,-_p2MaxZ + 0.1]);
				_hlpPosArray pushBack (_x modelToWorld [_p2MaxX,-_p2MaxY,-_p2MaxZ + 0.1]);
				// Get mid points of a building.
				_hlpPosArray pushBack (_x modelToWorld [0,-_p2MaxY,-_p2MaxZ + 0.1]);
				_hlpPosArray pushBack (_x modelToWorld [0,_p2MaxY,-_p2MaxZ + 0.1]);
				_hlpPosArray pushBack (_x modelToWorld [-_p2MaxX,0,-_p2MaxZ + 0.1]);
				_hlpPosArray pushBack (_x modelToWorld [_p2MaxX,0,-_p2MaxZ + 0.1]);
				
				// Spawn helper objects (These act as additional points of contact that the AI will attempt to avoid)
				{
					_hlpObj = "Land_CanOpener_F" createVehicleLocal _x;
					_hlpObj setVariable ["VCM_AVOID", true, false];
					_hlpObj setPosATL _x;
					_hlpObj enableSimulation false;
					_hlprArray pushBack _hlpObj;
				} forEach _hlpPosArray;
				
				//Spawn debug objects
				if (VCM_Debug) then
				{
					
					{
						
						[_x select 0, _x select 1, 0.2] spawn 
						{
							private _arrow = "Sign_Arrow_Large_F" createVehicle [0,0,0];
							_arrow setPos _this;
							sleep 9;
							deleteVehicle _arrow;
						};
						
					} forEach _hlpPosArray;
					
				};
				
			};
			
		} forEach _obstacles;
		
		// Delete helper objects after some time
		[_hlprArray, _obstacles] spawn 
		{
			sleep 9;
			{
				deleteVehicle _x;
			} forEach (_this select 0);
			{
				// Allow object to be considered again
				_x setVariable ["VCM_AVOID", false];
			} forEach (_this select 1);
			
		};
			
	};
	
	sleep 0.5;
};

_unit setVariable ["VCM_driver", false, false];