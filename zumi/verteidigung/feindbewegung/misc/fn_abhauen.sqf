/*

  Kurzbeschrieb:
  Skript, welches prüft, ob eine Einheit abhauen kann

*/

params [["_unit", objNull], ["_modus", 1]];

if ((isNull _unit) || (!alive _unit)) exitWith {};

if !(local _unit) exitWith {};

_gibt_auf = true;

//
if (!(_unit getVariable ["ace_captives_isHandcuffed", false]) && (count ([getPosatl _unit, 25, [west,civilian],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) < 1) && (count (weapons _unit) > 0)) exitWith {
  _gibt_auf = false;
  [_unit, false] call ACE_captives_fnc_setSurrendered;
  [
    {
      params ["_u", "_m"];
      [[_u], _m] remoteExecCall ["zumi_fnc_aufgeben", _u];
    },
    [_unit, _modus],
    5
  ] call CBA_fnc_waitAndExecute;
};


[
  {
    params ["_u", "_m"];
    [_u, _m] remoteExecCall ["zumi_fnc_abhauen", _u];
  },
  [_unit, _modus],
  5
] call CBA_fnc_waitAndExecute;
