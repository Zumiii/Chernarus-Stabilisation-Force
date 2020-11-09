/*

  Loop, der prüft, ob Feuerbefehle vorhanden sind (60 Sekunden Intervall)

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

If (zumi_steilfeuerbefehle isEqualTo []) exitWith {
  //Loope erneut
  [
    {
      params ["_tsk"];
      [_tsk] call zumi_fnc_steilfeuer_handler;
    },
    [_task],
    120
  ] call CBA_fnc_waitAndExecute;
};

private _aktuelle_feuermission = zumi_steilfeuerbefehle deleteAt 0;
_aktuelle_feuermission params ["_zielkoordinate","_art","_geschosstyp","_menge"];

//Aktualisiere lebende Batterien
zumi_moerser = zumi_moerser select {alive _x};
zumi_haubitzen = zumi_haubitzen select {alive _x};
zumi_raketen = zumi_raketen select {alive _x};

private _batterien = switch (_art) do {
    case "moerser" : {[zumi_moerser] call CBA_fnc_shuffle};
    case "haubitze" : {[zumi_haubitzen] call CBA_fnc_shuffle};
    case "rakete" : {[zumi_raketen] call CBA_fnc_shuffle};
    default {
      [(zumi_moerser + zumi_haubitzen + zumi_raketen)] call CBA_fnc_shuffle
    };
};

If (_batterien isEqualTo []) exitwith {
  if (debug) then {
    systemChat "Batterien sind ein leeres Array...";
  };
	[
    {
      params ["_tsk"];
      [_tsk] call zumi_fnc_steilfeuer_handler;
    },
    [_task],
    120
  ] call CBA_fnc_waitAndExecute;
};

private _mindestabstand = switch (_art) do {
    case "moerser" : {150};//1026
    case "haubitze" : {400};
    case "rakete" : {600};
    default {600};
};

_batterien = _batterien select {
    (_zielkoordinate inRangeOfArtillery [[_x], _geschosstyp])
    && ((_zielkoordinate distance2d _x) >= _mindestabstand)
    && (_geschosstyp in (getArtilleryAmmo [_x]))
};

If (_batterien isEqualTo []) exitwith {
  if (debug) then {
    systemChat "Auftrag abgebrochen, weil keine Batterie in Reichweite ist";
  };
	[
    {
      params ["_tsk"];
      [_tsk] call zumi_fnc_steilfeuer_handler;
    },
    [_task],
    120
  ] call CBA_fnc_waitAndExecute;
	//Wiederhole Auftrag, weil die Batterien nicht rdy waren
	zumi_steilfeuerbefehle pushBack _aktuelle_feuermission;
};

_batterien = _batterien select {
    (_x getVariable ["zuletzt_gefeuert",0]) < CBA_missiontime
};

If (_batterien isEqualTo []) exitwith {
    if (debug) then {
      systemChat "Auftrag wird wiederholt, weil keine Batterie feuerbereit ist";
    };
    //Wiederhole Auftrag, weil die Batterien nicht rdy waren
    zumi_steilfeuerbefehle pushBack _aktuelle_feuermission;
		[
	    {
	      params ["_tsk"];
	      [_tsk] call zumi_fnc_steilfeuer_handler;
	    },
	    [_task],
	    120
	  ] call CBA_fnc_waitAndExecute;
};

private _wasys = selectRandom _batterien;
//Es wird höchstens alle 3 Minuten gefeuert
_wasys setVariable ["zuletzt_gefeuert", CBA_missiontime + 180];

//Falls mir ein Fehler unterläuft bei der Munitionswahl
private _geschosstypen = getArtilleryAmmo [_wasys];
If !(_geschosstyp in _geschosstypen) then {_geschosstyp = ""};

[_wasys, _zielkoordinate, _geschosstyp, _menge] call zumi_fnc_feuer_frei;

[
	{
		params ["_tsk"];
		[_tsk] call zumi_fnc_steilfeuer_handler;
	},
	[_task],
	120
] call CBA_fnc_waitAndExecute;
