//Simple tweak of BIS' two functions built for Vehicle purposes by VCOM//

params ["_name"];
private _return = "NotAClass";

if ((typeName _name) isEqualTo "STRING") then
{
  _return = (configFile >> "cfgVehicles" >> _name);
};

_return 