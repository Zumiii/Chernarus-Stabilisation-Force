/*

  Kurzbeschrieb:


*/


if !isServer exitWith {};

tasknummer = tasknummer + 1;
publicVariable "tasknummer";

//Task-ID setzen (tasknummer)
Auftrags_Id = format ["%1", tasknummer + 3];
//Der Auftrag ist weder fertig noch geskippt
fertig = false;
skip = false;

/*
  Variablen redefinieren
*/

//Select Patrol destination

_zeitansatz = ((["Zeitansatz", 3] call BIS_fnc_getParamValue) * 3600) - 300; //5 Minuten braucht es als Kopfkürzerfaktor ...

/*
  Maintaskerstellung
*/

[
  format ["Operation%1", Auftrags_Id],
  localize "STR_ZOPS_WARLORD_TITEL",
  format [localize "STR_ZOPS_WARLORD_NOTIZ", ([_zeitansatz] call CBA_fnc_formatElapsedTime), [dayTime, "HH:MM"] call BIS_fnc_timeToString],
  [west, civilian, resistance, east],
  [],
  "assigned",
  [],
  localize "STR_ZOPS_WARLORD_TITEL",
  "kill"
] call zumi_fnc_add_maintask;


/*
  Prüfschleife
*/

[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_id"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      [format ["Operation%1", Auftrags_Id], "failed"] call zumi_fnc_aktualisiere_maintask;
      fertig = true;
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
		if (({((_x select 3) select 1) < 80} count villages < 1) || skip) exitWith {
			if (skip) then {
				[format ["Operation%1", Auftrags_Id], "canceled"] call zumi_fnc_aktualisiere_maintask;
			} else {
        [format ["Operation%1", Auftrags_Id], "succeeded"] call zumi_fnc_aktualisiere_maintask;
      };
    	[_handle] call CBA_fnc_removePerFrameHandler;
      fertig = true;
		};
	},
	5,
	[cba_missionTime + _zeitansatz, _id]
] call CBA_fnc_addPerFrameHandler;

[] call zumi_fnc_defending;

if (true) exitWith {};
