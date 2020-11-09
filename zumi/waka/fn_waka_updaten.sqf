/*

  Spawnt das WAKA GUI und fügt Reihen und Spalten hinzu

*/

disableSerialization;

//Finde GUI
_display = findDisplay 1130;

//Access Control
_kategorie = _display displayCtrl 1136;
_liste = _display displayCtrl 1137;

lbClear _liste;

_val = _kategorie lbvalue (lbcursel _kategorie);
_sektion = (Armory select _val);
_sektion params ["_data", "_loadouts"];

for "_i" from 0 to (count _loadouts)-1 do {
  (_loadouts select _i) params ["_info","_loadout"];
  _info params ["_titel", "_bild"];
  _index = _liste lbAdd _titel;
  _liste lbSetPictureRight [_index, _bild];
  _liste lbSetValue [_index, _i];
};

lbSort [_liste, "ASC"];
