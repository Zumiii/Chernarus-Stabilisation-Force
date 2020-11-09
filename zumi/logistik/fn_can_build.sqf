/*

  Sind überhaupt die benötigten Sandsäcke für den Bau einer Mauer z. Bsp da?

*/

if (!isServer) exitWith {};

params ["_pos", "_class"];

_can_build = true;
_nearObjects = nearestObjects [_pos, ["All"], 10, true];

if ({_class isEqualTo (_x select 0)} count befestigungsobjekte > 0) then {
  _objectsRequired = ((befestigungsobjekte select {(_x select 0) isEquaLTo _class}) select 0) select 2;
  for "_i" from 0 to (count _objectsRequired) - 1 do {
    (_objectsRequired select _i) params ["_obj_class", "_count"];
    if (({(typeOf _x) isEquaLTo _obj_class} count _nearObjects) < _count) then {
      _can_build = false;
    };
  };
};

/*
_can_build = switch _class do {
  case "Land_Fort_Bagfence_Bunker" : {
    _has_required = true;
    _objectsRequired = ((befestigungsobjekte select {(_x select 0) isEquaLTo _class}) select 0) select 2;
    for "_i" from 0 to (count _objectsRequired) - 1 do {
      (_objectsRequired select _i) params ["_obj_class", "_count"];
      if (({(typeOf _x) isEquaLTo _obj_class} count _nearObjects) < _count) then {
        _has_required = false;
      };
    };
    _has_required;

  };

  default {true};

};
*/
_can_build;
