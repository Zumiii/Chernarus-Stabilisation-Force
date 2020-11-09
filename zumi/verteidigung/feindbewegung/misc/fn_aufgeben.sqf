/*

  Kurzbeschrieb:
  Skript, welches prüft, ob eine Einheit aufgeben soll
  Modi:
  1 - Unterdrückt und Feind nah
  2 - Keine Eigenen mehr vor Ort, unterdrückt und Feind nah
  3 - Flashed, unterdrückt und Feind nah

*/

params [["_units", []], ["_modus", 1]];

if (count _units < 1) exitWith {};

_alive = (_units call CBA_fnc_getAlive) select {!(_x getVariable ["ace_captives_isSurrendering", false])};
if (count _alive < 1) exitWith {};

{
  _gibt_auf = false;
  switch _modus do {
    case 1 : {
      //Ist die Person unterdrückt und sind Feinde nah?
      if ((getSuppression _x >= 0.5) && (count ([getPosatl _x, 50, [west,civilian],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) > 0)) then {
        _gibt_auf = true;
      };
    };
    case 2 : {
      //Ist die Person unterdrückt, keine Eigenen vor Ort und sind Feinde nah?
      if ((getSuppression _x >= 0.5) && (count ([getPosatl _x, 50, [west,civilian],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) > 0) && (count ([getPosatl _x, 25, [west]] call zumi_fnc_nahe_ki) <= 1)) then {
        _gibt_auf = true;
      };
    };
    case 3 : {
      //Ist die Person flashed, unterdrückt, keine Eigenen vor Ort und sind Feinde nah?
      if ((getSuppression _x >= 0.5) && (count ([getPosatl _x, 50, [west,civilian],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) > 0) && !(_x checkAIFeature "TARGET") && (count ([getPosatl _x, 25, [east]] call zumi_fnc_nahe_ki) <= 1)) then {
        _gibt_auf = true;
      };
    };
  };

  if (_gibt_auf) then {
    [_x, true] call ACE_captives_fnc_setSurrendered;
    _finder = (_alive find _x);
    if (_finder >= 0) then {
      _alive deleteAt _finder;
    };
    [
      {
        params ["_u", "_m"];
        [_u, _m] remoteExecCall ["zumi_fnc_abhauen", _u];
      },
      [_x, _modus],
      5
    ] call CBA_fnc_waitAndExecute;
  };

} forEach _alive;

[
  {
    params ["_a", "_m"];
    [_a, _m] remoteExecCall ["zumi_fnc_aufgeben", _a];
  },
  [_alive, _modus],
  5
] call CBA_fnc_waitAndExecute;
