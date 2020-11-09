
/*

  Whitelistverwaltung

*/

if !isServer exitWith {};

params ["_callerUID","_spielerUID","_recht","_wert"];



//Aus Datenbank abrufen
_inidbi = ["new", "us"] call OO_INIDBI;
_whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;



_array_1 = ([] call cba_fnc_players) select {(getPlayerUID _x) isEqualTo _callerUID};
if (_array_1 isEqualTo []) exitWith {};
_caller = _array_1 select 0;

_array_2 = ([] call cba_fnc_players) select {(getPlayerUID _x) isEqualTo _spielerUID};
if (_array_2 isEqualTo []) exitWith {};
_spieler = _array_2 select 0;



if ({_x isEqualTo (getPlayerUID _caller)} count _whitelist < 1) exitWith {
  "Sie sind dazu nicht berechtigt." remoteExecCall ["hint", _caller];
};


switch _recht do {
  case "panzer" : {
    _spieler setVariable ["323_panzer", _wert, true];
  };
  case "eod" : {
    if (_wert IN ["1", true, 1]) then {
      _spieler setVariable ["ACE_isEOD", true, true];
    } else {
      _spieler setVariable ["ACE_isEOD", false, true];
    };

  };
  case "medic" : {
    _spieler setVariable ["ace_medical_medicClass", _wert, true];
  };
  case "pio" : {
    _spieler setVariable ["ACE_IsEngineer", _wert, true];
  };
  case "pilot" : {
    _spieler setVariable ["323_pilot", _wert, true];
  };
  case "keys" : {
    _spieler setVariable ["323_keys", _wert, true];
  };
  case "logistiker" : {
    _spieler setVariable ["323_logistiker", _wert, true];
    _inidbi = ["new", "us"] call OO_INIDBI;
    _whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;
    if (_wert IN ["1", true, 1]) then {
      _whitelist pushBackUnique (getPlayerUID _spieler);
      ["write", ["Whitelist", "Logistiker", _whitelist]] call _inidbi;
    } else {
      ["write", ["Whitelist", "Logistiker", _whitelist select {!(_x isEqualto (getPlayerUID _spieler))}]] call _inidbi;
    };
  };

  default {};
};


"Rechte gesetzt. Logistiker sind sofort registriert. Für den Rest gedulden Sie sich maximal 60 Sierra!" remoteExecCall ["hint", _caller];
"Ihr Rechte wurden geändert!" remoteExecCall ["hint", _spieler];
