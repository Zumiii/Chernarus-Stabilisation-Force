/*

  Spieler gibt dem Zivilisten einen Gegenstand

*/


params ["_unit", "_player", "_id", "_item"];

private _removed = [_player, _item] call CBA_fnc_removeItem;
if !(_removed) exitWith {
  ["zumi_hinweis", ["You do not have any of this!", false, 8, 1], _player] call CBA_fnc_targetEvent;
};

[_player, "PutDown", 1] call ace_common_fnc_doGesture;

private _added = [_unit, _item] call CBA_fnc_addItem;
["zumi_hinweis", [format ["You gave 1x %1.", _item], false, 8, 1], _player] call CBA_fnc_targetEvent;

switch _item do {
  case "ACE_WaterBottle" : {
    _unit setVariable ["durst", 0, true];

  };
  case "ACE_Humanitarian_Ration" : {
    _unit setVariable ["hunger", 0, true];
  };
  case "ACE_packingBandage" : {
    _unit setVariable ["bandage", 0, true];
  };
};


//Das gibt einen kleinen Stabilitätsbonus
["zumi_sanktion", [1, _id]] call CBA_fnc_serverEvent;
