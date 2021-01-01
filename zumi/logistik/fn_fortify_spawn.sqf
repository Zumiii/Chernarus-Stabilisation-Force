/*

  Diese Funktion spawnt die ACEX Fortificationobjekte und sorgt dafür, dass sie die Undeployaction kriegen

*/

if !isServer exitWith {};

params ["_objekte"];

//wenn keine Objekte da sind, verlasse Skript.
if (count _objekte < 1) exitWith {};

_objs = [];
{
  _x params ["_klasse", "_posatl_str", "_pby_str", ["_verladen", -1]];
  _posatl = parseSimpleArray _posatl_str;
  _pby = parseSimpleArray _pby_str;
  _pby params ["_pitch","_bank","_yaw"];
  private _objekt = createVehicle [_klasse, [0,0,0], [], 0, "CAN_COLLIDE"];
  _objs pushBack _objekt;
  _objekt setVariable ["kann_weg", false];
  if (_objekt isKindOf "StaticWeapon") then {
    _objekt enableWeaponDisassembly false;
  };

  if (_verladen > 0) then {
    (Fahrzeuge_Temp select (_verladen - 1)) params ["_id", "_aktiv", "_status", "_typ", "_obj", "_dmg", "_ammo", "_fuel", "_san", "_rep", "_cargo" ,["_refueler",-1], ["_ammotruck",0], "_pitch_bank_yaw", ["_locked", 0]];
    if (_locked > 0) then {
      ((Fahrzeuge_Temp select (_verladen - 1)) select 4) lock 0;
    };
    [_objekt, (Fahrzeuge_Temp select (_verladen - 1)) select 4, true] call ace_cargo_fnc_loadItem;
    _objekt setVariable ["verladen", _verladen];
    if (_locked > 0) then {
      ((Fahrzeuge_Temp select (_verladen - 1)) select 4) lock _locked;
    };
  } else {
    [_objekt, _pitch, _bank, _yaw] call ace_common_fnc_setPitchBankYaw;
    _objekt setPosATL _posatl;
  };

} forEach _objekte;

{
  ["acex_fortify_objectPlaced", [objNull, west, _x]] call CBA_fnc_serverEvent;
} forEach _objs;
