params ["_unit"];

if !(local _unit) exitWith {};

private _pos = [_unit] call cba_fnc_getPos;

private _targets = _unit nearTargets 300;
_targets = _targets select {
  (side (_x select 4) IN [west, resistance])
};
//Sort the array (ascending threat)
_targets = [_targets, 3] call CBA_fnc_sortNestedArray;

private _vehicles = _targets select {((_x select 1) isKindOf "Car") || ((_x select 1) isKindOf "Tank")};

if (count _vehicles < 1) exitWith {
  [];
};

  //Check Vehicles for Crew (Gunner, FFV and Turrets that he vaguely knows about can see him)

private _return = [];
{
  private _crew = [(_x select 4), ["gunner", "turret", "ffv", "commander"]] call ace_common_fnc_getVehicleCrew;
  private _aware_people = _crew select {(_x knowsabout _unit) >= 4};
  if ((count _aware_people) > 0) then {
    _return pushBackUnique _x;
  };
} foreach _vehicles;
if ((count _return) < 1) exitWith {
  [];
};
//Nächstes Ziel ist das beste!
[_return, {-(_unit distance (_x select 4))}, _unit] call CBA_fnc_selectBest;
