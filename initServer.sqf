
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

max_spawns = ["read", ["Missionspersistenz", "max_spawns", 10]] call _inidbi;

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
haus_schaden = ["read", ["Missionspersistenz", "Einsturzgefahr", 0]] call _inidbi;

//Zerstörte Häuser
haus_kaputt = ["read", ["Missionspersistenz", "Einsturz", 0]] call _inidbi;

//Ruinen - Positionen
ruinen = ["read", ["Missionspersistenz", "Ruinen", []]] call _inidbi;


intel = ["read", ["Missionspersistenz", "Intel", [[],[],[]]]] call _inidbi;


ieds_defused = ["read", ["Missionspersistenz", "Defused", 0]] call _inidbi;

//Gesprengte IEDs
ieds_gesprengt = ["read", ["Missionspersistenz", "Detonated", 0]] call _inidbi;

/*////////////////////////////////////////
/ Bezüglich Logistik, Basisbau, Fahrzeuge/
////////////////////////////////////////*/


//Fortify - Budget abrufen
acex_fortify_budget_west = ["read", ["Missionspersistenz", "Fortifybudget", 500]] call _inidbi;
publicVariable "acex_fortify_budget_west";
[west, acex_fortify_budget_west, befestigungsobjekte] call acex_fortify_fnc_registerObjects;

fortify_objekte_temp = [];
//Platzierte Fortify - Objekte abrufen
fortify_objekte = ["read", ["Missionspersistenz", "Fortifyobjekte", []]] call _inidbi;
[fortify_objekte] call zumi_fnc_fortify_spawn;


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

//Starte Tasks
[] call zumi_fnc_maintask_master;


addMissionEventHandler ["BuildingChanged", {
    params ["_buildingOld", "_buildingNew", "_isRuin"];
    (boundingBoxReal _buildingOld) params ["_a","_b"];
    _rad = (sizeOf (typeOf _buildingOld)) / 2;
    if (_isRuin) then {
      ["zumi_sanktion", [linearConversion [4, 25, _rad, -1, -5, true]]] call CBA_fnc_localEvent;
    } else {
      ["zumi_sanktion", [linearConversion [4, 25, _rad, -0.5, -1.5, true]]] call CBA_fnc_localEvent;
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

//Killcounter
addMissionEventHandler ["EntityKilled", {
  params ["_killed", "_killer", "_instigator"];
  _killed setVariable ["tod", cba_missiontime];
  if (!isPlayer _killer) exitWith {};
  if (_killed isKindOf "Goat_random_F") exitWith {
    ["zumi_sanktion", [-1, (_killed getVariable ["id", -1])]] call CBA_fnc_localEvent;
  };
  if (side _killed == civilian) then {
    ["zumi_sanktion", [-5, (_killed getVariable ["id", -1])]] call CBA_fnc_localEvent;
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
