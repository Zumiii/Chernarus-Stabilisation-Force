/*

  Prüft archivierte Aufträge:
  Gibt Aufschluss über vergangene Aktivitäten der Logistiker/innen

*/
if (isServer) exitWith {};

params ["_button","_value"];

switch _button do {
  case "details" : {
    (bestellungen select _value) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_abholungsort","_waren","_bearbeitungsstatus","_icon"];
    _txt_array = [];
    _br = parseText "<br />";
    _time = 5;
    _masse = 0;
    _txt_array pushBack (parseText "<t align='left'><t size='1' color='#F7FE2E'>Artikel</t>");
    _txt_array pushBack (parseText "<t align='right'><t size='1' color='#F7FE2E'>Frachtmasse</t>");
    _txt_array pushBack _br;
    _txt_array pushBack _br;
    for "_i" from 0 to (count _waren)-1 do {
      (_waren select _i) params ["_id","_classname","_icon","_anzeigename","_platzverbrauch","_cargo","_stueckzahl"];
      _txt_array pushBack (parseText format ["<t align='left'> %1 </t>",_anzeigename]);
      _txt_array pushBack (parseText format ["<t align='right'> %1 </t>",_platzverbrauch]);
      _time = _time + 2;
      _masse = _masse + _platzverbrauch;
      if (_i == (count _waren)-1) exitWith {};
      _txt_array pushBack _br;
    };
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='right'><t size='1'>%1</t>", "___"]);
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='right'><t size='1'>%1</t>", _masse]);
    _txt_array pushBack _br;
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='left'><t size='1' color='#F7FE2E'>Bearbeitungsstatus: %1</t>", _bearbeitungsstatus]);
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='left'><t size='1' color='#F7FE2E'>Abholungsort: %1</t>", _abholungsort]);
    _txt_array pushBack _br;
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='left'><t size='1' color='#F7FE2E'>Bestellende/r: %1</t>", _auftraggeber]);
    _txt = composeText _txt_array;
    [_txt, false, _time, 5] call ace_common_fnc_displayText;
  };
  case "pruefen" : {
    (bestellungen select _value) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_abholungsort","_waren","_bearbeitungsstatus","_icon"];
    _bstl = numberToDate [(date select 0),_bestelldatum];
    _txt_array = [];
    _br = parseText "<br />";
    _time = 5;
    _masse = 0;
    _txt_array pushBack (parseText "<t align='left'><t size='1' color='#F7FE2E'>Artikel</t>");
    _txt_array pushBack _br;
    _txt_array pushBack _br;
    for "_i" from 0 to (count _waren)-1 do {
      (_waren select _i) params ["_id","_classname","_icon","_anzeigename","_platzverbrauch","_cargo","_stueckzahl"];
      _txt_array pushBack (parseText format ["<t align='left'> %1 </t>",_anzeigename]);
      _time = _time + 2;
      _masse = _masse + _platzverbrauch;
      if (_i == (count _waren)-1) exitWith {};
      _txt_array pushBack _br;
    };
    _txt_array pushBack _br;
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='left'><t size='1' color='#F7FE2E'>Bearbeitungsstatus: %1</t>", _bearbeitungsstatus]);
    _txt_array pushBack _br;
    _txt_array pushBack _br;
    _txt_array pushBack (parseText format ["<t align='left'><t size='1' color='#F7FE2E'>Bestellung wurde %1 durch: %2 am %3.%4.%5</t>",_bearbeitungsstatus, _name, str (_bstl select 2),str (_bstl select 1),str (_bstl select 0)]);
    _txt = composeText _txt_array;
    [_txt, false, _time, 5] call ace_common_fnc_displayText;
  };
};
