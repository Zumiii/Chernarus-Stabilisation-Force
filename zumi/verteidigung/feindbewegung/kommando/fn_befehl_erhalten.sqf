/*

  Gruppe erhält Informationen über die Bewegung von Bluforkräften von Meldern und erhält verschiedene Befehle (von offizieren bzw. Informanten) und befolgt diese für maximal x Sekunden bzw. ständig.

*/



params ["_grp", "_zielkoordinate", ["_auftrag","verlegen"], ["_dauer",-1], ["_target", objNull], ["_radius", 75]];

if !(local _grp) exitWith {};

//Lösche alten Wegpunkt
[leader _grp] call CBA_fnc_clearWaypoints;
//Falls sie eine Garnison waren, abziehen
if ({(_x getVariable ["ace_ai_garrisonned", false])} count (units _grp) > 0) then {
  [(units _grp)] remoteExecCall ["ace_ai_fnc_unGarrison", _grp];
};

_grp setVariable ["order_radius", _radius];

switch _auftrag do {
  case "verlegen" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "SAFE", "GREEN", "Limited", "COLUMN", ""] call CBA_fnc_addWaypoint;
  };
  case "absetzen" : {
    [leader _grp, _zielkoordinate, 0, "GETOUT", "AWARE", "YELLOW", "Normal", "COLUMN", ""] call CBA_fnc_addWaypoint;
  };
  case "pruefen" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "AWARE", "GREEN", "FULL", "STAG COLUMN","this call zumi_fnc_pruefen",[0,5,10],50] call CBA_fnc_addWaypoint;
  };
  case "ausweichen" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "AWARE", "BLUE", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
  };
  case "angreifen" : {
    [leader _grp, _zielkoordinate, 0, "SAD", "AWARE", "YELLOW", "FULL", "LINE", ""] call CBA_fnc_addWaypoint;
  };
  case "verteidigen" : {
    [_grp, _zielkoordinate, 50, 0] call CBA_fnc_taskDefend;
  };
  case "besetzen" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_besetzen"] call CBA_fnc_addWaypoint;
  };
  case "patrouillieren" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "SAFE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_patrouille"] call CBA_fnc_addWaypoint;
  };
  case "auflauern" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "SAFE", "YELLOW", "Full", "STAG COLUMN", "this call zumi_fnc_auflauern"] call CBA_fnc_addWaypoint;
  };
  case "supporten" : {
    [leader _grp, _zielkoordinate, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
  };
  case "luftschlag" : {
    //Offsetwegpunkt 200m vom Ziel entfernt, mit Feuerbefehl,
    _grp setVariable ["target", _target];
    [leader _grp, (_grp call cba_fnc_getPos) getPos [100, [(_grp call cba_fnc_getPos), _zielkoordinate] call BIS_fnc_DirTo], 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
  };
  default {
    [leader _grp, _zielkoordinate, 0, "MOVE", "SAFE", "YELLOW", "Limited", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
  };
};

if (debug) then {
  systemChat str _auftrag;
};


if (_dauer <= 0) exitWith {};

_grp setvariable ["befehl", [_zielkoordinate, _auftrag, _dauer]];
