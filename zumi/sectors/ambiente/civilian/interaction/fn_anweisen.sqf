/*

  Spieler gibt Zivilist eine Anweisung

*/


params ["_unit", "_player", "_id", "_anweisung"];


[_unit] call CBA_fnc_clearWaypoints;
_unit enableAI "MOVE";
_unit setVariable ["kooperiert", false, true];

switch _anweisung do {
  case "kopf_runter" : {
    [_unit, "Acts_CivilHiding_1", 1] call ace_common_fnc_doAnimation;
    _unit setVariable ["in_deckung", 1, true];
    _unit setVariable ["hat_angst", 1, true];
  };
  case "in_deckung" : {
    _array = _unit call CBA_fnc_getNearestBuilding;
    _array params ["_building", "_buildingPositions"];
    if (_unit distance2d _building <= 100) then {
      private _pos = if (_buildingPositions > 1) then {selectRandom (_building buildingPos -1)} else {_building buildingPos 0};
      _unit setVariable ["in_deckung", 1, true];
      _unit setVariable ["hat_angst", 1, true];
      if ((_unit getVariable ["combattant", true]) && ((_unit getVariable ["renitenz", 0]) >= 3)) then {
        [_unit, _unit getVariable ["spawn_pos", getPosATL _unit], 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_rearm"] call CBA_fnc_addWaypoint;
      } else {
        [_unit, _pos, 0, "MOVE", "AWARE", "GREEN", "FULL", "STAG COLUMN", "[leader this, 'Acts_CivilHiding_1', 1] call ace_common_fnc_doAnimation"] call CBA_fnc_addWaypoint;
      };
    } else {
      [_unit, "Acts_CivilHiding_1", 1] call ace_common_fnc_doAnimation;
      _unit setVariable ["in_deckung", 1, true];
      _unit setVariable ["hat_angst", 1, true];
    };
  };
  case "ist_sicher" : {
    _unit setVariable ["in_deckung", 0, true];
    _unit setVariable ["hat_angst", 0, true];
    [_unit, _unit getVariable ["spawn_pos", getPos _unit], 150, 4, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", ""] call CBA_fnc_taskPatrol;
  };
};
