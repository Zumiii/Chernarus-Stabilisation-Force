
missionended = false;
//Dynamic Groups
["Initialize", [true, 12, false, ""]] call BIS_fnc_dynamicGroups;


#include "data\konfig.hpp"
publicVariable "armory";
publicVariable "fahrzeugdepot";
publicVariable "kisten";
publicVariable "Bestellbare";


//Spieler JIP
"check_in_db" addPublicVariableEventHandler {
  params ["_varname","_varvalue","_target"];
  _varvalue params ["_player","_clientID","_UID","_name", "_ins"];
  private _inidbi = ["new", "us"] call OO_INIDBI;
  private _spielerinfo = ["read", ["Spielerliste", _UID, []]] call _inidbi;

  //Weise Tasks zu
  ["zumi_maintasks", [zumi_maintasks], _player] call CBA_fnc_targetEvent;
  ["zumi_sidetasks", [zumi_sidetasks], _player] call CBA_fnc_targetEvent;

  if (_spielerinfo isEqualto []) exitWith {
    remoteExecCall ["zumi_fnc_new_join", _player, false];
  };
  [_spielerinfo] remoteExecCall ["zumi_fnc_persistent_join", _player, false];
};


private _inidbi = ["new", "us"] call OO_INIDBI;


//Missionsphase ermitteln
Phase = ["read", ["Missionspersistenz", "Phase", -1]] call _inidbi;
if (Phase < 0) then {
  Phase = ["Phase", 5] call BIS_fnc_getParamValue;
};
publicVariable "Phase";

tasknummer = 1;
publicvariable "tasknummer";

max_spawns = ["read", ["Missionspersistenz", "max_spawns", 6]] call _inidbi;

DEBUG = false;

restart_nummer  = ["read", ["Missionspersistenz", "restart_nummer", 0]] call _inidbi;
restart_nummer = restart_nummer + 1;
publicVariable "restart_nummer";
//Restart
["write", ["Missionspersistenz", "restart_nummer", restart_nummer]] call _inidbi;

restart_max  = ["read", ["Missionspersistenz", "restart_max", 250]] call _inidbi;

spielerstatistik  = ["read", ["Missionspersistenz", "spielerstatistik", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]] call _inidbi;
spielerfaktor  = ["read", ["Missionspersistenz", "spielerfaktor", [0,0,0,0,0,0]]] call _inidbi;
publicVariable "spielerstatistik";

private _temp = spielerstatistik select {_x > 0};
if (count _temp < 1) then {
  _temp pushback 1;
};
average_players_when_not_empty = _temp call BIS_fnc_arithmeticMean;


/*////////////////////////////////////////
/ Bezüglich KI - Command                        /
////////////////////////////////////////*/

zumi_warfare  = ["read", ["Missionspersistenz", "zumi_warfare", [[], [], [], [], []]]] call _inidbi;

zumi_strategy  = ["read", ["Missionspersistenz", "zumi_strategy", [1, 1, 1, "aggressive", "fight militia"]]] call _inidbi;


/*////////////////////////////////////////
/ Bezüglich Umwelt                       /
////////////////////////////////////////*/

//Uhrzeit und Datum aktualisieren
private _date  = ["read", ["Missionspersistenz", "Zeit", date]] call _inidbi;
setDate _date;

timestamp = ("getTimeStamp" call _inidbi);

/*////////////////////////////////////////
/ Bezüglich Missionsfortschritt          /
////////////////////////////////////////*/


//Beschädigte Häuser
houses_damaged = ["read", ["Missionspersistenz", "houses_damaged", 0]] call _inidbi;

//Zerstörte Häuser
houses_ruined = ["read", ["Missionspersistenz", "houses_ruined", 0]] call _inidbi;

//Ruinen - Positionen
ruinen = ["read", ["Missionspersistenz", "Ruinen", []]] call _inidbi;


intel = ["read", ["Missionspersistenz", "Intel", [[],[],[]]]] call _inidbi;


ieds_defused = ["read", ["Missionspersistenz", "Defused", 0]] call _inidbi;

//Gesprengte IEDs
ieds_gesprengt = ["read", ["Missionspersistenz", "Detonated", 0]] call _inidbi;

losses = ["read", ["Missionspersistenz", "losses", [0,0,0,0]]] call _inidbi;
east_losses = losses select 0;
west_losses = losses select 1;
ind_losses = losses select 2;
civ_losses = losses select 3;

/*////////////////////////////////////////
/ Bezüglich Logistik, Basisbau, Fahrzeuge/
////////////////////////////////////////*/





//Im Einsatz stehende Fahrzeuge abrufen
Fahrzeuge = ["read", ["Fuhrpark", "Fahrzeuge", []]] call _inidbi;

Fahrzeuge_Temp = [];
if (count Fahrzeuge > 0) then {
  for "_i" from 1 to (count Fahrzeuge) do {
    Fahrzeuge_Temp pushBack [(Fahrzeuge select (_i - 1)) select 0, (Fahrzeuge select (_i - 1)) select 1, (Fahrzeuge select (_i - 1)) select 2, (Fahrzeuge select (_i - 1)) select 3, objNull, (Fahrzeuge select (_i - 1)) select 4, (Fahrzeuge select (_i - 1)) select 5];
    if !(((Fahrzeuge_Temp select (_i - 1)) select 2) IN ["v","p"]) then {
      [((Fahrzeuge_Temp select (_i - 1)) select 0)] call zumi_fnc_fuhrpark_startspawn;
    };
    if (!(((Fahrzeuge_Temp select (_i - 1)) select 2) IN ["p"]) && (((Fahrzeuge select (_i - 1)) select 3) isKindOf "Plane")) then {
      (Fahrzeuge select (_i - 1)) set [2, "p"];
      (Fahrzeuge_Temp select (_i - 1)) set [2, "p"];
    };
  };
};
publicVariable "Fahrzeuge_Temp";

//Fortify - Budget abrufen
acex_fortify_budget_west = ["read", ["Missionspersistenz", "Fortifybudget", 500]] call _inidbi;
publicVariable "acex_fortify_budget_west";
[west, acex_fortify_budget_west, befestigungsobjekte] call acex_fortify_fnc_registerObjects;

fortify_objekte_temp = [];
//Platzierte Fortify - Objekte abrufen
fortify_objekte = ["read", ["Missionspersistenz", "Fortifyobjekte", []]] call _inidbi;
[fortify_objekte] call zumi_fnc_fortify_spawn;

//Vorhandene Gütercontainer etc. abrufen (Nummerierte Objekte)
lagerbestand = ["read", ["Lager", "Lagerbestand", []]] call _inidbi;
lagerbestand_Temp = [];
if ((count lagerbestand) > 0) then {
  for "_i" from 1 to (count lagerbestand) do {
    (lagerbestand select (_i - 1)) params ["_nr"];
    private _ggst = ["read", ["Lager", format ["ggst_%1", _nr], []]] call _inidbi;
    [_ggst] call zumi_fnc_ggst_spawn;
  };
};


//Aktive Bestellungen, die am Server gespeichert werden, sind mit einer Nummer verzeichnet.
private _bestellungen = ["read", ["Missionspersistenz", "Bestellungen", []]] call _inidbi;
bestellungen = [];
if ((count _bestellungen) > 0) then {
  for "_i" from 1 to (count _bestellungen) do {
    private _bstl = ["read", ["Missionspersistenz", format ["bstl_%1", (_bestellungen select (_i - 1))], []]] call _inidbi;
    bestellungen pushBack _bstl;
  };
};
publicVariable "bestellungen";

//Villages
[] call zumi_fnc_init_villages;

//Starte Tasks
[] call zumi_fnc_maintask_master;

addMissionEventHandler ["HandleDisconnect", {
	params ["_unit", "_id", "_uid", "_name"];
  private _inidbi = ["new", "us"] call OO_INIDBI;
  ["write", ["Spielerliste",
    //Eintragsname
    _uid,
    [
      //LOADOUT
      [getUnitLoadout [_unit, false]] call acre_api_fnc_filterUnitLoadout,
      //MEDIZINISCHES
      [
        _unit getVariable ["isDeadPlayer", false],
        _unit getVariable ["ACE_isUnconscious", false],
        parseNumber ([(_unit getVariable ["acex_field_rations_thirst", 0]), 1, 4] call CBA_fnc_formatNumber),
        parseNumber ([(_unit getVariable ["acex_field_rations_hunger", 0]), 1, 4] call CBA_fnc_formatNumber)
      ],
      [
        _unit getVariable ["ace_medical_medicClass", 0],
        _unit getVariable ["ACE_IsEngineer", 0],
        _unit getVariable ["ACE_isEOD", false],
        _unit getVariable ["323_pilot", 0],
        _unit getVariable ["323_panzer", 0],
        _unit getVariable ["323_logistiker", 0],
        _unit getVariable ["323_keys", []],
        _unit getVariable ["323_waka", 1],
        _unit getVariable ["entscheidungsbefugnis", 0]
      ],
      getPosATL _unit,
      [restart_nummer, cba_missiontime],
      _name,
      (_unit getVariable ["BIS_fnc_setUnitInsignia_class", ""]),
      (_unit getVariable ["vehicle", [-1, "", []]]),
      format ["Spieler getrennt: %1", timestamp]
    ]
  ]] call _inidbi;
	false;
}];

addMissionEventHandler ["BuildingChanged", {
    params ["_buildingOld", "_buildingNew", "_isRuin"];
    (boundingBoxReal _buildingOld) params ["_a","_b"];
    _rad = (sizeOf (typeOf _buildingOld)) / 2;
    //Find closest Sector to building
    _closest_sector = [commy_sectors, {-(_buildingOld distance2d _x)}, objNull] call CBA_fnc_selectBest;
    if (_isRuin) then {
      ["zumi_sanktion", [linearConversion [4, 25, _rad, -1, -5, true], commy_sectors find _closest_sector, true]] call CBA_fnc_localEvent;
      houses_ruined = houses_ruined + 1;
    } else {
      ["zumi_sanktion", [linearConversion [4, 25, _rad, -0.5, -1.5, true], commy_sectors find _closest_sector, true]] call CBA_fnc_localEvent;
      houses_damaged = houses_damaged + 1;
    };
    if (count zumi_misc > 0) then {
      {
          if (((_x distance2d _buildingOld) <= _rad) && (((getPosATL _x) select 2) > 0.1)) then {
              zumi_misc deleteAt _forEachindex;
              deleteVehicle _x;
          };
      } forEach zumi_misc;
    };
    if (count fortify_objekte_temp > 0) then {
      {
          _x params ["_obj", "_posatl", "_pby"];
          if (((_obj distance2d _buildingOld) <= _rad) && (((parseSimpleArray _posatl) select 2) > 0.1)) then {
              fortify_objekte_temp deleteAt _forEachindex;
              deleteVehicle _obj;
          };
      } forEach fortify_objekte_temp;
    };
}];



//Starte repetitives Cleanup
[] call zumi_fnc_cleanup;

//Starte Speicherloop alle 1 Min (1 Min bis zur ersten Speicherung)

[
  zumi_fnc_speichern,
  [],
  60
] call CBA_fnc_waitAndExecute;


//Serverseitig fertig
