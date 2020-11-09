/*

  Spawnt das WAKA GUI und fügt Reihen und Spalten hinzu

*/

disableSerialization;

//Finde GUI
_display = findDisplay 1130;

//Access Control
_liste = _display displayCtrl 1136;

for "_i" from 0 to (count Armory)-1 do {
  (Armory select _i) params ["_data","_loadouts"];
  _data params ["_titel", "_bild"];
  _index = _liste lbAdd _titel;
  _liste lbSetPictureRight [_index, _bild];
  _liste lbSetValue [_index, _i];
};

lbSort [_liste, "ASC"];
_liste lbsetCursel 0;


[] call zumi_fnc_waka_updaten;
