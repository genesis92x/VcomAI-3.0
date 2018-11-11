//This function is to ensure the AI reaches their ammo objective!!!
params ["_RAU","_RL"];

while {(_RAU distance _RL) > 5 && {(_RAU distance _RL) < 200}} do
{
	_RAU domove (getpos _RL);
	sleep 4;
};

	_RAU action ["rearm", _RL];