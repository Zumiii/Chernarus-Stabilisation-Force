/*

  Skript, welches die gewünschten und geeigneten Positionen heraussucht

*/

if !isServer exitWith {};

//#include "sectorsConfig.hpp"


params [
	["_spielerfrei", true], //Dürfen Spieler in der Nähe sein?
	["_minmax", []],
	["_blacklisted", []]
];

_possibilities = commy_sectors select {(((_x getVariable ["score", -15]) < 5) && !((_x getVariable ["center", [0,0,0]]) IN _blacklisted))};

if (count _minmax > 0) then {
	_minmax params ["_min", "_max", "_from"];
	_possibilities = _possibilities select {(((_x getVariable ["center", [0,0,0]]) distance2d _from >= _min) && ((_x getVariable ["center", [0,0,0]]) distance2d _from <= _max))};
	systemChat str (count _possibilities);
};

if (_spielerfrei) then {
	_possibilities = _possibilities select {(count ([(_x getVariable ["center", [0,0,0]]), (((_x getVariable ["radius", 500]) + 1000) max 1500) min 1500, [west, civilian, resistance, east],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) <= 0)};
	if (count _possibilities < 1) exitWith {
		if (DEBUG) then {
			systemChat "NO WAI";
		};
		//TODO Sektoren, die an Eigene grenzen, haben höhere Chance
		//TODO Sektoren, die geschwächt wurden, erhöhen die Wahrscheinlichkeit etwas
		(selectRandom (commy_sectors select {(_x getVariable ["score", 0]) < 5})) getVariable ["center", [0,0,0]];
	};
};


//Sektoren, die an Eigene grenzen, haben höhere Chance
_wahlArray = [];
_Weights = [];
{

	private _angrenzende = count (commy_Sectors select {((_x getVariable ["center", [0,0,0]]) distance2d ((commy_sectors select _forEachIndex) getVariable ["center", [0,0,0]]) <= 5000) && ((_x getVariable ["score", 0]) > 5) && (_x != (commy_Sectors select _forEachIndex))});
	_wahlArray pushBack [((commy_Sectors select _forEachIndex) getVariable ["center", [0,0,0]]), ((commy_Sectors select _forEachIndex) getVariable ["name", "(Fehler bei Ortswahl)"])];
	If (_x IN _possibilities) then {
		_weights pushBack (linearConversion [0, 5, _angrenzende, 0.1, 1]);
	} else {
		_weights pushBack 0;
	};

} forEach commy_sectors;

//Ist kein geeigneter Sektor verfügbar, so wird einfach auf möglichst nahe Sektoren ausgedehnt
if (count (_weights select {_x > 0}) < 1) exitWith {
	_result = [commy_Sectors select {((count ([(_x getVariable ["center", [0,0,0]]), (((_x getVariable ["radius", 500]) + 1000) max 1500) min 1500, [west, civilian, resistance, east],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) <= 0) && ((_x getVariable ["score", 0]) <= 0))}, {-((getPosATL HQ) distance2d (_x getVariable ["center", [0,0,0]]))}, objNull] call CBA_fnc_selectBest; // selects closest target (negative distance)
	if (DEBUG) then {
		systemChat "Naher Sektor";
	};
	[(_result getVariable ["center", [0,0,0]]), _result getVariable ["name", "(Fehler bei Ortswahl)"]];
};

if (DEBUG) then {
	systemChat "Letzte Zeile";
};

_wahlArray selectRandomweighted _weights;
