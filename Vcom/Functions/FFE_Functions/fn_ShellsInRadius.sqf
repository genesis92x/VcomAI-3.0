params ["_center", "_radius"];
private ["_shells","_inRange","_pos1","_shell","_pos2"];
	
_pos1 = [_center select 0,_center select 1,0];

_shells = missionNameSpace getVariable ["RydFFE_FiredShells",[]];

_inRange = [];

{
	_shell = _x;
	if (not (isNil "_shell") || {not (isNull _x)}) then
	{
		_pos2 = getPosASL _x;
		_pos2 = [_pos2 select 0,_pos2 select 1,0];
		
		if ((_pos1 distance _pos2) < _radius) then
		{
			_inRange set [(count _inRange),_x]
		}
	}
}
foreach _shells;

_inRange