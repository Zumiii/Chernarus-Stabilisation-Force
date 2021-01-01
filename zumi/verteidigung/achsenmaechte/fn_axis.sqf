if !isServer exitwith {};

params [
  "_position",
  "_taskname",
  "_rad",
  "_dorfkern",
  "_polygon",
  "_zeitansatz"
];

/*

  Defines

*/

zumi_truppenteile params [
  ["_spaeher", []],
  ["_inf_fuss", []],
  ["_inf_mot", []],
  ["_inf_mech", []],
  ["_inf_gehaertet", []],
  ["_panzer", []],
  ["_luftabwehr", []],
  ["_bomber", []],
  ["_starrfluegler", []],
  ["_funker", []]
];

_units = [];
_fzg = [];
_obj = [];
_markers = [];

/*

  Berechne Feindkraft entsprechend dem Spieleraufgebot

*/

_gewichtet = ["feindkraft", -1] call BIS_fnc_getParamValue;

_feindkraft = if (_gewichtet < 0) then {
  floor linearConversion [0, 20, average_players_when_not_empty, 1, 5, true];
} else {
  _gewichtet;
};

radius = floor linearConversion [1, 5, _feindkraft, 200, 500, true];



//Setze Marker
//Erstelle Marker
_marker = createMarker [format ["%1_%2", _taskname, _dorfkern], _dorfkern];
_marker setMarkerShape "ELLIPSE";
_marker setMarkerSize [radius/2, radius/2];
_marker setMarkerbrush "FDiagonal";
_marker setMarkerColor "ColorBrown";
_marker setMarkerAlpha 0;
_markers pushBack _marker;

//Welche leichten Fahrzeuge hat der Feind zur Verfügung?
_kfz_typen_leicht = switch _feindkraft do {
	case 1 : {
		[17]
	};
	case 2 : {
		[17]
	};
	case 3 : {
		[17,22]
	};
	case 4 : {
		[17,22]
	};
	case 5 : {
		[17,22]
	};
};

//Welche mittleren Fahrzeuge hat der Feind zur Verfügung?
_kfz_typen_mittel = switch _feindkraft do {
	case 1 : {
		[18]
	};
	case 2 : {
		[18]
	};
	case 3 : {
		[18]
	};
	case 4 : {
		[18]
	};
	case 5 : {
		[18]
	};
};

//Welche schweren Fahrzeuge hat der Feind zur Verfügung?
_kfz_typen_schwer = switch _feindkraft do {
	case 1 : {
		[]
	};
	case 2 : {
		[]
	};
	case 3 : {
		[]
	};
	case 4 : {
		[20]
	};
	case 5 : {
		[20]
	};
};

//Wieviele Fahrzeuge der jeweiligen Typen hat der Feind minimal bzw maximal bei entsprechener Stärke?
_fuhrpark = switch _feindkraft do {
	case 1 : {
		[
			[1,3],
			[1,1],
			[0,0]
		]
	};
	case 2 : {
		[
			[1,3],
			[1,1],
			[0,0]
		]
	};
	case 3 : {
		[
			[1,3],
			[1,2],
			[0,0]
		]
	};
	case 4 : {
		[
			[1,2],
			[1,2],
			[1,2]
		]
	};
	case 5 : {
		[
			[1,1],
			[2,3],
			[1,3]
		]
	};
};

_fuhrpark params ["_leicht","_mittel","_schwer"];

//Wieviele Patrouillen min/max?
_anzahl_pats = switch _feindkraft do {
	case 1 : {
		[2,3]
	};
	case 2 : {
		[3,4]
	};
	case 3 : {
		[4,5]
	};
	case 4 : {
		[4,5]
	};
	case 5 : {
		[5,6]
	};
};

//Wieviele Patrouillen min/max?
_anzahl_spaeher = switch _feindkraft do {
	case 1 : {
		[2,3]
	};
	case 2 : {
		[2,4]
	};
	case 3 : {
		[3,4]
	};
	case 4 : {
		[3,5]
	};
	case 5 : {
		[4,6]
	};
};

//Wieviele bzw. überhaupt in Häusern?
_anzahl_in_haus = switch _feindkraft do {
	case 1 : {
		[1,2]
	};
	case 2 : {
		[2,3]
	};
	case 3 : {
		[3,4]
	};
	case 4 : {
		[4,5]
	};
	case 5 : {
		[4,6]
	};
};


/*

  Lege den _rad für die Späher fest

*/

private _spaeher_rad = ceil linearConversion [1, 5, (_anzahl_pats select 1), _rad*0.5, _rad, true];

/*

  Lege den _rad für die Einheiten in den Häusern fest (Abhängig von der Menge)

*/

private _hw_rad = radius;

/*

  Lege den Patrouillen_rad fest entsprechend der Anzahl usw.

*/

private _pat_rad = ceil linearConversion [1, 5, (_anzahl_pats select 1), _rad/2, _rad, true];

/*

  Anzahl der Kommandeure

*/

private _anzahl_kommandobunker = floor linearConversion [1, 5, _feindkraft, 1 , 3, true];

private _anzahl_kommandeure_in_haus = floor linearConversion [1, 5, _feindkraft, 2 , 3, true];

//Spawne Peripherie etc...
[_position, _polygon, zumi_stellungen] call zumi_fnc_setup_defence;

/*

  "Führerbunker"

*/

_result = [[kdo_bunker_1, kdo_bunker_2, kdo_bunker_2], _anzahl_kommandobunker] call CBA_fnc_selectRandomArray;
{
  private _pos = [_dorfkern, 250, 1, 1, (floor linearConversion [1, 4, _anzahl_kommandobunker, 1 , 3, true]) * 50, 15, 0.15, true, false, false, false, true, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    _dir = [_pos, 150, _dorfkern] call zumi_fnc_sichtcheck;
    //zumi_stellungen pushBack [_pos, "o_hq", "command bunker", 0.7, ([_pos, 15] call CBA_fnc_randPos), false];
    _return = [_pos, _dir, _x, surfaceNormal _pos] call zumi_fnc_spawn_it;
    _return params ["_u","_v","_o"];
    zumi_soldaten append _u;
    zumi_fahrzeuge append _v;
    zumi_misc append _o;
    _inf_gehaertet append _u;
  };
} forEach _result;

/*

  Kommandeure in Häusern

*/

for "_i" from 1 to _anzahl_kommandeure_in_haus do {
  private _grp = createGroup east;
  private _offi = _grp createUnit ["LOP_ChDKZ_Infantry_Commander", _dorfkern, [], 0, "NONE"];
  _offi setSkill ["aimingAccuracy", aimingAccuracy];
	_offi setSkill ["aimingShake", aimingShake];
	_offi setSkill ["aimingSpeed", aimingSpeed];
	_offi setSkill ["spotDistance", spotDistance];
	_offi setSkill ["spotTime", spotTime];
	_offi setSkill ["courage", courage];
	_offi setSkill ["reloadSpeed", reloadSpeed];
	_offi setSkill ["commanding", commanding];
  zumi_soldaten pushBack _grp;
  [_offi] call zumi_fnc_kommandant_registrieren;
  private _buildings = (nearestObjects [_dorfkern, ["Building"], radius/2]) select {count (_x buildingPos -1) > 0};
  if (count _buildings > 1) then {
    private _remainings = [_dorfkern, nil, (units _grp), radius/2, 2, false, true] call ace_ai_fnc_garrison;
    if (count _remainings > 0) then {
      {
        [_x, _dorfkern, radius, 1, 0.5, 0] call CBA_fnc_taskDefend;
      } forEach _remainings;
    };
  } else {
    [_grp, _dorfkern, radius, 1, 0.5, 0] call CBA_fnc_taskDefend;
  };
};

private _grp = createGroup east;
private _warlord = _grp createUnit ["LOP_ChDKZ_Infantry_Bardak", _dorfkern, [], 0, "NONE"];
_warlord setSkill ["aimingAccuracy", aimingAccuracy];
_warlord setSkill ["aimingShake", aimingShake];
_warlord setSkill ["aimingSpeed", aimingSpeed];
_warlord setSkill ["spotDistance", spotDistance];
_warlord setSkill ["spotTime", spotTime];
_warlord setSkill ["courage", courage];
_warlord setSkill ["reloadSpeed", reloadSpeed];
_warlord setSkill ["commanding", commanding];
zumi_soldaten pushBack _grp;
[_warlord] call zumi_fnc_kommandant_registrieren;
private _buildings = (nearestObjects [_dorfkern, ["Building"], radius/2]) select {count (_x buildingPos -1) > 0};
if (count _buildings > 1) then {
  private _remainings = [_dorfkern, nil, (units _grp), radius/2, 2, false, true] call ace_ai_fnc_garrison;
  if (count _remainings > 0) then {
    {
      [_x, _dorfkern, radius, 1, 0.5, 0] call CBA_fnc_taskDefend;
    } forEach _remainings;
  };
} else {
  [_grp, _dorfkern, radius, 1, 0.5, 0] call CBA_fnc_taskDefend;
};


/*

Spawn Mortar or Artillery
- Considered "important" by the commanders

*/

for "_i" from 1 to 2 do {
  private _periphery = [true, [0, 3500, _dorfkern]] call zumi_fnc_neue_posi;
  private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _dir = [_pos, _dorfkern] call BIS_fnc_DirTo;
    _return = [_pos, _dir, selectRandom [steilfeuer_1, steilfeuer_2], surfaceNormal _pos] call zumi_fnc_spawn_it;
    _return params ["_u","_v","_o"];
    zumi_soldaten append _u;
    zumi_fahrzeuge append _v;
    zumi_misc append _o;
    private _artillery = _v select 0;
    //zumi_stellungen pushBack [_artillery, [_pos, _dir], "o_mortar", "artillery site", 0.65, ([_pos, 15] call CBA_fnc_randPos), false];
  };
};


private _anzahl_pak = floor linearConversion [1, 5, _feindkraft, 1 , 4, true];

private _pak_radius = floor linearConversion [2, 4, _anzahl_pak, radius, _rad, true];
/*

  Flakstellungen

*/

private _anzahl_aa = floor linearConversion [1, 5, _feindkraft, 1 , 2, true];
_result = [[aa_1, aa_2, aa_3], _anzahl_aa] call CBA_fnc_selectRandomArray;
{
  private _pos = [_position, _pak_radius, 1, 1, _pak_radius / 4, 15, 0.15, true, false, false, false, true, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    _dir = [_pos, 100, _dorfkern] call zumi_fnc_sichtcheck;
    //zumi_stellungen pushBack [_pos, "o_antiair", "Flakstellung", 0.4, ([_pos, 15] call CBA_fnc_randPos), false];
    _return = [_pos, _dir, _x, surfaceNormal _pos] call zumi_fnc_spawn_it;
    _return params ["_u","_v","_o"];
    zumi_soldaten append _u;
    zumi_fahrzeuge append _v;
    zumi_misc append _o;
    _luftabwehr append _u;
    zumi_flak append _v;
  };
} forEach _result;


/*

  PAK und Fahrzeuge in Stellung

*/

_result = [[at_1, at_2, at_3, at_4], _anzahl_pak] call CBA_fnc_selectRandomArray;
{
  private _pos = [_position, _pak_radius, 1, 1, (_pak_radius / 2), 15, 0.15, true, false, false, false, true, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    _dir = [_pos, 200, _dorfkern] call zumi_fnc_sichtcheck;
    //zumi_stellungen pushBack [_pos, "o_installation", "PAK-Stellung", 0.2, ([_pos, 15] call CBA_fnc_randPos), cba_missiontime, false];
    _return = [_pos, _dir, _x, surfaceNormal _pos] call zumi_fnc_spawn_it;
    _return params ["_u","_v","_o"];
    zumi_soldaten append _u;
    zumi_fahrzeuge append _v;
    zumi_misc append _o;
    _inf_gehaertet append _u;
  };
} forEach _result;



/*

  Besetzter Bereich in Dorf / Stadt
  Wird angezeigt durch Blockaden um einen kleineren Bereich

*/

//Spawne Infanterie in Häusern
for "_i" from 1 to ((ceil random (_anzahl_in_haus select 1)) max (_anzahl_in_haus select 0)) do {
  private _grp = [_dorfkern, east, format ["AXIS_Gruppe_%1", ceil round random 5]] call zumi_fnc_spawn_grp;
  _inf_gehaertet pushBack _grp;
  zumi_soldaten pushBack _grp;
  {
    _units pushBack _x;
  } forEach (units _grp);
  private _buildings = (nearestObjects [_dorfkern, ["Building"], radius/2]) select {count (_x buildingPos -1) > 0};
  if (count _buildings > 1) then {
    private _remainings = [_dorfkern, nil, (units _grp), radius/2, 2, false, true] call ace_ai_fnc_garrison;
    if (count _remainings > 0) then {
      {
        [_x, _dorfkern, radius, 1, 0.5, 0] call CBA_fnc_taskDefend;
      } forEach _remainings;
    };
  } else {
    [_grp, _dorfkern, radius, 1, 0.5, 0] call CBA_fnc_taskDefend;
  };
};


/*

  MG-Stellungen und Gräben (Nahe Kdo bzw. Besetzter Stadtzone)

*/

private _anzahl_stellungen = floor linearConversion [1, 5, _feindkraft, 2 , 5, true];
_stellungs_radius = floor linearConversion [2, 4, _anzahl_stellungen, radius, _rad, true];
_result = [[stellung_1, stellung_2, stellung_3, stellung_4, stellung_5], _anzahl_stellungen] call CBA_fnc_selectRandomArray;
{
  private _pos = [_dorfkern, _stellungs_radius, 1, 1, (_stellungs_radius / 2), 15, 0.15, true, false, false, false, true, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    _dir = [_pos, 100, _dorfkern] call zumi_fnc_sichtcheck;
    //zumi_stellungen pushBack [_pos, "o_installation", "Schützenstellung", 0.2, ([_pos, 15] call CBA_fnc_randPos), cba_missiontime, false];
    _return = [_pos, _dir, _x, surfaceNormal _pos] call zumi_fnc_spawn_it;
    _return params ["_u","_v","_o"];
    zumi_soldaten append _u;
    zumi_fahrzeuge append _v;
    zumi_misc append _o;
  };
} forEach _result;

/*

  Roadblocks

*/

_result = [[rb_1, rb_2, rb_3, rb_1], _anzahl_stellungen] call CBA_fnc_selectRandomArray;
{
  private _pos = [_dorfkern, 300, 1, 1, (floor linearConversion [1, 4, _anzahl_stellungen, 1 , 3, true]) * 30, 8, 0.15, true, true, false, false, true, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    //_dir = [_pos, 250] call zumi_fnc_sichtcheck;
    _nearroad = _pos nearRoads 15;
  	_dir = if (count _nearroad > 0) then {
		  _road = _nearroad select 0;
		  _roadConnectedTo = roadsConnectedTo _road;
		  _connectedRoad = _roadConnectedTo select 0;
      if ([getPosATL _road, [_road, _dorfkern] call BIS_fnc_DirTo, 180, _dorfkern] call BIS_fnc_inAngleSector) then {
		    ([_road, _connectedRoad] call BIS_fnc_DirTo) - 180;
      } else {
        [_road, _connectedRoad] call BIS_fnc_DirTo;
      };
    } else {
      [_pos, 50, _dorfkern] call zumi_fnc_sichtcheck;
    };
    //zumi_stellungen pushBack [_pos, "o_installation", "Strassensperre", 0.4, ([_pos, 5] call CBA_fnc_randPos), cba_missiontime, false];
    _return = [_pos, _dir, _x, surfaceNormal _pos] call zumi_fnc_spawn_it;
    _return params ["_u","_v","_o"];
    zumi_soldaten append _u;
    zumi_fahrzeuge append _v;
    zumi_misc append _o;
    _inf_gehaertet append _u;
  };
} forEach _result;

/*

  Felder verminen (mit Warnschild) oder Rommelspiesse hinstellen

*/

private _anzahl_minenfelder = floor linearConversion [1, 5, _feindkraft, 1 , 3, true];
for "_i" from 1 to _anzahl_minenfelder do {
  _pos = [_position, _rad/2, 1, 1, 25, 10, 0.25, true, false, false, false, false, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isEqualto []) then {
    private _mines = [_pos, 100, 15, 10, selectRandom ["mixed","ap","at"], 1, [east, civilian], false] call zumi_fnc_minenfeld;
    zumi_misc append _mines;
    //zumi_stellungen pushBack [_pos, "o_ordnance", "Minenfeld", 0.1, ([_pos, 100] call CBA_fnc_randPos), cba_missiontime, false];
  };
};


/*

  Spawne Patrouillen mit erweitertem _rad und füge sie den Spähern hinzu

*/

for "_i" from 1 to ((ceil random (_anzahl_spaeher select 1)) max (_anzahl_spaeher select 0)) do {
  private _pos = [_position, _rad, 1, 1, 15, 1, 0.3, false, false, false, false, false, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _grp = [_pos, east, format ["AXIS_Gruppe_%1", round random 5]] call zumi_fnc_spawn_grp;
    _spaeher pushBack _grp;
    zumi_soldaten pushBack _grp;
    {
      _units pushBack _x;
    } forEach (units _grp);
    _grp setVariable ["truppengattung", "spaeher"];
    [_grp, _position, _spaeher_rad, 5, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [5, 10, 25]] call CBA_fnc_taskPatrol;
    [
      {
        params ["_grp","_ziel"];
        if ({alive _x} count (units _grp) == 0 || isNull _grp) exitWith {};
        [_grp, _ziel] call zumi_fnc_befehl_erfragen;
      },
      [_grp, _position],
      _i * 120
    ] call CBA_fnc_waitAndExecute;
  };
};


/*

  Spawne Infanterie zu Fuss im Ortskern

*/

for "_i" from 1 to ((ceil random (_anzahl_pats select 1)) max (_anzahl_pats select 0)) do {
  private _pos = [_dorfkern, radius/2, 1, 1, 5, 1, 0.3, false, false, false, false, false, _polygon] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _grp = [_pos, east, format ["AXIS_Gruppe_%1", round random 5]] call zumi_fnc_spawn_grp;
    _inf_fuss pushBack _grp;
    zumi_soldaten pushBack _grp;
    {
      _units pushBack _x;
    } forEach (units _grp);
    _grp setVariable ["truppengattung", "fusstrupp"];
    [_grp, _dorfkern, radius, 3, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", [15, 30, 60]] call CBA_fnc_taskPatrol;
    [
      {
        params ["_grp","_ziel"];
        if ({alive _x} count (units _grp) == 0 || isNull _grp) exitWith {};
        [_grp, _ziel] call zumi_fnc_befehl_erfragen;
      },
      [_grp, _dorfkern],
      _i * 300
    ] call CBA_fnc_waitAndExecute;
  };
};


/*

  Spawne motorisierte Infanterie

*/

if ((_leicht select 1) > 0) then {
  for "_i" from 1 to ((ceil random (_leicht select 1)) max (_leicht select 0)) do {
    private _pos = [_position, _rad, 1, 1, 15, 6, 0.4, false, true, false, false, false, _polygon] call zumi_fnc_rnd_pos;
    if !(_pos isequalto []) then {
      private _spawn = [_pos, east, selectRandom (_kfz_typen_leicht call zumi_fnc_fzg_namen), format ["AXIS_LKW_Gruppe_%1", round random 1]] call zumi_fnc_spawn_fzg;
      _spawn params ["_grp","_vehicle"];
      _inf_mot pushBack _grp;
      zumi_soldaten pushBack _grp;
      {
        _units pushBack _x;
      } forEach (units _grp);
      zumi_fahrzeuge pushBack _vehicle;
      _fzg pushback _vehicle;
      _grp setVariable ["truppengattung", "trupp_mot"];
      [_grp, _position, _pat_rad, 4, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [15, 25, 35]] call CBA_fnc_taskPatrol;
      [
        {
          params ["_grp","_ziel"];
          if ({alive _x} count (units _grp) == 0 || isNull _grp) exitWith {};
          [_grp, _ziel] call zumi_fnc_befehl_erfragen;
        },
        [_grp, _position],
        _i * 600
      ] call CBA_fnc_waitAndExecute;
    };
  };
};


/*

  Spawne mechanisierte Infanterie

*/

if ((_mittel select 1) > 0) then {
  for "_i" from 1 to ((ceil random (_mittel select 1)) max (_mittel select 0)) do {
    private _pos = [_position, 1000, 1, 1, 15, 6, 0.4, false, true, false, false, false, _polygon] call zumi_fnc_rnd_pos;
    if !(_pos isequalto []) then {
      private _spawn = [_pos, east, selectRandom (_kfz_typen_mittel call zumi_fnc_fzg_namen), format ["AXIS_LKW_Gruppe_%1", round random 1]] call zumi_fnc_spawn_fzg;
      _spawn params ["_grp","_vehicle"];
      _inf_mech pushBack _grp;
      zumi_soldaten pushBack _grp;
      {
        _units pushBack _x;
      } forEach (units _grp);
      zumi_fahrzeuge pushBack _vehicle;
      _fzg pushBack _vehicle;
      _grp setVariable ["truppengattung", "trupp_mech"];
      [_grp, _position, _pat_rad, 4, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [15, 25, 35]] call CBA_fnc_taskPatrol;
      [
        {
          params ["_grp","_ziel"];
          if ({alive _x} count (units _grp) == 0 || isNull _grp) exitWith {};
          [_grp, _ziel] call zumi_fnc_befehl_erfragen;
        },
        [_grp, _position],
        _i * 600
      ] call CBA_fnc_waitAndExecute;
    };
  };
};

/*

  Spawne Panzer

*/

if ((_schwer select 1) > 0) then {
  for "_i" from 1 to ((ceil random (_schwer select 1)) max (_schwer select 0)) do {
    private _pos = [_position, _rad, 1, 1, 15, 6, 0.4, false, true, false, false, false, _polygon] call zumi_fnc_rnd_pos;
    if !(_pos isequalto []) then {
      private _spawn = [_pos, east, selectRandom (_kfz_typen_schwer call zumi_fnc_fzg_namen)] call zumi_fnc_spawn_fzg;
      _spawn params ["_grp","_vehicle"];
      _panzer pushBack _grp;
      zumi_soldaten pushBack _grp;
      {
        _units pushBack _x;
      } forEach (units _grp);
      zumi_fahrzeuge pushBack _vehicle;
      _fzg pushback _vehicle;
      _grp setVariable ["truppengattung", "panzer"];
      [_grp, _position, _pat_rad, 4, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [20, 40, 60]] call CBA_fnc_taskPatrol;
      [
        {
          params ["_grp","_ziel"];
          if ({alive _x} count (units _grp) == 0 || isNull _grp) exitWith {};
          [_grp, _ziel] call zumi_fnc_befehl_erfragen;
        },
        [_grp, _position],
        _i * 600
      ] call CBA_fnc_waitAndExecute;
    };
  };
};

//Handler für Kommandanten
[
  {
    params ["_pos","_tsk"];
    [_pos, _tsk] call zumi_fnc_kommandant_handler;
  },
  [_position, _taskname],
  60
] call CBA_fnc_waitAndExecute;

//handler für Befehle
[
  {
    params ["_tsk"];
    [_tsk] call zumi_fnc_befehl_handler;
  },
  [_taskname],
  60
] call CBA_fnc_waitAndExecute;

//handler für Steilfeuer
[
  {
    params ["_tsk"];
    [_tsk] call zumi_fnc_steilfeuer_handler;
  },
  [_taskname],
  60
] call CBA_fnc_waitAndExecute;


_unitcount = 0;
//Aktualisiere lebende Teile des Feindes
{
  if (count (_x call CBA_fnc_getAlive) > 0) then {
    _unitcount = _unitcount + (count (_x call CBA_fnc_getAlive));
  };
} forEach zumi_soldaten;

[_position, "axis", [cba_missiontime, cba_missiontime + (_zeitansatz - 900)], 100, _feindkraft, _unitcount, 0.75, _taskname] call zumi_fnc_verst_loop;

private _intel_carriers = [zumi_soldaten, count zumi_stellungen] call CBA_fnc_selectRandomArray;
{
  [leader _x, "acex_intelitems_notepad", format ["We are assigned to %1 in map grid %2", (zumi_stellungen select _forEachIndex) select 3, ((zumi_stellungen select _forEachIndex) select 1) select 0]] call acex_intelitems_fnc_addIntel;
} forEach _intel_carriers;

private _spoilers = [zumi_kommandeure, {alive _x} count zumi_kommandeure] call CBA_fnc_selectRandomArray;
{
  [_x, "acex_intelitems_document", format ["Your fellow officer is stationed in grid %1", [(zumi_kommandeure select _forEachIndex)] call cba_fnc_getPos]] call acex_intelitems_fnc_addIntel;
} forEach _spoilers;

zumi_truppenteile = [_spaeher, _inf_fuss, _inf_mot, _inf_mech, _inf_gehaertet, _panzer, _luftabwehr, _bomber, _starrfluegler, _funker];



[_units, _fzg, _obj, _markers]
