params ["_source", "_angle", "_distT"];

private _dXb = _distT * (sin _angle);
private _dYb = _distT * (cos _angle);

private _px = (_source select 0) + _dXb;
private _py = (_source select 1) + _dYb;

private _pz = getTerrainHeightASL [_px,_py];

[_px,_py,_pz]