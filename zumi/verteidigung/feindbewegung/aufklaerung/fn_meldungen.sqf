
/*

  Hier werden durch Späher und Feuerleitoffiziere aufgeklärte Zielpositionen registriert.
  Gruppen, die nicht mehr gesichtet wurden, werden vergessen. Meistens werden Sichtungen ja falls möglich untersucht.

*/

if !isServer exitWith {};

params ["_position",["_rad", 1200], ["_side", west], ["_knowledge", 2]];

private ["_return","_players"];

//Aufgeklärte Ziele differenzieren
_return = [
  [], //Fusssoldaten
  [], //Autos
  [], //APCs
  [], //Panzer
  [], //Helikopter
  []  //Flugzeuge
];

_players = [] call CBA_fnc_players;

//Ändern, so dass gesichtete Ziele zuverlässig ausgegeben werden

{
  if (_side knowsAbout ((vehicle _x)) >= _knowledge && (alive _x)) then {
    switch (true) do {
      case (((vehicle _x) isKindOf "CAManBase") && ((_x distance2d _position) <= _rad)) : {
        (_return select 0) pushBackUnique ((vehicle _x));
      };
      case (((vehicle _x) isKindOf "Car") && ((_x distance2d _position) <= 1.5*_rad)) : {
        (_return select 1) pushBackUnique ((vehicle _x));
      };
      case (((vehicle _x) isKindOf "Wheeled_APC_F") && ((_x distance2d _position) <= 2*_rad)) : {
        (_return select 2) pushBackUnique ((vehicle _x));
      };
      case (((vehicle _x) isKindOf "Tank") && ((_x distance2d _position) <= 2*_rad)) : {
        (_return select 3) pushBackUnique ((vehicle _x));
      };
      case (((vehicle _x) isKindOf "Helicopter") && ((_x distance2d _position) <= 3*_rad)) : {
        (_return select 4) pushBackUnique ((vehicle _x));
      };
      case (((vehicle _x) isKindOf "Plane") && ((_x distance2d _position) <= 5*_rad)) : {
        (_return select 5) pushBackUnique ((vehicle _x));
      };
      default {};
    };
  };
} forEach _players;

_return
