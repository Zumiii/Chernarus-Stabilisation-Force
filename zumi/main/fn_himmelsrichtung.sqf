/*

  Kurzbeschrieb:
  Funktion, um Himmelsrichtung vom einen zum anderen Punkt anzugeben

*/

if !isServer exitWith {};

params [
	"_a",
  "_b",
  ["_mode", true]
];

_dir = [_a, _b] call BIS_fnc_dirTo;

if (_mode) exitWith {

  _return = switch (true) do {
    case ((_dir > 22.5) && (_dir <= 67.5)) : {"Nordosten"};
    case ((_dir > 292.5) && (_dir <= 337.5)) : {"Nordwesten"};
    case ((_dir > 247.5) && (_dir <= 292.5)) : {"Westen"};
    case ((_dir > 202.5) && (_dir <= 247.5)) : {"Südwesten"};
    case ((_dir > 157.5) && (_dir <= 202.5)) : {"Süden"};
    case ((_dir <= 157.5) && (_dir > 112.5)) : {"Südosten"};
    case ((_dir > 67.5) && (_dir <= 112.5)) : {"Osten"};
    default {"Norden"};
  };

  _return;

};

_return = switch (true) do {
  case ((_dir > 22.5) && (_dir <= 67.5)) : {"nordöstlich"};
  case ((_dir > 292.5) && (_dir <= 337.5)) : {"nordwestlich"};
  case ((_dir > 247.5) && (_dir <= 292.5)) : {"westlich"};
  case ((_dir > 202.5) && (_dir <= 247.5)) : {"südwestlich"};
  case ((_dir > 157.5) && (_dir <= 202.5)) : {"südlich"};
  case ((_dir <= 157.5) && (_dir > 112.5)) : {"südöstlich"};
  case ((_dir > 67.5) && (_dir <= 112.5)) : {"östlich"};
  default {"nördlich"};
};

_return;
