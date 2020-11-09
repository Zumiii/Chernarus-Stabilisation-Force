/*

  Lieferungen verwalten

*/


params ["_player","_button","_value","_name"];


_inidbi = ["new", "us"] call OO_INIDBI;
_whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;


if ({_x isEqualTo (getPlayerUID _player)} count _whitelist < 1) exitWith {
  "Sie sind dazu nicht berechtigt." remoteExecCall ["hint", _player];
};

switch _button do {
  case "verzoegern" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
    for "_l" from 1 to 3 do {
      //Datum zu Wert
      _float_number = dateToNumber _liefertermin;
      _jahr = _liefertermin select 0;
      _tempdate = _float_number + (_l * (1 / 365));
      if (_tempdate > 0) then {
        for "_i" from 1 to (floor _tempdate) do {
          _jahr = _jahr + 1;
          _tempdate = _tempdate - 1;
        };
      };
      _kann_verzoegern = true;
      if (count bestellungen > 0) then {
        for "_m" from 1 to (count bestellungen) do {
          (bestellungen select (_m-1)) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
          private _temptag = [(numberToDate [_jahr, _tempdate]) select 2, (numberToDate [_jahr, _tempdate]) select 1, _jahr];
          if (_temptag isEqualTo [_liefertermin select 2, _liefertermin select 1, _liefertermin select 0]) then {
            _kann_verzoegern = false;
            if (_bearbeitungsstatus IN ["storniert","quittiert","abgeschrieben","geliefert"]) then {
              _kann_verzoegern = true;
            };
          };
        };
      };
      if (_kann_verzoegern) exitWith {
        (bestellungen select _value) set [1, date];
        (bestellungen select _value) set [2, numberToDate [_jahr, _tempdate]];
        (bestellungen select _value) set [3, _name];
        "Liefertermin wurde erfolgreich verschoben" remoteExecCall ["hint", _player];
      };
      if (!(_kann_verzoegern) && (_l == 3)) exitWith {
        "Lieferverzögerung innerhalb der nächsten drei Tage nicht möglich" remoteExecCall ["hint", _player];
      };
      ["write", ["Missionspersistenz", format ["bstl_%1", count bestellungen], [count bestellungen, date, numberToDate [_jahr, _tempdate], _name, (bestellungen select _value) select 4, "bestellt"]]] call _inidbi;
    };
  };
  case "abschreiben" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) set [5,"abgeschrieben"];
    (bestellungen select _value) set [3, _name];
    (bestellungen select _value) set [1, date];
    ["write", ["Missionspersistenz", format ["bstl_%1", count bestellungen], [count bestellungen, date, (bestellungen select _value) select 2, _name, (bestellungen select _value) select 4, "abgeschrieben"]]] call _inidbi;
    "Lieferung abgeschrieben" remoteExecCall ["hint", _player];
  };
  case "quittieren" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) set [5,"quittiert"];
    (bestellungen select _value) set [3, _name];
    (bestellungen select _value) set [1, date];
    ["write", ["Missionspersistenz", format ["bstl_%1", count bestellungen], [count bestellungen, date, (bestellungen select _value) select 2, _name, (bestellungen select _value) select 4, "quittiert"]]] call _inidbi;
    "Lieferung quittiert" remoteExecCall ["hint", _player];
  };
  case "stornieren" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) set [5,"storniert"];
    (bestellungen select _value) set [3, _name];
    (bestellungen select _value) set [1, date];
    ["write", ["Missionspersistenz", format ["bstl_%1", count bestellungen], [count bestellungen, date, (bestellungen select _value) select 2, _name, (bestellungen select _value) select 4, "storniert"]]] call _inidbi;
    "Lieferung storniert" remoteExecCall ["hint", _player];
  };
  case "details" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
    _size = linearConversion [1, 25, (count _waren_ids), 4, 1];
    _message = [];
    _message pushBack [format ["Lieferstatus: %1", _bearbeitungsstatus], 1.5, [1,1,1,1]];
    for "_i" from 0 to (count _waren_ids) - 1 do {
      (_waren_ids select _i) params ["_kategorie", "_id"];
      _message pushBack [((((Bestellbare select _kategorie) select 2) select (_id - 1)) select 3), _size, [1,1,1,1]];
    };
    ["zumi_cba_hinweis", [_message], _player] call CBA_fnc_targetEvent;

  };
};

publicVariable "bestellungen";
