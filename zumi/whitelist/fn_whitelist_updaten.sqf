/*

  Aktualisiert den whitelist_dialog

*/

disableSerialization;

// Find GUI
_display = findDisplay 2310;

// Access control
_spielerliste = _display displayCtrl 2311;
_fzgliste = _display displayCtrl 2312;

_spieler = (([] call cba_fnc_players) select {(getPlayerUID _x) isEqualTo (_spielerliste lbData (lbcursel _spielerliste))}) select 0;

_keys = _spieler getVariable ["323_keys", []];

//Flagge Fahrzeuge, für die vom Spieler Schlüssel vh. sein sollten
{
  for "_i" from 0 to (lbSize _fzgliste) - 1 do {
    if ((_fzgliste lbValue _i) isEqualTo _x) then {
      _fzgliste lbSetSelected [_i, true];
    };
  };
} forEach _keys;

_medic = _spieler getVariable ["ace_medical_medicClass", 0];
_pio = _spieler getVariable ["ACE_IsEngineer", 0];
_eod = _spieler getVariable ["ACE_isEOD", 0];
_pilot = _spieler getVariable ["323_pilot", 0];
_panzer = _spieler getVariable ["323_panzer", 0];
_logistiker = _spieler getVariable ["323_logistiker", 0];
_key = _spieler getVariable ["323_keys", []];


//Aktualisiere alle Buttons für Variablen
[false, _spieler, _spieler, _medic, _pio, _eod, _pilot, _panzer, _logistiker, _key] call zumi_fnc_whitelistbuttons_updaten;
