//Find closest object from an array of other objects
params ["_list","_object","_order","_script"];

if (isNil "_script") then {_script = "Nil";};

private _position = [0,0,0];
if (isNil "_object" || {isNil "_list"}) exitWith {_ClosestObject = [0,0,0];_ClosestObject};

switch ((TypeName _object)) do {
    case "OBJECT": {_position = getPosATL _object;};
    case "STRING": {_position = getMarkerPos _object;}; 
    case "ARRAY": {_position = _object;}; 
    case "GROUP": {_position = (getPosATL (leader _object));}; 
};

private _DistanceArray = [];
if (typeName _list isEqualTo "SCALAR") then {systemChat format ["_script: %1",_script];};
{
	if !(isNil "_x") then
	{
		_CompareObjectPos = [0,0,0];
		switch ((TypeName _x)) do {
				case "OBJECT": {_CompareObjectPos = getPosATL _x;};
				case "STRING": {_CompareObjectPos = getMarkerPos _x;}; 
				case "ARRAY": {_CompareObjectPos = _x;}; 
				case "GROUP": {_CompareObjectPos = (getPosATL (leader _x));}; 
		};
		private _NewObjectDistance = _CompareObjectPos distance2D _position;
		_DistanceArray pushback [_NewObjectDistance,_x];
	};
	true;
} count _list;

_DistanceArray sort _order;

private _ClosestObject = ((_DistanceArray select 0) select 1);

if (isNil "_ClosestObject") then {_ClosestObject = [0,0,0];};
_ClosestObject