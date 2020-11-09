/*

  Aktualisiert die Liste der lieferbaren Einheiten
  Die Kategorie wird über einen vordefinierten Wert eines Listboxitems ermittelt und entspricht numerisch der Auflistung der Güterklassen im konfigurierten Array.
  Alphabetisch wird die Listbox allerdings zur Vereinfachung der Übersicht für den Spieler sortiert.

*/


disableSerialization;


//Finde GUI
_display = findDisplay 2021;
//Access control
_liste = _display displayCtrl 1617;
_kategorie = _liste lbValue (lbcursel _liste);
_liste = _display displayCtrl 1616;
lbClear _liste;
for "_i" from 0 to (count ((Bestellbare select _kategorie) select 2))-1 do {
  (((Bestellbare select _kategorie) select 2) select _i) params ["_id","_classname","_icon","_anzeigename","_platzverbrauch","_cargo"];
  _liste lbAdd _anzeigename;
  _liste lbSetValue [_i, _id];
  _liste lbSetPictureRight [_i, _icon];
  _liste lbSetToolTip [_i, format ["Used ACE cargo space: %1", _platzverbrauch]];
};
lbSort [_liste, "ASC"];
_liste lbSetCurSel 0;
