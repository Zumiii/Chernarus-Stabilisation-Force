//if !isserver exitWith {};

if (!isNil "zumi_task_sequenz_durch") then {
  zumi_task_sequenz_durch = nil
};

/*
if !(isServer) exitWith {
  waitUntil {!isNil "zumi_task_sequenz_durch"}
};
*/


[] call zumi_fnc_parameter_prozessieren;

/*
private _skript = [] execVM "tasks\taskmaster.sqf";
waitUntil {scriptdone _skript};
zumi_task_sequenz_durch = true;
publicVariable "zumi_task_sequenz_durch";
