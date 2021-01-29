/*

  Kurzbeschrieb:
  Eine Stadt angreifen

*/


if !isServer exitWith {};

//Task-ID setzen (tasknummer)
params ["_task", "_taskParent", "_taskpos", "_description", "_sector"];
/*
  Variablen redefinieren
*/
_id = commy_sectors find _sector;
/*
  Maintaskerstellung
*/


[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_id", "_sector", "_task"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      [_task,"FAILED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
			task_running = false;
      publicVariable "task_running";
    };
		if ((((villages select _id) select 4) >= 12) || skip) exitWith {
			if (skip) then {
				[_task,"CANCELED"] call BIS_fnc_taskSetState;
			} else {
        [_task,"SUCCEEDED"] call BIS_fnc_taskSetState;
        private _score = _sector getVariable ["score", 0];
        _sector setVariable ["score", _score + 5, true];
      };
    	[_handle] call CBA_fnc_removePerFrameHandler;
			task_running = false;
      publicVariable "task_running";
		};
	},
	5,
	[cba_missionTime + _zeitansatz, _id, _sector, _task]
] call CBA_fnc_addPerFrameHandler;


if (true) exitWith {};
