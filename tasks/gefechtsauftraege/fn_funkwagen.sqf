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

[true, [format ["%1_kommunikationssysteme", _task], _task], "kommunikationssysteme", objNull, "CREATED", -1, true, "radio", true] call bis_fnc_taskCreate;
/*
  Prüfschleife und Taskbeendigung
*/

[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_tasknr", "_taskid"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      ["kommunikationssysteme","FAILED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      ["zumi_sanktion", floor linearConversion [0, 30, count ([] call cba_fnc_players), 1 , 10, true]] call CBA_fnc_ServerEvent;
      grundtasks set [_tasknr, -1];
    };
    if (skip || fertig) exitWith {
      ["kommunikationssysteme","CANCELED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
		if ({alive _x} count zumi_funknetz < 1) then {
      ["kommunikationssysteme","SUCCEEDED"] call BIS_fnc_taskSetState;
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
