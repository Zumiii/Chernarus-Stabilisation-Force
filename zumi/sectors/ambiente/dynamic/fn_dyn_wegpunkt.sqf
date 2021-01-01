params [
  "_grp",
  "_ziel",
  "_art",
  "_befehl"
];

_befehl params [["_wp_pos", [0,0,0]], ["_wp_details", []]];
_wp_details params [["_do_until", cba_missionTime], ["_script", ""]];

[_grp] call CBA_fnc_clearWaypoints;

_behaviour = switch _art do {
  case "miliz" : {
    "safe"
  };
  case "tak" : {
    "safe"
  };
  case "pol" : {
    "safe"
  };
  case "mil" : {
    "safe"
  };
  default {
    "careless"
  };
};

_waypointstatement = switch _script do {
  case "PATROL" : {
    "[this] call CBA_fnc_taskPatrol"
  };
  case "GARRISON" : {
    //Temporary solution, Garrison or defend needs specific script solutions
    "[this] call CBA_fnc_taskPatrol"
  };
  default {
    ""
  };
};

_waypointtype = switch _script do {
  case "DEFEND" : {
    "DEFEND"
  };
  case "SAD" : {
    "SAD"
  };
  default {
    "MOVE"
  };
};

switch _art do {
  case "miliz" : {
    [leader _grp, _ziel, 0, _waypointtype, _behaviour, "YELLOW", "Limited", "STAG COLUMN", _waypointstatement] call CBA_fnc_addWaypoint;
  };
  case "tak" : {
    [leader _grp, _ziel, 0, _waypointtype, _behaviour, "YELLOW", "Limited", "STAG COLUMN", _waypointstatement] call CBA_fnc_addWaypoint;
  };
  case "pol" : {
    [leader _grp, _ziel, 0, _waypointtype, _behaviour, "GREEN", "Limited", "STAG COLUMN", _waypointstatement] call CBA_fnc_addWaypoint;
  };
  case "mil" : {
    [leader _grp, _ziel, 0, _waypointtype, _behaviour, "GREEN", "Limited", "STAG COLUMN", _waypointstatement] call CBA_fnc_addWaypoint;
  };
  default {
    [leader _grp, _ziel, 0, _waypointtype, _behaviour, "YELLOW", "Limited", "COLUMN", _waypointstatement] call CBA_fnc_addWaypoint;
  };
};

if (debug) then {
  systemChat format ["Entsende %1 nach %2 mit Auftrag %3 mit %4 Haltung und %5 Skript", _grp, _ziel, _waypointtype, _behaviour, _waypointstatement];
};
