/*

  Wurde etwas gebaut, so wird das dafür benötigte Material vernichtet

*/

if (!isServer) exitWith {};

params ["_pos", "_class"];


if ({_class isEqualTo (_x select 0)} count befestigungsobjekte < 1) exitWith {};



  _objectsRequired = ((befestigungsobjekte select {(_x select 0) isEquaLTo _class}) select 0) select 2;
  {
    _x params ["_obj_class", "_count"];
    for "_i" from 0 to (_count - 1) do {
      _objs = nearestObjects [_pos, [_obj_class], 10, true];
      if (count _objs > 0) then {
        deleteVehicle (_objs select _i);
      };
    };
  } forEach _objectsRequired;
