/*

  Bestellung wird vom Warenkorb aus gemacht

*/

//disableSerialization;

params ["_player", "_items"];

//Wenn der Spieler nicht zur Bestellung berechtigt ist, Skript verlassen und auf mangelnde Berechtigung hinweisen.
private _inidbi = ["new", "us"] call OO_INIDBI;
private _whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;

if ({_x isEqualTo (getPlayerUID _player)} count _whitelist < 1) exitWith {
  "You are not authorized to order in supplies!" remoteExecCall ["hint", _player];
};

if (order_in_progress) exitWith {
  "There is already an order in progress!" remoteExecCall ["hint", _player];
};

private _restart_time = ["zeitansatz", 4] call BIS_fnc_getParamValue;

if (cba_missionTime >= (_restart_time * 3600) - 900) exitWith {
  "Not possible! Server is restarting in less than 15 minutes!" remoteExecCall ["hint", _player];
};

_bestellungen = ["read", ["Missionspersistenz", "Bestellungen", []]] call _inidbi;

"Order has been placed" remoteExecCall ["hint", _player];
//Finde heraus, was die Nummer der letzten Bestellung war
_nr = if (count _bestellungen > 0) then {
  ((selectMax _bestellungen) + 1)
} else {
  1
};

_bestellungen pushBack _nr;

["write", ["Missionspersistenz", "Bestellungen", _bestellungen]] call _inidbi;

bestellungen pushBack [_nr, date, date, [_player] call ace_common_fnc_getName, _items, "sent"];
publicVariable "bestellungen";
["write", ["Missionspersistenz", format ["bstl_%1", _nr], [_nr, date, date, [_player] call ace_common_fnc_getName, _items, "sent"]]] call _inidbi;

order_in_progress = true;
publicVariable "order_in_progress";

[
  zumi_fnc_deliver_init,
  [],
  3
] call CBA_fnc_waitAndExecute;
