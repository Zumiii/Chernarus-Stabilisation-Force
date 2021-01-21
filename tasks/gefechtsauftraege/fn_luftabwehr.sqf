/*

  Kurzbeschrieb:
  Luftabwehr muss vernichtet werden

*/

if !isServer exitWith {};

params [
  "_task",
  "_koords",
  "_timelimit",
	"_tasknr"
];

/*
  Task erstellen und an Spielerschaft zuweisen
*/

[true, [format ["%1_luftabwehr", _task], _task], "luftabwehr", objNull, "CREATED", -1, true, "plane", true] call bis_fnc_taskCreate;
/*
  Prüfschleife und Taskbeendigung
*/
//["luftabwehr","SUCCEEDED"] call BIS_fnc_taskSetState;
//["luftabwehr","FAILED"] call BIS_fnc_taskSetState;
[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_tasknr", "_taskid"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      ["luftabwehr","FAILED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      ["zumi_sanktion", floor linearConversion [0, 30, count ([] call cba_fnc_players), 1 , 10, true]] call CBA_fnc_ServerEvent;
      grundtasks set [_tasknr, -1];
    };
    if (skip || fertig) exitWith {
      ["luftabwehr","CANCELED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
		if ({alive _x} count zumi_flak < 1) then {
      ["luftabwehr","SUCCEEDED"] call BIS_fnc_taskSetState;
    	[_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, 1];
		};
	},
	15,
	[cba_missionTime + _timelimit, _tasknr]
] call CBA_fnc_addPerFrameHandler;
