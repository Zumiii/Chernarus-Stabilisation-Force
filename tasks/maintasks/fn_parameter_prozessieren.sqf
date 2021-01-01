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



[true, "humanitarian", "humanitarian", objNull, "CREATED", -1, false, "heal", true] call bis_fnc_taskCreate;
[true, "tension", "tension", objNull, "CREATED", -1, false, "danger", true] call bis_fnc_taskCreate;
[true, "warlords", "warlords", objNull, "CREATED", -1, false, "target", true] call bis_fnc_taskCreate;
{
  //Hauptangriffsziele
  [true, format ["attack_%1", (_x getVariable ["name", str _forEachIndex])], [format ["Erobern: %1", (_x getVariable ["name", str _forEachIndex])], format ["%1", (_x getVariable ["name", str _forEachIndex])], "Testmarker"], (_x getVariable ["center", [0,0,0]]), "CREATED", -1, false, "attack", true] call bis_fnc_taskCreate;
} forEach (commy_sectors select {(_x getVariable ["score", 0]) <= -5});

{

  private _score = _x getVariable ["score", 0];
  switch (true) do {

    case (_score >= 5) : {
      /*
        Blufor
        - Defend Symbol
        Die Ortschaft muss verteidigt werden. Nicht patrouillierte Gebiete können in
        die Hände der Resistance fallen.
        Angrenzende Gebiete haben teilweise Feindinfos oder Infos zu Resistance-Punkten


      */
      [true, format ["defend_%1", (_x getVariable ["name", str _forEachIndex])], [format ["Verteidigen: %1", (_x getVariable ["name", str _forEachIndex])], format ["%1", (_x getVariable ["name", str _forEachIndex])], "Testmarker"], (_x getVariable ["center", [0,0,0]]), "CREATED", -1, false, "defend", true] call bis_fnc_taskCreate;

    };
    case ((_score < 5) && (_score > -5)) : {
      /*
        Independent
        - Zu bestimmendes Symbol
        Die Ortschaft benötigt humanitäre Hilfe, wenn ihr letztes Gefecht nicht lange her ist (<12 Server-Restarts)
        Aufbau-Tasks gibt es bei zerstörten Gebäuden in der Zone
        Sonstige Hilfsgüter braucht es bei schlechter humanitärer Lage

      */
      [true, format ["prt_%1", (_x getVariable ["name", str _forEachIndex])], [format ["Patrouille: %1", (_x getVariable ["name", str _forEachIndex])], format ["%1", (_x getVariable ["name", str _forEachIndex])], "Testmarker"], (_x getVariable ["center", [0,0,0]]), "CREATED", -1, false, "danger", true] call bis_fnc_taskCreate;

    };
    case (_score <= -5) : {
      /*
        Attack Symbol
        Opfor
        Die Ortschaft wird vom Feind kontrolliert und muss freigekämpft werden
        Verschiedene Szenarien möglich:
          1) Feind hat Stellung gehärtet und hat ein MHQ dort
          2) Feind nutzt das Gebiet als Nachschubposten
          3) Feind hat das Gebiet lediglich besetzt aber nicht gehärtet
      */
      [true, format ["attack_%1", (_x getVariable ["name", str _forEachIndex])], [format ["Erobern: %1", (_x getVariable ["name", str _forEachIndex])], format ["%1", (_x getVariable ["name", str _forEachIndex])], "Testmarker"], (_x getVariable ["center", [0,0,0]]), "CREATED", -1, false, "attack", true] call bis_fnc_taskCreate;
    };
    default {

    };

  };

} forEach commy_sectors;

server_init_done = true;
publicVariable "server_init_done";


if (true) exitWith {};
