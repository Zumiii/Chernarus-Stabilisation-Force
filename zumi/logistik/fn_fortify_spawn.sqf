/*

  Diese Funktion spawnt die ACEX Fortificationobjekte und sorgt dafür, dass sie die Undeployaction kriegen

*/

if !isServer exitWith {};

params ["_objekte"];

//wenn keine Objekte da sind, verlasse Skript.
if (count _objekte < 1) exitWith {};

_objs = [];
{
  _x params ["_klasse", "_posatl_str", "_pby_str"];
  _posatl = parseSimpleArray _posatl_str;
  _pby = parseSimpleArray _pby_str;
  _pby params ["_pitch","_bank","_yaw"];
  private _objekt = createVehicle [_klasse, [0,0,0], [], 0, "CAN_COLLIDE"];
  _objs pushBack _objekt;
  [_objekt, _pitch, _bank, _yaw] call ace_common_fnc_setPitchBankYaw;
  _objekt setPosATL _posatl;
  _objekt setVariable ["kann_weg", false];
  //Kleinen Delay machen ev?

  if (_objekt isKindOf "StaticWeapon") then {
    _objekt enableWeaponDisassembly false;
  };

} forEach _objekte;

{
  ["acex_fortify_objectPlaced", [objNull, west, _x]] call CBA_fnc_globalEvent;
} forEach _objs;
