
/*

  Gibt Infos über den Verbleib des Fahrzeuges

*/

params ["_id"];

_veh = fahrzeuge_temp select _id;

private _players = ([] call cba_fnc_players);
private _keyowners = _players select {_id IN (_x getVariable ["323_keys", []])};
private _pos = (fahrzeuge_temp select _id) select 2;
if (_pos isEqualTo "v") exitWith {
  ["zumi_cba_hinweis", [["No Signal received...", 1.5, [1,0.5,0,1]]]] call CBA_fnc_localEvent;
};
if (_pos isEqualTo "p") exitWith {
  ["zumi_cba_hinweis", [["This vehicle is currently not in use...", 1.5, [0,0,0.5,1]]]] call CBA_fnc_localEvent;
};



_message = [];
_message pushBack [format ["Last known grid position: %1", mapGridPosition _pos], 1.5, [0,0.75,0,1]];
if ((count _keyowners) < 1) exitWith {
  ["zumi_cba_hinweis", [_message]] call CBA_fnc_localEvent;
};
_message pushBack ["Key owners:", 1.5, [1,1,1,1]];
for "_i" from 0 to (count _keyowners) - 1 do {
  _message pushBack [name (_keyowners select _i), 1, [1,1,1,1]];
};
["zumi_cba_hinweis", [_message]] call CBA_fnc_localEvent;
