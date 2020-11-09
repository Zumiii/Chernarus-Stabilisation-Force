if !isServer exitWith {};

params ["_decoratives", "_id"];

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
