/*

  Bestellung wird vom Warenkorb aus gemacht

*/

//disableSerialization;

params ["_player", "_items"];

//Wenn der Spieler nicht zur Bestellung berechtigt ist, Skript verlassen und auf mangelnde Berechtigung hinweisen.
private _inidbi = ["new", "us"] call OO_INIDBI;
private _whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;

if ({_x isEqualTo (getPlayerUID _player)} count _whitelist < 1) exitWith {
  "Sie sind dazu nicht berechtigt." remoteExecCall ["hint", _player];
};

_bestellungen = ["read", ["Missionspersistenz", "Bestellungen", []]] call _inidbi;


//Übertrage Bestellung in die Bestellungsübersicht
_temp = ((datetonumber date) + (3 / 365));
_tempdate = _temp;
for "_l" from 0 to 11 do {
  _temp = ((datetonumber date) + (3 / 365));
  private _jahr = date select 0;
  if (_temp > 1) then {
    _jahr = _jahr + 1;
  };
  _kann_liefern = true;
  _tempdate = (_temp + (_l * (1 / 365)));
  _temptag = numberToDate [_jahr, _tempdate];
  if (count bestellungen > 0) then {
    for "_m" from 0 to (count bestellungen)-1 do {
      (bestellungen select _m) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren","_bearbeitungsstatus"];
      if ([_temptag select 2, _temptag select 1, _temptag select 0] isEqualTo [_liefertermin select 2, _liefertermin select 1, _liefertermin select 0]) then {
        _kann_liefern = false;
      };
    };
  };
  if (_kann_liefern) exitwith {
    "Bestellung getätigt" remoteExecCall ["hint", _player];
    //Finde heraus, was die Nummer der letzten Bestellung war
    _nr = if (count _bestellungen > 0) then {
      ((selectMax _bestellungen) + 1)
    } else {
      1
    };

    _bestellungen pushBack _nr;

    ["write", ["Missionspersistenz", "Bestellungen", _bestellungen]] call _inidbi;

    bestellungen pushBack [_nr, date, _temptag, name _player, _items, "bestellt"];
    publicVariable "bestellungen";
    ["write", ["Missionspersistenz", format ["bstl_%1", _nr], [_nr, date, _temptag, name _player, _items, "bestellt"]]] call _inidbi;

  };
};

if !(_kann_liefern) then {
  "Bestellung innerhalb der nächsten 14 Tage nicht möglich" remoteExecCall ["hint", _player];
};
