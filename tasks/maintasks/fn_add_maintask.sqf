if !isServer exitWith {};


params [
  ["_name","Platzhalter"],
  ["_kurz","Platzhalter"],
  ["_lang","Platzhalter"],
  ["_seite",[west,civilian]],
  ["_marker",[]],
  ["_status","created"],
  ["_pos",[0,0,0]],
  ["_kurzhinweis",""],
  ["_symbol","move"]
];

private ["_name","_kurz","_lang","_seite","_marker","_status","_pos","_kurzhinweis","_symbol"];

zumi_maintasks set [count zumi_maintasks, [_name,_kurz,_lang,_seite,_marker,_status,_pos,_kurzhinweis,_symbol]];
//publicvariable "zumi_maintasks";

["zumi_maintasks", [zumi_maintasks]] call CBA_fnc_globalEvent;

/*

if ((!isDedicated && hasInterface) && (tasks_init)) then {
	zumi_maintasks spawn zumi_fnc_verwalte_maintaskevent;
};
