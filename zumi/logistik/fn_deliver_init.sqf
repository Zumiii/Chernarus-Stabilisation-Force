/*

  Kurzbeschrieb:
  Dieses File prüft, ob Lieferungen anstehen und löst sie aus, insofern die Uhrzeit zwischen 6 und 18 Uhr liegt.

*/

if !isServer exitWith {};

if ((count bestellungen) == 0) exitWith {};

private _inidbi = ["new", "us"] call OO_INIDBI;

_jahr = date select 0;
_bestellungen = [];

for "_i" from 1 to (count bestellungen) do {
  (bestellungen select (_i - 1)) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
  _bestellungen pushBack _auftragsnummer;
  //Liefere am Stichtag
  if (_bearbeitungsstatus == "sent") then {
    (bestellungen select (_i - 1)) set [5, "delivered"];
    [(bestellungen select (_i - 1))] call zumi_fnc_deliver;
  };
  //Lösche Einträge, die quittiert wurden in einer Form aus dem Archiv
  if (_bearbeitungsstatus IN ["reported lost","received"]) then {
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
