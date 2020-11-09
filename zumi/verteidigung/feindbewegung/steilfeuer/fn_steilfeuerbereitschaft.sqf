/*

  Funktion prüft, ob Steilfeuer überhaupt verfügbar ist.

*/

if !isServer exitWith {};

params [["_art",""]];

private _return = switch (_art) do {
    case "steilfeuer";
    case "haubitzen" : {
      (count (zumi_haubitzen select {(alive _x) && {alive (gunner _x)} && {((_x getVariable ["zuletzt_gefeuert",0]) < CBA_missiontime)}})) > 0
    };
    case "moerser" : {
      (count (zumi_moerser select {(alive _x) && {alive (gunner _x)} && {((_x getVariable ["zuletzt_gefeuert",0]) < CBA_missiontime)}})) > 0
    };
    case "raketen" : {
      (count (zumi_raketen select {(alive _x) && {alive (gunner _x)} && {((_x getVariable ["zuletzt_gefeuert",0]) < CBA_missiontime)}})) > 0
    };
    default {
      false
    };
};

_return
