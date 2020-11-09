/*

  Gruppe besetzt eine Position (inkl. Häuser, Geschütze) im Umkreis von 50 Metern.

*/



params ["_grp"];

private ["_position","_units","_statische"];

_grp = _grp call CBA_fnc_getGroup;
if !(local _grp) exitWith {};

_units = (units _grp);



if (_units isEqualto []) exitWith {};

  _position = getPosATL (leader _grp);

private _befehl = _grp getVariable ["befehl", []];
if !(_befehl isEqualTo []) then {
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


_statische = _position nearObjects ["StaticWeapon", 75];
_statische = _statische select {(_x emptyPositions "Gunner") > 0};

//statische bemannen
if !(_statische isEqualto []) then {
  for "_i" from 0 to (count _units)-1 do {
    (_units select _i) assignAsGunner (_statische deleteAt 0);
    [(_units select _i)] orderGetIn true;
    _units deleteAt _i;
  };
};

if (_units isEqualto []) exitWith {};

//Häuserpositionen befüllen //TODO Militärische Gebäude only und ev. Restverwertung nicht zugewiesener Einheiten
[_position, nil, _units, 75, 2, false, false] call ace_ai_fnc_garrison;
