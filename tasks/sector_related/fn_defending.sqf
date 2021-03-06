/*

  Kurzbeschrieb:


*/


if !isServer exitWith {};

tasknummer = tasknummer + 1;
publicVariable "tasknummer";

//Task-ID setzen (tasknummer)
Auftrags_Id = format ["%1", tasknummer + 4];
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


_return = [true] call zumi_fnc_neue_posi;
_return params ["_koords", "_txt"];


if (debug) then {
  systemChat str (commy_sectors select {((_x getVariable ["score", 0]) >= 5)});
};

_dorfkern = ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _koords}) select 0) getVariable ["dorfkern", [0,0,0]];

zumi_taskpos = _koords;
publicVariable "zumi_taskpos";


_spawns = [_koords, format ["Operation%1", Auftrags_Id], ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _koords}) select 0) getVariable ["radius", 500], _dorfkern,  ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _koords}) select 0) getVariable ["polygon", []], _zeitansatz] call zumi_fnc_axis;
_spawns params ["_einheiten", "_fahrzeuge", "_objekte", "_markers"];
[
  {
    params ["_pos", "_desc", "_nr", "_time"];
    [_pos, _desc, _nr, _time] call zumi_fnc_luftabwehr;
  },
  [_koords, _txt, 0, _zeitansatz - 1800],
  3
] call CBA_fnc_waitAndExecute;

[
  {
    params ["_pos", "_desc", "_nr", "_time"];
    [_pos, _desc, _nr, _time] call zumi_fnc_funkwagen;
  },
  [_koords, _txt, 1, _zeitansatz - 1200],
  6
] call CBA_fnc_waitAndExecute;

[
  {
    params ["_pos", "_desc", "_nr", "_time"];
    [_pos, _desc, _nr, _time] call zumi_fnc_offiziere;
  },
  [_koords, _txt, 2, _zeitansatz - 600],
  9
] call CBA_fnc_waitAndExecute;

[
  {
    params ["_pos", "_desc", "_nr", "_time"];
    [_pos, _desc, _nr, _time] call zumi_fnc_nehme_stadt;
  },
  [_dorfkern, _txt, 3, _zeitansatz - 300],
  12
] call CBA_fnc_waitAndExecute;


/*
  Maintaskerstellung
*/

[
  format ["Operation%1", Auftrags_Id],
  localize "STR_ZOPS_INVASION_TITEL",
  format [localize "STR_ZOPS_INVASION_NOTIZ", ([_zeitansatz] call CBA_fnc_formatElapsedTime), [dayTime, "HH:MM"] call BIS_fnc_timeToString],
  [west, civilian, resistance, east],
  [],
  "assigned",
  [],
  localize "STR_ZOPS_INVASION_TITEL",
  "defend"
] call zumi_fnc_add_maintask;


/*
  Prüfschleife
*/

[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_sektor", "_markers"];
    if ((cba_missionTime >= _zeitansatz) || ({_x < 0} count grundtasks >= 4)) exitWith {
      [format ["Operation%1", Auftrags_Id], "failed"] call zumi_fnc_aktualisiere_maintask;
      fertig = true;
      //Cleanup
      {deleteMarker _x;} forEach _markers;
      [zumi_soldaten, false, 1500] call zumi_fnc_taskcleanup;
      [zumi_fahrzeuge, false, 1500] call zumi_fnc_taskcleanup;
      [zumi_misc, false, 1500] call zumi_fnc_taskcleanup;
      [_handle] call CBA_fnc_removePerFrameHandler;
      //Neue Task
      [
        {
          [] call zumi_fnc_defending;
        },
        [],
        20
      ] call CBA_fnc_waitAndExecute;
    };
		if ((({_x == 0} count grundtasks < 1)) || (skip && ({_x < 0} count grundtasks >= 4))) exitWith {
			if (skip) then {
				[format ["Operation%1", Auftrags_Id], "canceled"] call zumi_fnc_aktualisiere_maintask;
			} else {
        [format ["Operation%1", Auftrags_Id], "succeeded"] call zumi_fnc_aktualisiere_maintask;
      };
    	[_handle] call CBA_fnc_removePerFrameHandler;
      fertig = true;
      //Cleanup
      {deleteMarker _x;} forEach _markers;
      _zumi_soldaten = zumi_soldaten;
      _zumi_fahrzeuge = zumi_fahrzeuge;
      _zumi_misc = zumi_misc;
      [_zumi_soldaten, false, 1500] call zumi_fnc_taskcleanup;
      [_zumi_fahrzeuge, false, 1500] call zumi_fnc_taskcleanup;
      [_zumi_misc, false, 1500] call zumi_fnc_taskcleanup;
      //Neue Task
      [
        {
          [] call zumi_fnc_defending;
        },
        [],
        10
      ] call CBA_fnc_waitAndExecute;
		};
	},
	15,
	[cba_missionTime + _zeitansatz, ((commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _koords}) select 0), _markers]
] call CBA_fnc_addPerFrameHandler;



if (true) exitWith {};
