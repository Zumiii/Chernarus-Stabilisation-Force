/*

  Zeigt die Kategorien der gewünschten Bestellungsmöglichkeit an.
  1 : Luftfrachtbestellung
  2 : Zementwerkbestellung
  3 : Sägewerkbestellung

*/

disableSerialization;


//Finde GUI
_display = findDisplay 2021;
//Access control
_liste = _display displayCtrl 1617;
lbClear _liste;
for "_i" from 0 to (count Bestellbare) - 1 do {
  (Bestellbare select _i) params ["_kategoriename","_icon","_liefereinheiten"];
  _liste lbAdd _kategoriename;
  _liste lbSetValue [_i, _i];
  _liste lbSetPictureRight [_i, _icon];
};
lbSort [_liste, "ASC"];
_liste lbSetCurSel 0;
