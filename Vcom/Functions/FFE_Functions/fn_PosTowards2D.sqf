params ["_source", "_angle", "_distT"];
private ["_dXb","_dYb","_px","_py","_pz"];

_dXb = _distT * (sin _angle);
_dYb = _distT * (cos _angle);

_px = (_source select 0) + _dXb;
_py = (_source select 1) + _dYb;

_pz = getTerrainHeightASL [_px,_py];

[_px,_py,_pz]