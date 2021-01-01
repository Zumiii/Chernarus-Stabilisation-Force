/*

  Adapted from Ace_Explosives

*/


params ["_unit", "_explosive", "_magazineClass"];

if !(local _unit) exitWith {};


// Config is the last item in the list of passed in items.
private _config = (_this select 3) select (count (_this select 3) - 1);

private _requiredItems = getArray (_config >> "requires");
private _hasRequired = true;
private _detonators = [_unit] call ace_explosives_fnc_getDetonators;

{
    if !(_x in _detonators) exitWith{
        _hasRequired = false;
    };
} count _requiredItems;

private _code = "";
while {true} do {
    _code = [floor(random 10000), 4] call CBA_fnc_formatNumber;
    if (([_code] call ace_explosives_fnc_getSpeedDialExplosive) isEqualTo []) exitWith {};
};

if (isNil "ace_explosives_CellphoneIEDs") then {
    ace_explosives_CellphoneIEDs = [];
};

private _count = ace_explosives_CellphoneIEDs pushBack [_explosive, _code, getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "ACE_Triggers" >> "Cellphone" >> "FuseTime")];
_count = _count + 1;
publicVariable "ace_explosives_CellphoneIEDs";



_unit setVariable ["Ied_code", _code];


if !(_hasRequired) exitWith {
  _code;
};
[format ["IED %1", _count], _code] call ace_explosives_fnc_addToSpeedDial;

if (_unit getVariable ["triggering", false]) then {
  _array = _unit call CBA_fnc_getNearestBuilding;
  _array params ["_building", "_buildingPositions"];
  if (_unit distance2d _building <= 25) then {
    private _pos = if (_buildingPositions > 1) then {selectRandom (_building buildingPos -1)} else {_building buildingPos 0};
    _unit setVariable ["in_deckung", 1, true];
    _unit setVariable ["hat_angst", 1, true];
    [_unit, _pos, 0, "MOVE", "CARELESS", "GREEN", "FULL", "STAG COLUMN", "[this, (this getVariable ['ied_code', '0000'])] call zumi_fnc_call_ied;"] call CBA_fnc_addWaypoint;
  } else {
    [_unit, _unit getPos [10, ([_explosive, _unit] call bis_fnc_dirTo)], 0, "MOVE", "CARELESS", "GREEN", "FULL", "STAG COLUMN", "[this, (this getVariable ['ied_code', '0000']), true] call zumi_fnc_call_ied;"] call CBA_fnc_addWaypoint;
  };
};

_code;
