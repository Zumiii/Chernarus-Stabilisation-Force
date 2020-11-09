
/*

  Gruppe fragt Kommandeur(e) für neue Befehle.
  Ist kein Kommandeur mehr am leben und oder ist ihr Kommunikationsnetz zusammengebrochen, entschliesst sich die Gruppe, das Zentrum alarmiert zu patrouilleren und ihre Stellung aufzugeben.
  Neue Befehle werden erst in 10 Minuten erneut erfragt.

  Die Gruppen haben unterschiedliche Aufgaben
  - Späher (Klären auf)
  - Feuerleitoffiziere (Geben Ziele durch für Mörser, Arti und Luftunterstützung)
  - Allg. Patrouillen
  - AT Einheiten
  - AA Einheiten
  - Mörser und Artillerieeinheiten
  - Lufteinheiten (Radarerfasste Ziele werden mit reveal den Feuerleitoffizieren eröffnet

  fusstrupp
  at_trupp
  aa_trupp
  trupp_mech
  panzer
  mobile_luftabwehr
  funkmobil
  trupp_mot
  spaeher
  artillerie
  luftschlag
  starrfluegler

*/

params ["_grp","_position"];

_grp setvariable ["befehl", []];

//Schicke Gruppe für 10 Minuten auf Patrouille, wenn Funknetz zusammengebrochen ist und oder Offiziere tot sind
if ({alive _x} count zumi_funknetz == 0 || {alive _x} count zumi_kommandeure == 0) exitWith {
  [leader _grp] call CBA_fnc_clearWaypoints;
  [(units _grp)] call ace_ai_fnc_unGarrison;
  [_grp, _position, radius, 4, "MOVE", "AWARE", "YELLOW", "NORMAL", "STAG COLUMN", "", [5, 10, 15]] call CBA_fnc_taskPatrol;
  [
    {
      params ["_grp","_ziel"];
      if ({alive _x} count (units _grp) == 0 || isNull _grp) exitWith {};
      [_grp, _ziel] call zumi_fnc_befehl_erfragen;
    },
    [_grp,_position],
    600
  ] call CBA_fnc_waitAndExecute;
};

[leader _grp] call CBA_fnc_clearWaypoints;



_typ = _grp getVariable ["truppengattung", "fusstrupp"];

if (_typ IN ["fusstrupp", "spaeher", "at_trupp", "aa_trupp"]) exitWith {

  switch (floor (random 5)) do {
    case 0 : {
      //Der Kommandant erwägt, eigene verlorene Stellungen wieder zu besetzen
      if ({count ([(_x select 0) call CBA_fnc_getPos, 150, east] call zumi_fnc_nahe_ki) < 1} count zumi_stellungen > 0) then {
        private _stellung = (selectrandom zumi_stellungen) select 5;
        [_grp, _stellung, "besetzen", 1200] call zumi_fnc_befehl_erhalten;
      } else {
        //Der Kommandant erwägt, Stellungen zu überprüfen
        private _stellung = (selectrandom zumi_stellungen) select 5;
        [_grp, _stellung, "pruefen", 200] call zumi_fnc_befehl_erhalten;
      };
    };
    case 1 : {
      private _stellung = (selectrandom zumi_stellungen) select 5;
      //Einheiten auf Patrouille schicken und nach 15 min für Befehle bereithalten
      [_grp, _stellung, "patrouillieren", 900] call zumi_fnc_befehl_erhalten;
    };
    default {
      //Einheit soll zwischen Punkten im Zentrum patrouillieren
      [_grp, zumi_taskpos, "patrouillieren", 1200, objNull, radius] call zumi_fnc_befehl_erhalten;
    };
  };

};

if (_typ IN ["funkmobil", "mobile_luftabwehr", "artillerie"]) exitWith {
  [_grp, _position, "verteidigen"] call zumi_fnc_befehl_erhalten;
};

//motorisierte Kräfte sehen mal nach den eigenen Einheiten
if (_typ IN ["trupp_mech","panzer","trupp_mot"]) exitWith {
  if ((random 1) > 0.5) then {
    [_grp, (selectrandom zumi_stellungen) select 5, "pruefen", 300] call zumi_fnc_befehl_erhalten;
  } else {
    [_grp, (selectrandom zumi_stellungen) select 5, "patrouillieren", 600] call zumi_fnc_befehl_erhalten;
  };
};

//Der Rest soll Patrouille starten
[_grp, (selectrandom zumi_stellungen) select 5, "patrouillieren", 600] call zumi_fnc_befehl_erhalten;
