/*

  Kurzbeschrieb:
  Dieses Skript spawnt feindliche Verstärkungstruppen und unterstellt diese dem Kommando

  verstaerkungsarten = [
    ["spaeher", 0, 1800, 2],
    ["fusstrupp", 0, 0, 1],
    ["at_trupp", 0, 120, 2],
    ["aa_trupp", 0, 300, 2],
    ["trupp_mot", 0, 0, 2],
    ["trupp_mech", 0, 180, 4],
    ["panzer", 0, 180, 5],
    ["fallschirmjaeger", 0, 900, 2],
    ["mobile_luftabwehr", 0, 900, 3],
    ["bomber", 0, 1500, 8],
    ["starrfluegler", 0, 1800, 10],
    ["artillerie", 0, 3600, 8],
    ["funkmobil", 0, 1200, 2]
  ];
*/

if !isServer exitWith {};

params [
	"_taskpos", //Wohin soll die Verstärkung entsendet werden?
	["_fraktion", "axis"], //Welche Fraktion?
	["_typ", "fusstrupp"] //Was soll gespawnt werden?
];

/*

  Suche eine geeignete Spawnposition (Strasse)

*/

_spawndistance = switch _typ do {
  case "fusstrupp" : {3000};
  case "at_trupp";
  case "aa_trupp" : {4000};
  case "trupp_mech";
  case "panzer";
  case "mobile_luftabwehr";
  case "funkmobil";
  case "trupp_mot" : {5000};
  case "spaeher" : {3000};
  case "artillerie" : {5000};
  case "bomber" : {6000};
  case "starrfluegler" : {8000};
  default {3000};
};


_koords = [_taskpos, [500, _spawndistance], 1500] call zumi_fnc_reinf_pos;

_pos = [_koords, 1000, 1, 1, 10, 8, 0.45, false, true] call zumi_fnc_rnd_pos;
if (_pos isEqualTo []) exitWith {
	0
};
//Definiere, wann die Gruppe gespawnt wurde
_zeitstempel = CBA_missiontime;

/*

  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder 30 Min vergangen seit Spawn.
  Dieser gibt ihnen zeitlich unverbindliche, spezifische Befehle entsprechend ihrer Klasse.
  Wenn keiner aktiv ist, beeilt sie sich mit der Verlegung und startet kurz vor Eintreffen im Einsatzgebiet einen Patrouillegang im alarmierten Zustand.
  Die Distanz ist nach Spawntyp differenziert.

*/

_distanz = switch _typ do {
  case "fusstrupp" : {1000};
  case "at_trupp";
  case "aa_trupp" : {2000};
  case "trupp_mech";
  case "panzer";
  case "mobile_luftabwehr";
  case "funkmobil";
  case "trupp_mot" : {1500};
  case "spaeher" : {1500};
  case "artillerie" : {1500};
  case "bomber" : {3500};
  case "starrfluegler" : {5000};
  default {2000};
};

//Das Fallschirmjägerskript unterstellt die Einheiten eigenständig
if (_typ isEqualTo "fallschirmjaeger") exitWith {
  _trupp = switch _fraktion do {
    case "axis_d" : {format ["AXIS_D_Gruppe_%1", (round (random 5))]};
    case "axis" : {format ["AXIS_Gruppe_%1", (round (random 4))]};
  };
  private _grp = [_taskpos, _pos, east, selectRandom ([20] call zumi_fnc_fzg_namen), _trupp, true] call zumi_fnc_paradrop;
  //Retourniere Anzahl lebende Einheiten
  (zumi_truppenteile select 1) pushBack _grp;
  count (_grp call CBA_fnc_getAlive);
};

/*

  Spawne Trupp nach Typ

*/

switch _typ do {
  case "fusstrupp" : {
    _trupp = switch _fraktion do {
      case "axis_d" : {format ["AXIS_D_Gruppe_%1", (round (random 5))]};
      case "axis" : {format ["AXIS_Gruppe_%1", (round (random 4))]};
    };
    _grp = [_koords, east, _trupp] call zumi_fnc_spawn_grp;
    (zumi_truppenteile select 1) pushBack _grp;
    zumi_soldaten pushBack _grp;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "at_trupp" : {
    _trupp = switch _fraktion do {
      case "axis_d" : {format ["AXIS_D_Gruppe_%1", (round (random 5))]};
      case "axis" : {format ["AXIS_Gruppe_%1", (round (random 4))]};
    };
    _grp = [_koords, east, _trupp] call zumi_fnc_spawn_grp;
    (zumi_truppenteile select 1) pushBack _grp;
    zumi_soldaten pushBack _grp;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "aa_trupp" : {
    private _trupp = switch _fraktion do {
      case "axis_d" : {"AXIS_D_AA_Gruppe"};
      case "axis" : {"AXIS_AA_Gruppe"};
    };
    _grp = [_koords, east, _trupp] call zumi_fnc_spawn_grp;
    (zumi_truppenteile select 1) pushBack _grp;
    zumi_soldaten pushBack _grp;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 900) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "trupp_mech" : {
    _class = switch _fraktion do {
      case "axis_d" : {selectRandom ([16] call zumi_fnc_fzg_namen)};
      case "axis" : {selectRandom ([18] call zumi_fnc_fzg_namen)};
    };
    _trupp = switch _fraktion do {
      case "axis_d" : {format ["AXIS_D_APC_Gruppe_%1", round random 2]};
      case "axis" : {format ["AXIS_APC_Gruppe_%1", round random 2]};
    };
    _spawn = [_pos, east, _class, _trupp] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 3) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "panzer" : {
    _spawn = [_pos, east, selectRandom ([20] call zumi_fnc_fzg_namen)] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 5) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "mobile_luftabwehr" : {
    _class = switch _fraktion do {
      case "axis_d" : {selectRandom ([12] call zumi_fnc_fzg_namen)};
      case "axis" : {selectRandom ([26] call zumi_fnc_fzg_namen)};
    };
    _spawn = [_pos, east, _class] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 6) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "funkmobil" : {
    _driver = switch _fraktion do {
      case "axis_d" : {"LOP_TKA_Infantry_Rifleman"};
      case "axis" : {"LOP_TKA_Infantry_Rifleman"};
    };
    private _spawn = [_pos, east, "rhs_gaz66_r142_msv"] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 9) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "trupp_mot" : {
    _driver = switch _fraktion do {
      case "axis_d" : {"LOP_TKA_Infantry_Crewman"};
      case "axis" : {"LOP_TKA_Infantry_Crewman"};
    };
    _class = switch _fraktion do {
      case "axis_d" : {selectRandom ([14,21,15] call zumi_fnc_fzg_namen)};
      case "axis" : {selectRandom ([17,22] call zumi_fnc_fzg_namen)};
    };
    _trupp = switch _fraktion do {
      case "axis_d" : {format ["AXIS_Gruppe_%1", (round (random 5))]};
      case "axis" : {format ["AXIS_Gruppe_%1", (round (random 4))]};
    };
    _spawn = [_pos, east, _class, _trupp] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 2) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "spaeher" : {
    _class = switch _fraktion do {
      case "axis_d" : {selectRandom ([14] call zumi_fnc_fzg_namen)};
      case "axis" : {selectRandom ([25] call zumi_fnc_fzg_namen)};
    };
    _driver = switch _fraktion do {
			case "axis_d" : {"LOP_TKA_Infantry_Crewman"};
      case "axis" : {"LOP_TKA_Infantry_Crewman"};
    };
    _spawn = [_pos, east, _class] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 0) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "artillerie" : {
    _driver = switch _fraktion do {
			case "axis_d" : {"LOP_TKA_Infantry_Crewman"};
      case "axis" : {"LOP_TKA_Infantry_Crewman"};
    };
    _spawn = [_pos, east, selectRandom ([19] call zumi_fnc_fzg_namen)] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    if !(_class IN ["LIB_SdKfz124"]) then {
      zumi_haubitzen pushBack (leader _grp);
    } else {
      zumi_raketen pushBack (leader _grp);
    };
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 1200]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "bomber" : {
    _spawn = [_pos, east, selectRandom ([13] call zumi_fnc_fzg_namen), [], "FLY"] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 7) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;

		//Adde zu den Bombern

		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 120]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if (((leader _grp) distance2d _taskpos) <= _distanz || CBA_missiontime >= _zeitstempel + 1800) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
  case "starrfluegler" : {
    _spawn = [_pos, east, selectRandom ([23] call zumi_fnc_fzg_namen), [], "FLY"] call zumi_fnc_spawn_fzg;
    _spawn params ["_grp", "_veh"];
    (zumi_truppenteile select 8) pushBack _grp;
    zumi_soldaten pushBack _grp;
    zumi_fahrzeuge pushBack _veh;
		/*

		  Setze Variablen für den Befehlshandler etc.

		*/

		_grp setVariable ["befehl", [_pos, "eintreffen", 120]];
		_grp setVariable ["truppengattung", _typ];

		/*

		  Setze Wegpunkt

		*/

		[leader _grp, _taskpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN"] call CBA_fnc_addWaypoint;

		/*

		  Die Verstärkung will erst Befehle vom Befehlshaber, wenn sie nahe genug am EInsatzgebiet ist oder zuviel Zeit vergangen seit Spawn.

		*/

		[
			{
				params ["_args","_handle"];
				_args params ["_taskpos", "_grp", "_distanz", "_zeitstempel"];
				if (count (_grp call CBA_fnc_getAlive) <= 0) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
				};
		    if ((((leader _grp) distance2d _taskpos) <= _distanz) || (CBA_missiontime >= _zeitstempel + 1800)) exitWith {
					[_handle] call CBA_fnc_removePerFrameHandler;
					[_grp, getPos (leader _grp)] call zumi_fnc_befehl_erfragen;
					_grp setVariable ["befehl", []];
				};
			},
			5,
			[_taskpos, _grp, _distanz, _zeitstempel]
		] call CBA_fnc_addPerFrameHandler;
  };
};




//Retourniere Anzahl lebende Einheiten
count (_grp call CBA_fnc_getAlive);
