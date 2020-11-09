if !isServer exitWith {};

params [
  "_posi",
  "_ziel",
  "_art",
  ["_veh", ""]
];

private ["_water","_speed","_dir","_return","_orgX","_orgY","_posX","_posY"];

_water = true;
_speed = switch (_veh) do {
  case "zu Fuss" : { 15 };
  default { 100 };
};

_dir = [_posi, _ziel] call BIS_fnc_dirTo;

_orgX = _posi select 0;
_orgY = _posi select 1;

_posX = _orgX + (_speed * sin _dir);
_posY = _orgY + (_speed * cos _dir);

_return = [_posX, _posY, 0];

_return;
