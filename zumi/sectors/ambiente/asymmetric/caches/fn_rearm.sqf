/*

  Function that makes AI arm up

*/

Params ["_grp"];

if !(local _grp) exitWith {};

private _unit = (leader _grp);
/*
private _rearm = (_unit getVariable ["rearm", 0]);

if (_rearm < 1) exitWith {};
*/
private _house = (_unit getVariable ["house", objNull]);
private _spawnpos = _unit getVariable ["spawn_pos", getPosATL _unit];
if !(alive _house) exitWith {
  //Temporary solution, he runs ro his house in disbelief
  [_unit, _spawnpos, 0, "HOLD", "AWARE", "YELLOW", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;

};

private _stash = (_house getVariable ["hiddenweapons", []]);
if (count _stash < 1) exitWith {
  //Temporary solution, he realizes and shouts in anger
  [_unit, _spawnpos, 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "[(leader this), format ['blow_%1', ceil round random 2], 15] call CBA_fnc_globalSay3d;"] call CBA_fnc_addWaypoint;
};

if ((_unit distance2d _spawnpos > 2) || !(_unit call ace_common_fnc_isInBuilding)) exitWith {
  //Unit could for some reason not reach the waypoint
};

_unit enableAI "AUTOCOMBAT";
_unit allowfleeing courage;
//He finally made it, now lets arm him

//Play anim
[_unit, "PutDown", 1] call ace_common_fnc_doGesture;

_stash params [["_wep", []], ["_ammo", []], ["_grenades", []], ["_backpack", ""]];
if !(_backpack isEqualTo "") then {
  _unit addbackPack _backpack;
};
if !(_wep isEqualTo []) then {
  _wep params [["_weapon", ""], ["_muzzle", ""], ["_flashlight", ""], ["_optics", ""], ["_primarymag", []], ["_secondarymag", []], ["_bipod", ""]];
  if !(_weapon isEqualTo "") then {
    _unit addWeapon _weapon;
  };
  if !(_muzzle isEqualTo "") then {
    _unit addWeaponItem [_weapon, _muzzle, true];
  };
  if !(_optics isEqualTo "") then {
    _unit addWeaponItem [_weapon, _optics, true];
  };
  if !(_flashlight isEqualTo "") then {
    _unit addWeaponItem [_weapon, _flashlight, true];
  };
  if !(_bipod isEqualTo "") then {
    _unit addWeaponItem [_weapon, _bipod, true];
  };
  if !(_primarymag isEqualTo []) then {
    _primarymag params ["_primaryMuzzleMagazine", "_ammoCount"];
    _unit addWeaponItem [_weapon, _primaryMuzzleMagazine, true];
  };
  if !(_secondarymag isEqualTo []) then {
    _secondarymag params ["_secondaryMuzzleMagazine", "_ammoCount"];
    _unit addWeaponItem [_weapon, _secondaryMuzzleMagazine, true];
  };
};
if !(_ammo isEqualTo []) then {
  {
    _x params ["_magclass", "_amount"];
    _unit addMagazine [_magclass, _amount];
  } forEach _ammo;
};
if !(_grenades isEqualTo []) then {
  {
    _x params ["_wepclass", "_amount"];
    _unit addMagazine [_wepclass, _amount];
  } forEach _grenades;
};

private _targets = _unit nearTargets 300;
_targets = _targets select {
  (side (_x select 4) IN [west,resistance])
};
_jip_str = ["ace_common_setCaptive", [_unit, 0]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit] call CBA_fnc_removeGlobalEventJIP;


if ([_unit, "SatchelCharge_Remote_Mag"] call ace_common_fnc_hasMagazine) exitWith {
  {
    _x setWaypointStatements ["true", "[this] call zumi_fnc_loiter;"];
  } forEach (waypoints (group _unit));
};
[_unit] call CBA_fnc_clearWaypoints;

if ((count _targets) < 1) exitWith {
  [_unit, _spawnpos, 0, "DEFEND", "COMBAT", "RED", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
};
//Filter Civilians, unknown and Opfor


//Sort the array (ascending threat)
_targets = [_targets, 3] call CBA_fnc_sortNestedArray;

[_unit, ((selectRandom _targets) select 0), 0, "SAD", "COMBAT", "RED", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;

//If the cache contains charges, make the unit either a vest carrier or in case there is only one: Make him throw that thing at sth
