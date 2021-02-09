if !isServer exitWith {};

params ["_sectors"];

_players = [] call cba_fnc_players;
for "_i" from 0 to (count commy_sectors) - 1 do {
  private _sector = (commy_sectors select _i);
  private _active = _sector getVariable ["active", false];
  private _center = _sector getVariable ["center", [0,0,0]];
  private _polygon = _sector getVariable ["polygon", [[0,0,0],[0,0,1],[0,1,0]]];
  private _rad = _sector getVariable ["radius", 200];
  private _name = _sector getVariable ["name", "Test"];
  private _score = _sector getVariable ["score", -15];
  private _id = _sector getVariable ["id", _i];
  private _securityparams = _sector getVariable ["securityparams", [100, 100, true]];
  private _indicator = _sector getVariable ["indicator", 0];
  private _groups = _sector getVariable ["groups", []];
  private _objects = _sector getVariable ["objects", []];
  private _decoratives = _sector getVariable ["decoratives", []];
  private _housepositions = _sector getVariable ["housepositions", []];
  private _chiefshouse = _sector getVariable ["chiefshouse", [0,0,0]];
  private _task = _sector getVariable ["task", -1];
  private _timestamp = _sector getVariable ["timestamp", timestamp];
  private _intel = _sector getVariable ["intel", []];
  private _players_in_sector = count (_players select {_x distance2d _center < ((4 * _rad) + 200)});
  if (_players_in_sector < 1) then {
    _sector setVariable ["players_in_sector", 0];
    _sector setVariable ["indicator", ((_indicator - 0.01) max 0)];
  } else {
    _sector setVariable ["players_in_sector", _players_in_sector];
    _sector setVariable ["indicator", ((_indicator + 0.1) min 12)];
  };
};


[
  {
    params ["_sectors"];
    [_sectors] call zumi_fnc_sectors_loop;
  },
  [commy_sectors],
  8
] call CBA_fnc_waitAndExecute;
