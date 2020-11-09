
/*

  Skript, welches eine Position rund um eine Position in der gewünschten Entfernung sucht

*/

if !isServer exitWith {};

params [
	["_position", [0,0,0]],
	["_abstand", [2000,20000]], //Mindest- und Maximalabstand in Metern zum letzten Auftragsort (Default min 2km max 20km)
	["_spielerfrei", 0],
  ["_rad", 360]
];


//Definiere
_return  = [];
_posigefunden = false;
for "_i" from 1 to 300 do {
 if (_posigefunden) exitWith {};
 _return = [_position, _abstand select 1, 0, _rad] call CBA_fnc_randPos;
 private _distanz = _position distance2d _return;
 //Prüfe für gewünschte Abstände 800 --> 200/2000
 if ((_distanz >= (_abstand select 0)) && (_distanz <= (_abstand select 1))) then {
	 _posigefunden = true;
 };
 //Prüfe, ob der Ort spielerfrei sein muss
	if (_spielerfrei > 0) then {
		if (count ([_return, _spielerfrei, [west,civilian,resistance],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) > 0) then {
			_posigefunden = false;
		};
	};
};


if (!_posigefunden) exitWith {
	_return = (selectRandom (ortschaften select {!((_x select 2) isEqualTo _position) && (count ([(_x select 2), _spielerfrei, [west,civilian,resistance],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) <= 0)})) select 2;
};

_return;
