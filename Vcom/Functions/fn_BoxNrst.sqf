//Function for finding the closest WorldPos position (Left, Ride, Front, Rear) to an entity. And then finding a suitable position near that entity.
params ["_Ent","_Unit"];
private _Div = 1;
if (_Ent isKindOf "landvehicle" || _Ent isKindOf "air") then {_Div = 2;};

//First we need to get all the positions around the object, and mark each as front,rear,left,right.
private _EntBX = boundingBoxReal _Ent;
private _p1 = _EntBX select 0;
private _p2 = _EntBX select 1;
private _maxWidth = abs ((_p2 select 0) - (_p1 select 0));
private _maxLength = abs ((_p2 select 1) - (_p1 select 1));

private _Left =  _Ent modelToWorld [-((_maxWidth)/_Div),0,0];
private _Right = _Ent modelToWorld [(_maxWidth/_Div),0,0];
private _Front = _Ent modelToWorld [0,(_maxLength/_Div),0];
private _Behind = _Ent modelToWorld [0,(-(_maxLength)/_Div),0];
private _ClstPos = [[_Left,_Right,_Front,_Behind],_Unit,true,"NrstPos"] call DGN_fnc_ClosestObj;


_ClstPos