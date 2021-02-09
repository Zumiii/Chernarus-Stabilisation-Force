if !isServer exitWith {};

villages = [];

for "_i" from 0 to (count commy_sectors) - 1 do {
  private _sector = (commy_sectors select _i);
  private _center = _sector getVariable ["center", [0,0,0]];
  private _polygon = _sector getVariable ["polygon", [[0,0,0],[0,0,1],[0,1,0]]];
  private _rad = _sector getVariable ["radius", 200];
  private _indicator = 0;
  private _name = _sector getVariable ["name", "Test"];
  private _score = _sector getVariable ["score", -15];
  private _roads_count = count (_center nearRoads _rad);
  private _pos_count = floor linearConversion [15, 75, _roads_count, 2, 6, true];
  private _spacing = floor round linearConversion [2, 6, _pos_count, _rad, _rad / _pos_count, true];
  private _posarray = [_center, _rad, 1, _pos_count, _spacing, 2, 0.35, false, true] call zumi_fnc_rnd_pos;
  if (_posarray isEqualTo []) then {
    private _posarray = [_center, _rad, 1, _pos_count, _spacing * 0.75, 1.5, 0.35, false, true] call zumi_fnc_rnd_pos;
  };
  private _housepositions = [_center, _rad, 10, [0,15], (1.5 * _spacing)] call zumi_fnc_housepositions;
  private _mosqs = nearestObjects [_center, ["Land_Church_03"], _rad];
	private _chiefshouse = if !(_mosqs isEqualTo []) then {
		getPosATL (_mosqs call BIS_fnc_SelectRandom);
	} else {
		private _array = _center call CBA_fnc_getNearestBuilding;
    _array params ["_building", "_buildingPositions"];
		getPosATL _building;
	};

  private _tension = round (linearConversion [-15, 15, _score, 100, 0, true]);
  private _humanitarian = round (linearConversion [10, 80, _tension, 20, 70, true]);
  private _security = linearConversion [20, 90, _tension, 0.1, 0.9, true];
  private _ied = if ((random 2) <= _security) then {
    true
  } else {
    false
  };
  private _decoratives = [_posarray, 1] call zumi_fnc_set_decoratives;
  villages pushBack [_i, false, _center, [_tension, _humanitarian, _ied], 0, [], [], _decoratives, _name, _rad, _polygon, _housepositions, _chiefshouse, -1, timestamp, []];

  //Set Sector Variables

  _sector setVariable ["id", _i];
  _sector setVariable ["players_in_sector", 0];
  _sector setVariable ["securityparams", [_tension, _humanitarian, _ied]];
  _sector setVariable ["indicator", 0];
  _sector setVariable ["groups", []];
  _sector setVariable ["objects", []];
  _sector setVariable ["decoratives", _decoratives];
  _sector setVariable ["housepositions", _housepositions];
  _sector setVariable ["chiefshouse", _chiefshouse];
  _sector setVariable ["task", -1];
  _sector setVariable ["timestamp", timestamp];
  _sector setVariable ["intel", []];



};

[MissionconfigFile >> "Sector_Statemachine"] call CBA_statemachine_fnc_createFromConfig;
//CBA_statemachine_stateMachines pushBack stateMachine;


[commy_sectors] call zumi_fnc_sectors_loop;

[phase, villages] call zumi_fnc_init_dyn;
