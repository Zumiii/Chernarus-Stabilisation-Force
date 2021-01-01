/*

  Kurzbeschrieb:
  Dorfältester braucht Ressourcen

*/

if !isServer exitWith {};

params [
  "_id"
];

private _village = villages select _id;
_village params ["_id","_active","_pos","_situation","_indicator","_groups","_objects","_decoratives","_name","_rad","_polygon","_housepositions","_chiefshouse","_task","_timestamp", ["_intel", []]];
_situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];

/*
  Task erstellen und an Spielerschaft zuweisen
*/
_timelimit = 3600;
[true, [format ["humanitarian_%1", _name], "humanitarian"], [format ["Der Dorfälteste von %1 benötigt Hilfsgüter. Geben Sie ihm innerhalb der nächsten Stunde einige Güter, bis er genug hat.", _name], format ["PRT in %1", _name], ""], _chiefshouse, "CREATED", -1, true, "container", true] call bis_fnc_taskCreate;


/*
  Prüfschleife und Taskbeendigung
*/

[
	{
		params ["_args","_handle"];
    _args params ["_zeitansatz", "_id", "_task"];
    if (cba_missionTime >= _zeitansatz) exitWith {
      [_task,"FAILED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
    if (skip || fertig) exitWith {
      [_task,"CANCELED"] call BIS_fnc_taskSetState;
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
		if ((((villages select _id) select 3) select 1) >= 100) then {
      [_task,"SUCCEEDED"] call BIS_fnc_taskSetState;
    	[_handle] call CBA_fnc_removePerFrameHandler;
		};
	},
	5,
	[cba_missionTime + _timelimit, _id, format ["humanitarian_%1", _name]]
] call CBA_fnc_addPerFrameHandler;
