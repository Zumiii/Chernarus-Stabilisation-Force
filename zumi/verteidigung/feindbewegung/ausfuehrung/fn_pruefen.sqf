/*

  Gruppe prüft eine Position mit Feuerstatus Gelb.

*/

if !isServer exitWith {};

params ["_grp"];

private ["_position"];

_grp = _grp call CBA_fnc_getGroup;
if !(local _grp) exitWith {};

_position = getPosATL (leader _grp);

_grp setvariable ["befehl", []];

//Gruppe will neue Befehle
private _befehl = _grp getVariable ["befehl", []]; if !(_befehl isEqualTo []) then {
  _befehl params ["_zielkoordinate", "_auftrag", "_dauer"];
  [
    {
      params ["_grp","_zielkoordinate"];
      if ({alive _x} count (units _grp) == 0 || (isNull _grp)) exitWith {};
      _grp setvariable ["befehl", []];
      [_grp, _zielkoordinate] call zumi_fnc_befehl_erfragen;
    },
    [_grp, (_grp call CBA_fnc_getPos)],
    _dauer
  ] call CBA_fnc_waitAndExecute;
};
