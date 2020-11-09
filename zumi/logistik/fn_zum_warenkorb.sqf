/*

  Frachteinheit dem Warenkorb hinzufügen, wenn möglich.
  Progressbar updaten

*/

disableSerialization;


//Finde GUI
_display = findDisplay 2021;

//Liste mit Kategorien
_kategorien = _display displayCtrl 1617;
_kategorie_id = _kategorien lbValue (lbcursel _kategorien);

//Frachteinheiten Liste
_liste = _display displayCtrl 1616;
//Warenkorb Liste
_warenkorb = _display displayCtrl 1618;
_progressbar = _display displayCtrl 1620;
_frachtname = _liste lbText (lbcurSel _liste);
buttonSetAction [1619, ""];

_bestellung = [];


_geaddet = false;
{
  for "_i" from 0 to (count _x) - 1 do {
    if (_geaddet) exitWith {};
    _x params ["_kategoriename","_icon","_liefereinheiten"];
    for "_j" from 0 to (count _liefereinheiten)-1 do {
      if (_geaddet) exitWith {};
      (_liefereinheiten select _j) params ["_id","_classname","_icon","_anzeigename","_platzverbrauch","_cargo"];
      if (_anzeigename isEqualTo _frachtname && (((progressPosition _progressbar) + (5*_platzverbrauch/100)) < 1.001)) exitWith {
        _geaddet = true;
        _index = _warenkorb lbAdd format ["%1: ", _anzeigename];
        _warenkorb lbSetPictureRight  [_index, _icon];
        _warenkorb lbsetvalue [_index , _id];
        _warenkorb lbSetData [_index, str _kategorie_id];
        [_warenkorb, _index] call zumi_fnc_update_progressbar;
      };
    };
  };
} forEach Bestellbare;

_size =  (lbSize _warenkorb);
if (_size > 0) then {
  for "_i" from 1 to _size do {
    _bestellung pushBack [parseNumber (_warenkorb lbdata (_i - 1)), (_warenkorb lbValue (_i - 1))];
  };
};

buttonSetAction [1619, format ["closeDialog 0; [player, %1] remoteExecCall ['zumi_fnc_bestellung_ausloesen', 2];", _bestellung]];
