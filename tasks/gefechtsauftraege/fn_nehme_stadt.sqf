/*

  Kurzbeschrieb:
  Ein Stadtkern muss feindrei gekämpft werden

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

[true, [format ["%1_cqb", _task], _task], "cqb", objNull, "CREATED", -1, true, "getin", true] call bis_fnc_taskCreate;




/*
  Prüfschleife und Taskbeendigung
*/

_feindkraft = floor linearConversion [0, 30, count ([] call cba_fnc_players), 1, 5, true];
_rad = floor linearConversion [1, 5, _feindkraft, 100, 400, true];

[
	{
		params ["_args","_handle"];
    _args params ["_pos","_zeitansatz", "_tasknr", "_rad"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      ["zumi_sanktion", floor linearConversion [0, 30, count ([] call cba_fnc_players), 1 , 10, true]] call CBA_fnc_ServerEvent;
      ["cqb","FAILED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
    if (skip || fertig) exitWith {
      ["cqb","CANCELED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, -1];
    };
		if (count ([_pos, _rad, [east]] call zumi_fnc_nahe_ki) < 1) then {
      ["cqb","SUCCEEDED"] call BIS_fnc_taskSetState;
    	[_handle] call CBA_fnc_removePerFrameHandler;
      grundtasks set [_tasknr, 1];
		};
	},
	15,
	[_koords, cba_missionTime + _timelimit, _tasknr, _rad]
] call CBA_fnc_addPerFrameHandler;



if (true) exitWith {
  _tasknr + 1;
};
