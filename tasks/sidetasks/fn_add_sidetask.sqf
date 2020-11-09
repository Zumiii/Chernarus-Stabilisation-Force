/*
	Autor: Zumi

	Beschreibung:
	Erweitert das Sidetaskarray für alle Clients.
	Sendet den serverseitig erstellten Task an alle Clients.

*/


params ["_taskname","_description_kurz","_description_lang","_hud","_taskstate",["_position",[]],["_symbol","move"]];

private ["_taskname","_description_kurz","_description_lang","_hud","_taskstate","_position","_symbol"];
if (isDedicated || isServer) then {
	zumi_sidetasks set [count zumi_sidetasks, [_taskname,_description_kurz,_description_lang,_hud,_taskstate,_position,_symbol]];
	//publicvariable "zumi_sidetasks";
	["zumi_sidetasks", [zumi_sidetasks]] call CBA_fnc_globalEvent;
};

/*
if (!isDedicated && hasInterface) then {
	zumi_sidetasks spawn zumi_fnc_sidetask_handler;
};
