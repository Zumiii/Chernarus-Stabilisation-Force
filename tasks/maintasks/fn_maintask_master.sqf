
if !isserver exitWith {};


tasks_init = false;
tasks_zeige_hinweise = true;


zumi_maintasks = [];
publicvariable "zumi_maintasks";

zumi_sidetasks = [];
publicvariable "zumi_sidetasks";

//Tasksequenz starten
_skript = [] call zumi_fnc_starte_maintask_sequenz;
/*
waitUntil {scriptdone _skript};
zumi_task_sequenz_durch = true;
publicVariable "zumi_task_sequenz_durch";

*/
