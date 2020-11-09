/*

  Gruppe patrouilliert eine Position im Radius von 150 Metern.

*/



params ["_grp"];

private ["_position"];

_grp = _grp call CBA_fnc_getGroup;
if !(local _grp) exitWith {};

_position = getPosATL (leader _grp);

_rad = _grp getVariable ["order_radius", 300];

[_grp, _position, _rad, 3, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [5, 15, 45]] call CBA_fnc_taskPatrol;

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
