/*

  Funktion weist einer Unit ein Intel zu

*/

if !isServer exitWith {};

params ["_unit", ["_id", -1]];

//Suche das geeignete Intel
_informationen = [_unit, _id] call zumi_fnc_intel_wahl;
_unit setVariable ["intel", _informationen, true];
