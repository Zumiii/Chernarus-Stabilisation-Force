/*

  Skript, welches die gewünschten und geeigneten Positionen heraussucht

*/

if !isServer exitWith {};

params [
	["_startpos", [0,0,0]], //Startposition
	["_abstand", [2000,20000]], //Mindest- und Maximalabstand in Metern zum letzten Auftragsort (Default min 2km max 20km)
	["_spielerfrei", 0] //sind Spieleri n der Nähe?
];

//Definiere
_position  = [];
_posigefunden = false;
for "_i" from 1 to 500 do {
 if (_posigefunden) exitWith {_position};
 _position = (selectRandom (commy_sectors select {!((_x getVariable ["center", [0,0,0]]) isEqualTo _startpos)})) getVariable ["center", [0,0,0]];
 private _distanz = _position distance2d _startpos;
 //Prüfe für gewünschte Abstände 800 --> 200/2000
 if ((_distanz >= (_abstand select 0)) && (_distanz <= (_abstand select 1))) then {
   _posigefunden = true;
 };
   //Prüfe, ob der Ort spielerfrei sein muss
  if ((_spielerfrei > 0) && (_posigefunden)) then {
    if (count ([_position, _spielerfrei, [west, civilian, resistance, east], ["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) > 0) then {
      _posigefunden = false;
    };
  };
 };
if !(_posigefunden) exitWith {
	(selectRandom (commy_sectors select {!((_x getVariable ["center", [0,0,0]]) isEqualTo _startpos)})) getVariable ["center", [0,0,0]];
};

_position;
