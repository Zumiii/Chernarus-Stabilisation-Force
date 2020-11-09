/*

  Kurzbeschrieb:
  Luftabwehr muss vernichtet werden

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
	localize "STR_ZOPS_P1_T2_TITEL",
	format [localize "STR_ZOPS_P1_T2_NOTIZ", _name, ([_timelimit] call CBA_fnc_formatElapsedTime)],
	localize "STR_ZOPS_P1_T2_TITEL",
	"created",
	//[_koords, 350, _tasknr * (360 / 4)] call BIS_fnc_relPos,
  [],
  "radio"
] call zumi_fnc_add_sidetask;

/*
  Prüfschleife und Taskbeendigung
*/

[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_tasknr", "_taskid"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      [format ["Auftrag%1.%2", _taskid, _tasknr], "failed"] call zumi_fnc_task_updaten;
      [_handle] call CBA_fnc_removePerFrameHandler;
      ["zumi_sanktion", floor linearConversion [0, 30, count ([] call cba_fnc_players), 1 , 10, true]] call CBA_fnc_ServerEvent;
      grundtasks set [_tasknr, -1];
    };
    if (skip || fertig) exitWith {
      [format ["Auftrag%1.%2", _taskid, _tasknr], "canceled"] call zumi_fnc_task_updaten;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
		if ({alive _x} count zumi_funknetz < 1) then {
      [format ["Auftrag%1.%2", _taskid, _tasknr], "succeeded"] call zumi_fnc_task_updaten;
    	[_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, 1];
		};
	},
	15,
	[cba_missionTime + _timelimit, _tasknr, Auftrags_Id]
] call CBA_fnc_addPerFrameHandler;



if (true) exitWith {
  _tasknr + 1;
};
