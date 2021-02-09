//if !isServer exitWith {};

params ["_sector"];

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
private _players_in_sector = _sector getVariable ["players_in_sector", []];


private _return = [];

{
  _x params ["_pos","_dir","_class"];
  _veh = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
  _veh setDir _dir;
  _veh setPosATL _pos;
  _veh setVectorUp (surfaceNormal (position _veh));
  _return pushBack _veh;
  if (_veh isKindOf "Car") then {
    ["init", _veh] call bis_fnc_carAlarm;
    _veh setVariable ["id", _id];
  };
} forEach _decoratives;

private _goatspawn = selectRandom _decoratives;
for "_i" from 0 to 4 do {
  private _goat = createAgent ["Goat_random_F", [0,0,0], [], 0, "CAN_COLLIDE"];
  _goat setDir (random 360);
  _goat setPosATL (_goatspawn select 0) getPos [1, random 360];
  _return pushBack _goat;
};



_return;
