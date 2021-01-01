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


[true, ["offiziere", _task], "offiziere", objNull, "CREATED", -1, true, "kill", true] call bis_fnc_taskCreate;


/*
  Prüfschleife und Taskbeendigung
*/

[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_tasknr"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      ["offiziere","FAILED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      ["zumi_sanktion", floor linearConversion [0, 30, count ([] call cba_fnc_players), 1 , 10, true]] call CBA_fnc_ServerEvent;
      grundtasks set [_tasknr, -1];
    };
    if (skip || fertig) exitWith {
      ["offiziere","CANCELED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
		if ({alive _x} count zumi_kommandeure < 1) then {
        ["offiziere","SUCCEEDED"] call BIS_fnc_taskSetState;
    	[_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, 1];
		};
	},
	15,
	[cba_missionTime + _timelimit, _tasknr]
] call CBA_fnc_addPerFrameHandler;



if (true) exitWith {
  _tasknr + 1;
};
