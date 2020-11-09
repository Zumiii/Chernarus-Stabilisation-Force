/*

  Kurzbeschrieb:
  Dieses File prüft, ob Lieferungen anstehen und löst sie aus, insofern die Uhrzeit zwischen 6 und 18 Uhr liegt.

*/

if !isServer exitWith {};

params ["_tasknr"];

if ((count bestellungen) == 0) exitWith {};

private _inidbi = ["new", "us"] call OO_INIDBI;

_jahr = date select 0;
_bestellungen = [];

for "_i" from 1 to (count bestellungen) do {
  (bestellungen select (_i - 1)) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
  _lieferjahr = (_liefertermin select 0);
  _bestellungen pushBack _auftragsnummer;
  //Bestellungen, die <=36 Stunden vor dem Liefertermin sind, sind verladen. Verladene Sendungen können noch storniert oder verzögert werden.
  if (((dateToNumber _liefertermin) - (dateToNumber date) <= (((1/365)/2) + (1/365))) && (_jahr == _lieferjahr) && !(_bearbeitungsstatus IN ["storniert","abgeschrieben","quittiert"])) then {
    (bestellungen select (_i - 1)) set [5, "verladen"];
  };

  //Bestellungen, die <=12 Stunden "" sind versendet, keine Stornierung mehr möglich dann.
  if (((dateToNumber _liefertermin) - (dateToNumber date) <= ((1/365)/2)) && (_jahr == _lieferjahr) && !(_bearbeitungsstatus IN ["storniert","abgeschrieben","quittiert"])) then {
    (bestellungen select (_i - 1)) set [5, "versendet"];
  };

  //Liefere am Stichtag
  if (([_liefertermin select 2, _liefertermin select 1, _liefertermin select 0] isEqualTo [date select 2, date select 1, date select 0]) && !(_bearbeitungsstatus IN ["geliefert","storniert","abgeschrieben","quittiert"])) then {
    (bestellungen select (_i - 1)) set [5, "geliefert"];
    [_tasknr, (bestellungen select (_i - 1))] call zumi_fnc_lieferungstask;
  };

  //Lösche Einträge, die älter sind als drei Tage und quittiert wurden in einer Form aus dem Archiv
  if ((_bearbeitungsstatus IN ["storniert","abgeschrieben","quittiert"]) && ((dateToNumber date) - (dateToNumber _liefertermin) >= (3/365)) && (_jahr >= _lieferjahr)) then {
    //Lösche Datenbankeintrag
    ["deleteKey", ["Missionspersistenz", format ["bstl_%1", _auftragsnummer]]] call _inidbi;
    bestellungen deleteAt (_i - 1);
    _bestellungen deleteAt (_i - 1);
  };

};

publicVariable "bestellungen";

//Speichere neu ab!
for "_i" from 1 to (count bestellungen) do {
  (bestellungen select (_i - 1)) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
  ["write", ["Missionspersistenz", format ["bstl_%1", _auftragsnummer], [_auftragsnummer, _bestelldatum, _liefertermin, _auftraggeber, _waren_ids, _bearbeitungsstatus]]] call _inidbi;
};


["write", ["Missionspersistenz", "bestellungen", _bestellungen]] call _inidbi;
