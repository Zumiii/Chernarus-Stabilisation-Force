/*

  Diese Funktion initialisiert die zufälligen Begegnungen und legt ihre Varietät missionsphasenspezifisch fest.

  Parameter:
  - Phase (Skalar)
  - villages (Array)

*/

if !isServer exitWith {};

params ["_phase","_villages"];

private ["_parameter","_return"];

_spannung = 0;
for "_i" from 0 to ((count _villages) - 1) do {
  _spannung = _spannung + (((_villages select _i) select 3) select 0);
};
_spannung = _spannung  / (count _villages);

_return = [_phase, _spannung, (count _villages)] call zumi_fnc_dyn_zusammensetzung;


dyn_array = [];

_positions = [];
for "_i" from 0 to (count villages)-1 do {
  _pos = [((villages select _i) select 2), 500, 1, 1, 150, 1.5, 0.45, false, true] call zumi_fnc_rnd_pos;
	if !(_pos isEqualTo []) then {
		_positions pushBack _pos;
	};
};

for "_j" from 0 to (count _return) - 1 do {
  _orders = [_positions, grpNull, [], (_return select _j), [[0,0,0],[0, ""]], false] call zumi_fnc_dyn_ask_for_orders;
  _orders params ["_neuziel", "_order"];
  _dyn = [count dyn_array]; // ID
  _dyn set [1, false]; //Deaktivieren
  _dyn set [2, (_positions call BIS_fnc_SelectRandom)]; //Startpos
  _dyn set [3, _neuziel];
  _dyn set [4, (_return select _j)]; //Was begegnet einem?
  _dyn set [5, grpNull]; // Placeholdergrp
  _dyn set [6, []]; // Fahrzeugarray
  _dyn set [7, _orders]; // Aktueller Befehl
  //Für das Debugging Marker erstellen
  if (debug) then {
    _marker = createmarkerLocal [format ["dyn_entity%1", count dyn_array], (_dyn select 2)];
    _marker setmarkershapeLocal "ICON";
    _marker setmarkertypeLocal ((_return select _j) select 3);
    _marker setmarkercolorLocal ((_return select _j) select 4);
    if (((_return select _j) select 0) isEqualTo "zu Fuss") then {
      _marker setmarkerTextLocal format ["%1, %2", ((_return select _j) select 5), ((_return select _j) select 0)];
    } else {
      _marker setmarkerTextLocal ((_return select _j) select 5);
    };
  };
  dyn_array pushback _dyn;
};

[_positions, dyn_array] spawn zumi_fnc_dyn_loop;
