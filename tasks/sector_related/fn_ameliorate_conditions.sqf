if !isServer exitWith {};

params [
  "_id",
  "_amelioration",
  "_player",
  "_target",
  "_item"
];




private _currentSituation = ((villages select _id) select 3) select 1;
if (_currentSituation + _amelioration >= 100) exitWith {
  _target setVariable ["can_turn_in_humanitarian", false, false];
  ["zumi_hinweis", ["The chieftain took what his people needed and thanks you!", false, 8, 1], _player] call CBA_fnc_targetEvent;
  ["zumi_sanktion", [_size, _id, true]] call CBA_fnc_serverEvent;
  deleteVehicle _item;
  
};

["zumi_hinweis", ["The chieftain thanks you, but he can still need some more!", false, 8, 1], _player] call CBA_fnc_targetEvent;
["zumi_sanktion", [_size, _id, true]] call CBA_fnc_serverEvent;
deleteVehicle _item;
