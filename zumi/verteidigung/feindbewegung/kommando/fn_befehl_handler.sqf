/*

  Loop, der prüft, ob Kommandos vorhanden sind (60 Sekunden Intervall) und ob Einheiten vorhanden sind, die die Kommandos ausführen können.
  Befehle, die 20 Minuten ignoriert wurden, entfallen.

*/

if !isServer exitWith {};

params [
	"_task"
];

/*

  Ist die Aufgabe vorbei, braucht der Feind nicht weiter anzusetzen

*/

_finished = false;
for "_i" from 0 to (count zumi_maintasks) - 1 do {
	(zumi_maintasks select _i) params ["_taskname","_description_kurz","_description_lang","_seite","_marker","_taskstate","_position","_hud","_symbol"];
	if ((_taskname isEqualTo _task) && (_taskstate IN ["failed","succeeded","canceled"])) exitWith {
		_finished = true;
	};
};


if (_finished) exitwith {};

If (count zumi_befehle < 1) exitWith {
  if (debug) then {
    systemChat "Keine Befehle vh";
  };
  [
    {
      params ["_tsk"];
      [_tsk] call zumi_fnc_befehl_handler;
    },
    [_task],
    30
  ] call CBA_fnc_waitAndExecute;
};

private _aktueller_befehl = zumi_befehle deleteAt 0;

_aktueller_befehl params ["_zielkoordinate", ["_auftrag","patrouille"], ["_truppengattung", "inf_fuss"], ["_dauer", 900], ["_loops", 1], ["_dringend", false], ["_rad", 150], ["_target", objNull]];

//Aktualisiere lebende und per Funk erreichbare Truppenteile
for "_i" from 0 to (count zumi_truppenteile)-1 do {
  zumi_truppenteile set [_i, (zumi_truppenteile select _i) select {count (_x call CBA_fnc_getAlive) > 0}];
};


if (debug) then {
  systemChat str zumi_truppenteile;
};

zumi_truppenteile params [
  ["_spaeher",[]],//Späher
  ["_inf_fuss",[]],//Inftrupp zu Fuss
  ["_inf_mot",[]],//Motorisierter Inftrupp
  ["_inf_mech",[]],//Mechanisierter Inftrupp
  ["_inf_stell",[]],//Inftrupp in Stellung
  ["_panzer",[]],//Panzer
  ["_luftabwehr",[]],//Luftabwehr (mobil)
  ["_bomber",[]],//drehflügler (kampf)
  ["_kampfjets",[]],//starrflügler (kampf)
  ["_funkwagen",[]]//Funkfahrzeug (mobil)
];

if (debug) then {
  systemChat str _inf_fuss;
};

_entsendbare = switch (_truppengattung) do {
    case "spaeher" : {[_spaeher] call CBA_fnc_shuffle};
    case "inf_fuss" : {[_inf_fuss] call CBA_fnc_shuffle};
    case "inf_mot" : {[_inf_mot] call CBA_fnc_shuffle};
    case "inf_mech" : {[_inf_mech] call CBA_fnc_shuffle};
    case "inf_stell" : {[_inf_stell] call CBA_fnc_shuffle};
    case "panzer" : {[_panzer] call CBA_fnc_shuffle};
    case "panzerabwehr" : {[_inf_mech + _panzer + _bomber + _kampfjets] call CBA_fnc_shuffle};
    case "funkwagen" : {[_funkwagen] call CBA_fnc_shuffle};
    case "luftabwehr" : {[_luftabwehr] call CBA_fnc_shuffle};
    case "bomber" : {[_bomber] call CBA_fnc_shuffle};
    case "kampfjets" : {[_kampfjets] call CBA_fnc_shuffle};
    default {[]};
};

If (_entsendbare isEqualTo []) exitwith {
  if (debug) then {
    systemChat "Derzeit keine Einheiten entsendbar, loope erneut in 60 Sekunden";
  };
  if (_loops > 0) then {
    _aktueller_befehl set [4, (_loops - 1)];
    zumi_befehle pushBack _aktueller_befehl;
  };
  [
    {
      [] call zumi_fnc_befehl_handler;
    },
    [],
    60
  ] call CBA_fnc_waitAndExecute;
};

//Wenn Dringlichkeit vorliegt, sind alle Einheiten verfügbar, auch wenn sie Befehle hatten
_entsendbare = if !(_dringend) then {
  _entsendbare select {
      (((_x getVariable ["befehl", []]) isEqualTo []) && !(_x getVariable ["statisch", false]))
  }
} else {
  _entsendbare
};

If (_entsendbare isEqualTo []) exitwith {
    //Wiederhole Auftrag, insofern Befehl nicht zu alt. Unwichtige Befehle bleiben weniger lang erhalten
    if (_loops > 0) then {
      _aktueller_befehl set [4, (_loops-1)];
      zumi_befehle pushBack _aktueller_befehl;
    };
    if (debug) then {
      systemChat "Derzeit keine Einheiten entsendbar, loope erneut in 60 Sekunden";
    };
    [
    {
      params ["_tsk"];
      [_tsk] call zumi_fnc_befehl_handler;
    },
    [_task],
      60
    ] call CBA_fnc_waitAndExecute;
};

private _entsendete = (_entsendbare call bis_fnc_selectRandom);
_entsendete setVariable ["befehl", [_zielkoordinate, _auftrag, _dauer]];
[_entsendete, _zielkoordinate, _auftrag, _dauer, _Target] call zumi_fnc_befehl_erhalten;

if (debug) then {
  systemChat format ["Entsende %1 nach %2 für %3 Sekunden mit dem Auftrag %4", _entsendete, _zielkoordinate, _dauer, _auftrag];
};

[
  {
    params ["_tsk"];
    [_tsk] call zumi_fnc_befehl_handler;
  },
  [_task],
  30
] call CBA_fnc_waitAndExecute;
