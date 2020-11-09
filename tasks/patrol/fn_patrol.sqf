/*

  Kurzbeschrieb:
  Eine Stadt angreifen

*/


if !isServer exitWith {};

//Task-ID setzen (tasknummer)
Auftrags_Id = format ["%1", tasknummer];
//Der Auftrag ist weder fertig noch geskippt
fertig = false;
skip = false;

/*
  Variablen redefinieren
*/

//Select Patrol destination
_return = [true] call zumi_fnc_neue_posi;
_return params ["_koords", "_txt"];
_patrol_destination = (villages select {(_x select 2) isEqualTo _koords}) select 0;
_patrol_destination params ["_id","_active","_pos","_situation","_indicator","_groups","_objects","_decoratives","_name","_rad","_polygon","_housepositions","_chiefshouse","_task","_timestamp", ["_task", 0]];
(villages select _id) set [15, 1];

_zeitansatz = ((["Zeitansatz", 3] call BIS_fnc_getParamValue) * 3600) - 300; //5 Minuten braucht es als Kopfkürzerfaktor ...

zumi_taskpos = _koords;
publicVariable "zumi_taskpos";

/*
  Maintaskerstellung
*/

[
  format ["Operation%1", Auftrags_Id],
  localize "STR_ZOPS_PATROL_TITEL",
  format [localize "STR_ZOPS_PATROL_NOTIZ", ([_zeitansatz] call CBA_fnc_formatElapsedTime), [dayTime, "HH:MM"] call BIS_fnc_timeToString],
  [west, civilian, resistance, east],
  [],
  "assigned",
  [],
  localize "STR_ZOPS_PATROL_TITEL",
  "walk"
] call zumi_fnc_add_maintask;

/*
[
  {
    params ["_pos", "_nr"];
    [_nr, _pos] call zumi_fnc_lieferungstask_init;
  },
  [_koords, 1],
  120
] call CBA_fnc_waitAndExecute;
*/

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

      //Neue Task
      [
        {
          [] call zumi_fnc_patrol;
        },
        [],
        5
      ] call CBA_fnc_waitAndExecute;
    };
		if ((((villages select _id) select 15) < 0) || skip) exitWith {
			if (skip) then {
				[format ["Operation%1", Auftrags_Id], "canceled"] call zumi_fnc_aktualisiere_maintask;
			} else {
        [format ["Operation%1", Auftrags_Id], "succeeded"] call zumi_fnc_aktualisiere_maintask;
      };
    	[_handle] call CBA_fnc_removePerFrameHandler;
      fertig = true;

      //Neue Task
      [
        {

          [] call zumi_fnc_patrol;
        },
        [],
        5
      ] call CBA_fnc_waitAndExecute;
		};
	},
	5,
	[cba_missionTime + _zeitansatz, _id]
] call CBA_fnc_addPerFrameHandler;


//Erste Task muss an Clients broadcasten für Spawnfreigabe
if (tasknummer <= 1) then {
  [
    {
      server_init_done = true;
      publicVariable "server_init_done";
    },
    [],
    3
  ] call CBA_fnc_waitAndExecute;
};

[] call zumi_fnc_tension;

if (true) exitWith {};
