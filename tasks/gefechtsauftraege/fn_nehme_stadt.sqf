/*

  Kurzbeschrieb:
  Ein Stadtkern muss feindrei gekämpft werden

*/

if !isServer exitWith {};

params [
  "_koords",
  "_name",
	"_tasknr",
  "_timelimit",
  ["_optional", ""]
];

/*
  Task erstellen und an Spielerschaft zuweisen
*/

[
	format ["Auftrag%1.%2", Auftrags_Id, _tasknr],
	localize "STR_ZOPS_P1_T4_TITEL",
	format [localize "STR_ZOPS_P1_T4_NOTIZ", _name, ([_timelimit] call CBA_fnc_formatElapsedTime)],
	format [localize "STR_ZOPS_P1_T4_TITEL", _name],
	"created",
	//_koords,
  [],
  "attack"
] call zumi_fnc_add_sidetask;


/*
  Prüfschleife und Taskbeendigung
*/

_feindkraft = floor linearConversion [0, 30, count ([] call cba_fnc_players), 1, 5, true];
_rad = floor linearConversion [1, 5, _feindkraft, 100, 400, true];

[
	{
		params ["_args","_handle"];
    _args params ["_pos","_zeitansatz", "_tasknr", "_rad", "_taskid"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      ["zumi_sanktion", floor linearConversion [0, 30, count ([] call cba_fnc_players), 1 , 10, true]] call CBA_fnc_ServerEvent;
      [format ["Auftrag%1.%2", _taskid, _tasknr], "failed"] call zumi_fnc_task_updaten;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
    if (skip || fertig) exitWith {
      [format ["Auftrag%1.%2", _taskid, _tasknr], "canceled"] call zumi_fnc_task_updaten;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
		if (count ([_pos, _rad, [east]] call zumi_fnc_nahe_ki) < 1) then {
      [format ["Auftrag%1.%2", _taskid, _tasknr], "succeeded"] call zumi_fnc_task_updaten;
    	[_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, 1];
		};
	},
	15,
	[_koords, cba_missionTime + _timelimit, _tasknr, _rad, Auftrags_Id]
] call CBA_fnc_addPerFrameHandler;



if (true) exitWith {
  _tasknr + 1;
};
