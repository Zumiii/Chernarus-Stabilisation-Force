/*

  Loop, der prüft, ob Kommandeure vorhanden sind (30 Sekunden Intervall) und lässt sie falls nötig Befehle erteilen
  Sind keine mehr vorhanden, so agiert der Feind nicht mehr koordiniert und ruft auch keine Verstärkung mehr.
  Kommandeure erteilen nur maximal alle 2 Minuten neue Befehle.
*/

if !isServer exitWith {};

params ["_position", "_taskname"];

_finished = false;
for "_i" from 0 to (count zumi_maintasks) - 1 do {
	(zumi_maintasks select _i) params ["_task","_description_kurz","_description_lang","_seite","_marker","_taskstate","_position","_hud","_symbol"];
	if ((_taskname isEqualTo _task) && (_taskstate IN ["failed","succeeded","canceled"])) exitWith {
		_finished = true;
	};
};

if (_finished) exitwith {};

//Aktualisiere lebende Kommandeure
zumi_kommandeure = zumi_kommandeure select {(alive _x)};

_zumi_kommandeure = zumi_kommandeure select {((_x getVariable ["letzte_befehlsausgabe", 0]) < CBA_missiontime)};

If (_zumi_kommandeure isEqualTo []) exitwith {
  if (debug) then {
    systemChat "Keine Kommandeure vh, loope in 3 Minuten";
  };
  //Loope erneut
  [
    {
      params ["_pos", "_tsk"];
      [_pos, _tsk] call zumi_fnc_kommandant_handler;
    },
    [_position, _taskname],
    180
  ] call CBA_fnc_waitAndExecute;
};

//Prüfe, ob eine Befehlsausgabe überhaupt nötig ist (Ermittle Lage, Befehlsanzahl)

if (count zumi_befehle >= 4) exitWith {
  if (debug) then {
    systemChat "Zuviele Befehle vh";
  };
  //Loope erneut
  [
    {
      params ["_pos", "_tsk"];
      [_pos, _tsk] call zumi_fnc_kommandant_handler;
    },
    [_position, _taskname],
    180
  ] call CBA_fnc_waitAndExecute;
};

//Wähle Kommandeur aus:
private _kommandeur = _zumi_kommandeure call bis_fnc_selectRandom;

//Prüfe Feindmeldungen
private _meldungen = [_position] call zumi_fnc_meldungen;
private _additionals = [];
{
	private _neartargets = [(_x select 0) call CBA_fnc_getPos, 1500] call zumi_fnc_meldungen;
	_additionals append _neartargets;
} forEach (zumi_stellungen select {alive (_x select 0)});
{
	_meldungen pushBackUnique _x;
} forEach _additionals;

_meldungen params ["_fusssoldaten","_autos","_apcs","_panzer","_helikopter","_flugzeuge"];

//Wenn nix gesichtet wurde, Skript verlassen
if (count (_fusssoldaten + _autos + _apcs + _panzer + _helikopter + _flugzeuge) == 0) exitWith {
  if (debug) then {
    systemChat "Keine Ziele gesichtet";
  };
  [
    {
      params ["_pos", "_tsk"];
      [_pos, _tsk] call zumi_fnc_kommandant_handler;
    },
    [_position, _taskname],
    120
  ] call CBA_fnc_waitAndExecute;
};

if (count zumi_feindziele > 0) then {
	zumi_feindziele = zumi_feindziele select {(alive _x)};
};
//Sortiere bereits bekämpfte Ziele aus
private _fusssoldaten = _fusssoldaten select {
    !(_x IN zumi_feindziele)
};
private _autos = _autos select {
    !(_x IN zumi_feindziele)
};
private _apcs = _apcs select {
    !(_x IN zumi_feindziele)
};
private _panzer = _panzer select {
    !(_x IN zumi_feindziele)
};
private _helikopter = _helikopter select {
    !(_x IN zumi_feindziele)
};
private _flugzeuge = _flugzeuge select {
    !(_x IN zumi_feindziele)
};

//Der Feind schlägt Alarm, wenn er Flieger im Gebiet hat
if ((count _flugzeuge) > 0) then {
	["zumi_fliegeralarm", [cba_missiontime]] call CBA_fnc_serverEvent;
};

//Wenn nix neues bekämpfbares gesichtet wurde, Skript verlassen
if (count (_fusssoldaten + _autos + _apcs + _panzer + _helikopter + _flugzeuge) == 0) exitWith {
  if (debug) then {
    systemChat "Keine neuen Ziele gesichtet";
  };
  [
    {
      params ["_pos", "_tsk"];
      [_pos, _tsk] call zumi_fnc_kommandant_handler;
    },
    [_position, _taskname],
    120
  ] call CBA_fnc_waitAndExecute;
};

//Priorisiere Ziele und erkenne, ob dringende Ziele vorliegen

[_position, _kommandeur, _fusssoldaten, _autos, _apcs, _panzer, _helikopter, _flugzeuge, _taskname] call zumi_fnc_ziele_gewichten;
