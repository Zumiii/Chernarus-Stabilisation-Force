/*

  Öffnet den whitelist_dialog

*/

disableSerialization;

// Find GUI
_display = findDisplay 2310;

// Access control
_spielerliste = _display displayCtrl 2311;

_spieler = ([] call cba_fnc_players);
{
  _index = _spielerliste lbAdd (name _x);
  _spielerliste lbSetData [_index, getPlayerUID _x];
} forEach _spieler;

_keys = (_spieler select 0) getVariable ["323_keys", []];

_fzgliste = _display displayCtrl 2312;
{
  _x params ["_id","_aktiv","_status","_typ","_objekt", "_name", "_datum"];
  _index = _fzgliste lbAdd (str _id);
  _anzeigebild = getText (configFile >> "CfgVehicles" >> _typ >> "Picture");
  _fzgliste lbSetPictureRight [_index, _anzeigebild];
  _fzgliste lbSetValue [_index, _id - 1];
  if (_id IN _keys) then {
    _fzgliste lbSetSelected [_index, true];
  } else {
    _fzgliste lbSetSelected [_index, false];
  };
} forEach Fahrzeuge_Temp;

// Select default item
_spielerliste lbSetCurSel 0;
_fzgliste lbSetCurSel -1;
