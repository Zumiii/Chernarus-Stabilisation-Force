/*

  Aktualisiert den whitelist_dialog buttons

*/

disableSerialization;

params [["_nur_fzg", false], ["_caller", objNull], ["_player", objNull], ["_medic", 0], ["_pio", 0], ["_eod", 0], ["_pilot", 0], ["_panzer", 0], ["_logistiker", 0], ["_key", []]];

// Find GUI
_display = findDisplay 2310;
_fzgliste = _display displayCtrl 2312;


_keys = (lbSelection _fzgliste);
if (count _keys < 1) then {
  (_display displayCtrl 2313) ctrlEnable false;
};
if (_nur_fzg) exitWith {};

(_display displayCtrl 2313) ctrlEnable true;
private _txt = format ["closeDialog 0; [%2, %3, 'keys', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", (lbSelection _fzgliste), str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2313, _txt];

(_display displayCtrl 2314) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2315) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2316) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2317) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2318) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2319) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2320) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2321) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2322) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2323) ctrlSetTextColor [1, 1, 1, 1];
(_display displayCtrl 2324) ctrlSetTextColor [1, 1, 1, 1];


switch _eod do {
  case 0 : {
    (_display displayCtrl 2315) ctrlSetTextColor [1, 0, 0, 1];
  };
  case 1 : {
    (_display displayCtrl 2315) ctrlSetTextColor [0, 1, 0, 1];
  };
  default {
    (_display displayCtrl 2315) ctrlSetTextColor [0, 1, 0, 1];
  };
};

switch _logistiker do {
  case 0 : {
    (_display displayCtrl 2325) ctrlSetTextColor [1, 0, 0, 1];
  };
  case 1 : {
    (_display displayCtrl 2325) ctrlSetTextColor [0, 1, 0, 1];
  };
  default {
    (_display displayCtrl 2325) ctrlSetTextColor [1, 0, 0, 1];
  };
};

switch _panzer do {
  case 0 : {
    (_display displayCtrl 2314) ctrlSetTextColor [1, 0, 0, 1];
  };
  case 1 : {
    (_display displayCtrl 2314) ctrlSetTextColor [0, 1, 0, 1];
  };
  default {
    (_display displayCtrl 2314) ctrlSetTextColor [1, 0, 0, 1];
  };
};


switch _medic do {
  case 0 : {
    (_display displayCtrl 2318) ctrlSetTextColor [0, 1, 0, 1];
  };
  case 1 : {
    (_display displayCtrl 2317) ctrlSetTextColor [0, 1, 0, 1];
  };
  case 2 : {
    (_display displayCtrl 2316) ctrlSetTextColor [0, 1, 0, 1];
  };
};

switch _pio do {
  case 0 : {
    (_display displayCtrl 2319) ctrlSetTextColor [0, 1, 0, 1];
  };
  case 1 : {
    (_display displayCtrl 2321) ctrlSetTextColor [0, 1, 0, 1];
  };
  case 2 : {
    (_display displayCtrl 2320) ctrlSetTextColor [0, 1, 0, 1];
  };
};

switch _pilot do {
  case 0 : {
    (_display displayCtrl 2322) ctrlSetTextColor [0, 1, 0, 1];
  };
  case 1 : {
    (_display displayCtrl 2324) ctrlSetTextColor [0, 1, 0, 1];
  };
  case 2 : {
    (_display displayCtrl 2323) ctrlSetTextColor [0, 1, 0, 1];
  };
};
private _txt = format ["closeDialog 0; [%2, %3, 'panzer', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", _panzer, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2314, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'eod', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", _eod, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2315, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'medic', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 2, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2316, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'medic', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 1, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2317, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'medic', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 0, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2318, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'pio', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 0, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2319, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'pio', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 2, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2320, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'pio', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 1, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2321, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'pilot', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 0, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2322, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'pilot', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 2, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2323, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'pilot', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", 1, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2324, _txt];
private _txt = format ["closeDialog 0; [%2, %3, 'logistiker', %1] remoteExecCall ['zumi_fnc_whitelist_wahl', 2]", _logistiker, str (getPlayerUID _caller), str (getPlayerUID _player)];
buttonSetAction [2325, _txt];
