if !isServer exitWith {};

params [["_pos",[0,0,0]],["_radius",50],["_mode",1],["_anzahl",1],["_spacing",15],["_durchmesser",-1],["_steigung",0.3],["_noclip",false],["_road",false],["_water",false],["_wald",false],["_flatempty",false],["_polygon", []]];


private ["_position","_positionen_array","_waldpos"];
//_idebug = 0;
_positionen_array = [];

_pos = [_pos] call cba_fnc_getPos;

for "_i" from 1 to 1500 do {

  if (count _positionen_array == _anzahl) exitWith {};
  _posigefunden = true;

  switch _mode do {
    case 0 : {
      _position = _pos getPos [random _radius, random 360];
    };
    case 1 : {
      _position = _pos getPos [_radius * sqrt random 1, random 360];
    };
    case 2 : {
      _position = _pos getPos [_radius * random [- 1, 0, 1], random 180];
    };
  };

  if !(_water) then {
    if (surfaceIsWater _position) then {
      _posigefunden = false;
    };
  };
 for "_j" from 0 to ((count _positionen_array)-1) do {
  if (((_positionen_array select _j) distance2d _position) < _spacing) then {
      _posigefunden = false;
    };
  };
 if (_noclip) then {
  for "_j" from 0 to ((count anticliparray)-1) do {
   if (((anticliparray select _j) distance2d _position) < _spacing) then {
    _posigefunden = false;
   };
  };
 };


  if (_wald) then {
    _waldpos = selectBestPlaces [_position, 25, "5*forest + trees - meadow - (10 * houses) - (10 * sea)", 25, 1];
    if (count _waldpos == 0) then {
      _posigefunden = false;
      } else {
        _position = ((_waldpos select 0) select 0);
      };
  };

  if (_road) then {
    if !(isOnRoad _position) then {
      _posigefunden = false;
    };
  } else {
    if (isOnRoad _position || count (_position nearRoads 50) > 1) then {
      _posigefunden = false;
    };
  };
  if (_flatempty) then {
    _position = _position isFlatEmpty [_durchmesser, -1, _steigung, 1, 0, false];
    if (_position isEqualTo []) exitWith {_posigefunden = false};
    if (count (nearestTerrainObjects [_position, [], _durchmesser, false, true]) > 0) exitWith {_posigefunden = false};
    if !(_position isEqualTo []) then {
      ASLtoATL _position;
    } else {
      _posigefunden = false;
    };
  } else {
    _position = _position isFlatEmpty [_durchmesser, -1, _steigung, 1, 0, false];
    if !(_position isEqualTo []) then {
      ASLtoATL _position;
    } else {
      _posigefunden = false;
    };
  };


  if !(_position isEqualTo []) then {
    if !(_polygon isEqualTo []) then {
      if !(_position inPolygon _polygon) then {
        _posigefunden = false;
      };
    };
  };


  if !(_position isEqualTo []) then {
    if !(_position inArea [[8192,8192,0],8000,8000,0,true]) then {
      _posigefunden = false;
    };
  };


 if (_posigefunden) then {
   _position set [2,0];
   _positionen_array pushBack _position;
    if (_noclip) then {
       anticliparray pushBack _position;
   };
 };
};

if (_anzahl > 1) exitWith {
  _positionen_array
};

if (_positionen_array isequalTo []) exitWith {
  []
};

_positionen_array select 0
