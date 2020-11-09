/*

  Vom Feind gemeldete Ziele werden hier gewichtet.

*/

if !isServer exitWith {};

params ["_position","_kommandeur","_fusssoldaten","_autos","_apcs","_panzer","_helikopter","_flugzeuge", "_taskname"];

private ["_return","_alle","_ziel","_ziele","_gewicht","_threat","_encountervarianten"];

_return = [];

{
  if (count _x > 0) then {
    for "_i" from 0 to (count _x)-1 do {
      _return pushBack (_x select _i);
      _threat = getArray (configFile >> "CfgVehicles" >> typeOf (_x select _i) >> "threat");
      _gewicht = ((_threat select 0)+(_threat select 1)+(_threat select 2))/3;
      _return pushBack _gewicht;
    };
  };
} forEach [_fusssoldaten, _autos, _apcs, _panzer, _helikopter, _flugzeuge];

if ((count _return) < 1) exitWith {
  if (debug) then {
    systemChat "Keine Ziele vorhanden, loope erneut in drei Minuten";
  };
  [
    {
      params ["_pos", "_tsk"];
      [_pos, _tsk] call zumi_fnc_kommandant_handler;
    },
    [_position, _taskname],
    180
  ] call CBA_fnc_waitAndExecute;
};

_ziel = (_return call BIS_fnc_selectRandomWeighted);
zumi_feindziele pushBack _ziel;

_encounter = [_ziel] call zumi_fnc_encounterwahl;
if (debug) then {
  systemChat format ["Gewählter zufälliger gewichteter Encounter: %1",str _encounter];
};
if (count _encounter > 0) exitWith {
  [_ziel, _encounter, _kommandeur] call zumi_fnc_befehl_ausgeben;
  [
    {
      params ["_pos", "_tsk"];
      [_pos, _tsk] call zumi_fnc_kommandant_handler;
    },
    [_position, _taskname],
    180
  ] call CBA_fnc_waitAndExecute;
};

[
  {
    params ["_pos", "_tsk"];
    [_pos, _tsk] call zumi_fnc_kommandant_handler;
  },
  [_position, _taskname],
  180
] call CBA_fnc_waitAndExecute;
