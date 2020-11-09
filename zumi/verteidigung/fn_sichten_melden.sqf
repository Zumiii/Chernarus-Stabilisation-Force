if !isServer exitWith {};

params ["_position",["_melde_radius",25],["_melde_typ","Fahrzeug"]];

private ["_spieler", "_gesichtete_ziele", "_alarmiertheit", "_spielerposition"];

_spieler = [];
_gesichtete_ziele = [];


_spieler = call CBA_fnc_players;

switch (_melde_typ) do {
	case "Helikopter" : {
		{
			_alarmiertheit = east knowsAbout vehicle _x;
			If (((vehicle _x) isKindOf "Air")&&(!((vehicle _x) isKindOf "ParachuteBase"))) then {
				if (_alarmiertheit >= 1.5) then {
					_spieler_posi = getPosATL _x;
					if ((_spieler_posi distance2d _position) <= _melde_radius) then {
						_gesichtete_ziele pushBackUnique (_x);
					};
				};
			};
		}forEach _spieler;
	};
	case "Panzer" : {
		{
			_alarmiertheit = east knowsAbout vehicle _x;
			If (_alarmiertheit >= 2 && (vehicle _x isKindOf "Tank")) then {
				_spieler_posi = getPos _x;
				if ((_spieler_posi distance2d _position) <= _melde_radius) then {
					_gesichtete_ziele pushBackUnique (_x);
				};
			};
		}forEach _spieler;
	};
	case "Fahrzeug" : {
		{
			_alarmiertheit = east knowsAbout vehicle _x;
			If (_alarmiertheit >= 3 && ((vehicle _x isKindOf "LandVehicle") || (_x isKindOf "CAManBase"))) then {
				_spieler_posi = getPos _x;
				if ((_spieler_posi distance2d _position) <= _melde_radius) then {
					_gesichtete_ziele pushBackUnique (_x);
				};
			};
		}forEach _spieler;
	};
};

_gesichtete_ziele;
