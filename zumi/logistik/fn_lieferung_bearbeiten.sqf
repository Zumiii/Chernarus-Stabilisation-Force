/*

  Lieferungen verwalten

*/


params ["_player","_button","_value","_name"];


_inidbi = ["new", "us"] call OO_INIDBI;
_whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;


if ({_x isEqualTo (getPlayerUID _player)} count _whitelist < 1) exitWith {
  "You are not authorized!" remoteExecCall ["hint", _player];
};

switch _button do {
  case "verzoegern" : {
    "This is currently not implemented" remoteExecCall ["hint", _player];
  };
  case "abschreiben" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) set [5,"reported lost"];
    (bestellungen select _value) set [3, _name];
    (bestellungen select _value) set [1, date];
    ["write", ["Missionspersistenz", format ["bstl_%1", count bestellungen], [count bestellungen, date, (bestellungen select _value) select 2, _name, (bestellungen select _value) select 4, "reported lost"]]] call _inidbi;
    "Lieferung abgeschrieben" remoteExecCall ["hint", _player];
  };
  case "quittieren" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) set [5,"received"];
    (bestellungen select _value) set [3, _name];
    (bestellungen select _value) set [1, date];
    ["write", ["Missionspersistenz", format ["bstl_%1", count bestellungen], [count bestellungen, date, (bestellungen select _value) select 2, _name, (bestellungen select _value) select 4, "received"]]] call _inidbi;
    "Lieferung quittiert" remoteExecCall ["hint", _player];
  };
  case "stornieren" : {
    "This is currently not implemented" remoteExecCall ["hint", _player];
  };
  case "details" : {
    _inidbi = ["new", "us"] call OO_INIDBI;
    (bestellungen select _value) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
    _size = linearConversion [1, 25, (count _waren_ids), 4, 1];
    _message = [];
    _message pushBack [format ["State: %1", _bearbeitungsstatus], 1.5, [1,1,1,1]];
    for "_i" from 0 to (count _waren_ids) - 1 do {
      (_waren_ids select _i) params ["_kategorie", "_id"];
      _message pushBack [((((Bestellbare select _kategorie) select 2) select (_id - 1)) select 3), _size, [1,1,1,1]];
    };
    ["zumi_cba_hinweis", [_message], _player] call CBA_fnc_targetEvent;

  };
};

publicVariable "bestellungen";
