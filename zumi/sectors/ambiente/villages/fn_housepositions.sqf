
if !isServer exitWith {};

private ["_hpos","_hausarray"];

params ["_position","_rad","_anzahl","_z","_abstand"];

//if (typename _position == typename objNull) then {_position = getposASL _position};
_hausarray = [


];

_hpos = [];
{
    if ((count (_x buildingPos -1)) > 1) then {
    _hpos set [count _hpos,((_x buildingPos -1) call BIS_fnc_SelectRandom)];
};
} foreach (nearestTerrainObjects [_position, ["House"], _rad]);


// Height
if (count _this > 3) then {
  private ["_tmp","_min","_max","_h"];
  _tmp = [];
  _min = (_this select 3) select 0;
  _max = (_this select 3) select 1;
  {
    _h = _x select 2;
    if (_h >= _min && _h <= _max) then { _tmp set [count _tmp,_x] };
  } foreach _hpos;
  _hpos = _tmp;
};

if (count _this > 4) then {
  private _return = [];
  for "_j" from 0 to (count _hpos)-1 do {
    private _temp = (_hpos select _j);
    if ((count _return) >= _anzahl) exitWith {};
    _posiok = true;
    for "_k" from 0 to (count _return)-1 do {
      if ((_return select _k) distance2d _temp < _abstand) then {
        _posiok = false;
      };
      if  ((_return select _k) isequalTo _temp) then {
        _posiok = false;
      };
    };
    if (_posiok) then {
      _return pushBack _temp;
    };
  };
  _diff = (_anzahl - (count _return));
  if (_diff > 0) then {
    for "_i" from 0 to (_diff-1) do {
      _return pushBack (_hpos call BIS_fnc_SelectRandom);
    };
  };
  _hpos = _return;
};

_hpos
