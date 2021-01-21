/*

  Skript prozessiert die Missionsparameter

*/

if !isServer exitWith {};

aimingAccuracy = ["aimingAccuracy", 1] call BIS_fnc_getParamValue;
aimingShake = ["aimingShake", 1] call BIS_fnc_getParamValue;
aimingSpeed = ["aimingSpeed", 1] call BIS_fnc_getParamValue;
spotDistance = ["spotDistance", 1] call BIS_fnc_getParamValue;
spotTime = ["spotTime", 1] call BIS_fnc_getParamValue;
courage = ["courage", 1] call BIS_fnc_getParamValue;
reloadSpeed = ["reloadSpeed", 1] call BIS_fnc_getParamValue;
commanding = ["commanding", 1] call BIS_fnc_getParamValue;



//[true, "humanitarian", "humanitarian", objNull, "CREATED", -1, false, "heal", true] call bis_fnc_taskCreate;
//[true, "tension", "tension", objNull, "CREATED", -1, false, "danger", true] call bis_fnc_taskCreate;
//[true, "warlords", "warlords", objNull, "CREATED", -1, false, "target", true] call bis_fnc_taskCreate;
{
  private _score = _x getVariable ["score", 0];
  private _partei = switch (true) do {

    case (_score >= 5) : {
      "CFOR-Koalition"
    };
    case ((_score < 5) && (_score > -5)) : {
      "Milizen"
    };
    case (_score <= -5) : {
      "Chedaken"
    };
    default {
      "Milizen"
    };

  };
  //villages pushBack [_i, false, _center, [_tension, _humanitarian, _ied], 0, [], [], _decoratives, _name, _rad, _polygon, _housepositions, _chiefshouse, -1, timestamp, []];
  private _tension = (((villages select _forEachIndex) select 3) select 0);
  private _iedlage = switch (true) do {

    case (_tension >= 55) : {
      parseText "<t color='#ff3300'>Hoch</t>"
    };
    case ((_tension < 55) && (_tension > 20)) : {
      parseText "<t color='#ffff00'>Mittel</t>"
    };
    case (_tension <= 20) : {
      parseText "<t color='#00ff00'>Niedrig</t>"
    };
    default {
      parseText "<t color='#ff0000'>Hoch</t>"
    };

  };
  private _humanitarian = (((villages select _forEachIndex) select 3) select 1);
  private _humanitaerelage = switch (true) do {

    case (_humanitarian >= 75) : {
      //parseText "<t color='#00ff00'>Gut</t>"
      parseText "<t color='#00ff00'>Gut</t>"
    };
    case ((_humanitarian < 75) && (_humanitarian > 25)) : {
      parseText "<t color='#ffff00'>Mittelmässig</t>"
    };
    case (_humanitarian <= 25) : {
      parseText "<t color='#ff3300'>Schlecht</t>"
    };
    default {
      parseText "<t color='#ffff00'>Mittelmässig</t>"
    };

  };
  private _auftrag = switch (true) do {

    case (_score >= 5) : {
      "Halten"
    };
    case ((_score < 5) && (_score > -5)) : {
      "Patrouillieren"
    };
    case (_score <= -5) : {
      "Nehmen"
    };
    default {
      "Patrouillieren"
    };

  };
  [true, format ["objekt_%1", (_x getVariable ["name", str _forEachIndex])], [format ["Kontrolliert durch: %1<br/>IED Lage: %2<br/>Humanitäre Lage: %3<br/><br/>Gegenwärtiger Auftrag: %4", _partei, _iedlage, _humanitaerelage, _auftrag], format ["%1", (_x getVariable ["name", str _forEachIndex])], "Testmarker"], (_x getVariable ["center", [0,0,0]]), "CREATED", -1, false, "default", true] call bis_fnc_taskCreate;

  //Todo: Haus des Chefs zeigen
  //Todo: Letzte Patrouille zeigen



} forEach commy_sectors;


server_init_done = true;
publicVariable "server_init_done";


if (true) exitWith {};
