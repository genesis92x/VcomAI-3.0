	//params ["_pos","_dist", "_params"];
	private _pos = getpos player;
	private _dist = 25;
	private _params = [1, -1, 0.1, 0, 0, false, objNull];
	_pos = _pos findEmptyPosition [0,_dist];
	if (_pos isEqualTo []) exitWith {_pos};
	_params =+ _params;
	_params set [0, -1];
	_pos = _pos isFlatEmpty _params;
	if (_pos isEqualTo []) exitWith {_pos};
	_pos




[] spawn {
	VCOMTEST = true;
	while {VCOMTEST} do {
		{
			systemchat format ["%2: %1",(getSuppression _x),(typeof _x)];

		} foreach allunits;
		sleep 0.05;
	};

};