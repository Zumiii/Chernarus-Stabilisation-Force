
params ["_pos", ["_dist",50], "_center"];

private _dir = -1;

private _array = [];
private _korrektur = [];

_vd = _pos vectorDiff _center;

_atan = ((_vd select 0) atan2 (_vd select 1));
for "_i" from 0 to 360 step 5 do {
  _temp = (_pos getPos [_dist, _i]);

  _vd_temp = _temp vectorDiff _pos;
  _atan_temp = ((_vd_temp select 0) atan2 (_vd_temp select 1));

  if (_atan_temp > 0) then {
    if (!(terrainIntersect [[_pos select 0, _pos select 1, 5], _temp]) && (_atan_temp < _atan + 90) && (_atan_temp > _atan - 90)) then {
      _array pushBack _i;
    };
  } else {
    if (!(terrainIntersect [[_pos select 0, _pos select 1, 5], _temp]) && (_atan_temp - 90 < _atan) && (_atan_temp + 90 > _atan))  then {
      _array pushBack _i;
    };
  };

};

_dir = if !(_array isequalto []) then {
  (_array call bis_fnc_selectrandom)
} else {
  random 360
};

_dir;
