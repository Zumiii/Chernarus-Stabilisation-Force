/*

  Kurzbeschrieb:
  Eine Stadt angreifen

*/


if !isServer exitWith {};

params ["_task", "_taskParent", "_taskpos", "_description"];

//Task-ID setzen (tasknummer)
Auftrags_Id = format ["%1", tasknummer];
//Der Auftrag ist weder fertig noch geskippt
fertig = false;
skip = false;

/*
  Variablen redefinieren
*/




anticliparray = [];
zumi_soldaten = [];
zumi_fahrzeuge = [];
zumi_misc = [];
zumi_kommandeure = [];
zumi_funknetz = [];
zumi_flak = [];
zumi_moerser = [];
zumi_haubitzen = [];
zumi_raketen = [];
zumi_steilfeuerbefehle = [];
zumi_befehle = [];
zumi_stellungen = [];
zumi_fliegeralarme = [];
zumi_truppenteile = [
  [],//Späher
  [],//Inftrupp zu Fuss
  [],//Motorisierter Inftrupp
  [],//Mechanisierter Inftrupp
  [],//Inftrupp in Stellung
  [],//Panzer
  [],//Luftabwehr (mobil)
  [],//Bomber (kampf)
  [],//starrflügler (kampf)
  []//Funker
];
zumi_feindziele = [];
grundtasks = [0,0,0,0];

_zeitansatz = ((["Zeitansatz", 3] call BIS_fnc_getParamValue) * 3600) - 300; //5 Minuten braucht es als Kopfkürzerfaktor ...

//Haben wir alle Sektoren?
if (({(_x getVariable ["score", 0]) < 5} count commy_sectors) < 1) exitWith {
  [true] call zumi_fnc_reset;
};


//Zeitmaximum überschritten
if (restart_nummer > restart_max) exitWith {
  [false] call zumi_fnc_reset;
};


/*
  Finde Pos
*/
/*
_return = [true] call zumi_fnc_neue_posi;
_return params ["_taskpos", "_txt"];
*/

//Aktiviere Sektor
((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _taskpos}) select 0) setVariable ["active", true];

if (debug) then {
  systemChat str (commy_sectors select {((_x getVariable ["score", 0]) >= 5)});
};

_dorfkern = ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _taskpos}) select 0) getVariable ["dorfkern", [0,0,0]];

zumi_taskpos = _taskpos;
publicVariable "zumi_taskpos";


_spawns = [_taskpos, _task, ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _taskpos}) select 0) getVariable ["radius", 500], _dorfkern,  ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _taskpos}) select 0) getVariable ["polygon", []], _zeitansatz] call zumi_fnc_axis;
_spawns params ["_einheiten", "_fahrzeuge", "_objekte", "_markers"];


/*
  Maintaskerstellung
*/





//Funkanlage

[_task, _taskpos, _zeitansatz, 0] call zumi_fnc_funkwagen;
//Kommandeure

[_task, _taskpos, _zeitansatz, 1] call zumi_fnc_offiziere;
//CQB

[_task, _taskpos, _zeitansatz, 2] call zumi_fnc_nehme_stadt;
//Luftabwehr

[_task, _taskpos, _zeitansatz, 3] call zumi_fnc_luftabwehr;


/*
  Prüfschleife
*/

[
	{
		params ["_args","_handle"];
    _args params ["_task", "_zeitansatz", "_sektor", "_markers"];
    if ((cba_missionTime >= _zeitansatz) || ({_x < 0} count grundtasks >= 4)) exitWith {
      [_task,"FAILED"] call BIS_fnc_taskSetState;
      _sektor setVariable ["score", -15, true];
      fertig = true;
      _sektor setVariable ["active", false];
      //Cleanup
      {deleteMarker _x;} forEach _markers;
      [zumi_soldaten, false, 1500] call zumi_fnc_taskcleanup;
      [zumi_fahrzeuge, false, 1500] call zumi_fnc_taskcleanup;
      [zumi_misc, false, 1500] call zumi_fnc_taskcleanup;
      [_handle] call CBA_fnc_removePerFrameHandler;
      task_running = false;
      publicVariable "task_running";
    };
		if ((({_x == 0} count grundtasks < 1)) || (skip && ({_x < 0} count grundtasks >= 4))) exitWith {
			if (skip) then {
        [_task,"CANCELED"] call BIS_fnc_taskSetState;
			} else {
        [_task,"SUCCEEDED"] call BIS_fnc_taskSetState;
        _sektor setVariable ["score", 0, true];
      };
    	[_handle] call CBA_fnc_removePerFrameHandler;
      _sektor setVariable ["active", false];
      fertig = true;
      //Cleanup
      {deleteMarker _x;} forEach _markers;
      _zumi_soldaten = zumi_soldaten;
      _zumi_fahrzeuge = zumi_fahrzeuge;
      _zumi_misc = zumi_misc;
      [_zumi_soldaten, false, 1500] call zumi_fnc_taskcleanup;
      [_zumi_fahrzeuge, false, 1500] call zumi_fnc_taskcleanup;
      [_zumi_misc, false, 1500] call zumi_fnc_taskcleanup;
      task_running = false;
      publicVariable "task_running";
		};
	},
	15,
	[_task, cba_missionTime + _zeitansatz, ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _taskpos}) select 0), _markers]
] call CBA_fnc_addPerFrameHandler;



if (true) exitWith {};
