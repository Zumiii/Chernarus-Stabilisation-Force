params ["_unit", "_position", ["_ladung", "SatchelCharge_Remote_Mag"], ["_triggertype", "DeadmanSwitch"], ["_handy", false], ["_triggering", false]];

_explosive = [_unit, _unit modelToWorldVisual [0,0.5, 0], random 360, _ladung, _triggertype, []] call ace_explosives_fnc_placeExplosive;
zumi_ieds pushBack _explosive;

if (debug) then {
  systemChat str _code;
};

[_unit] call CBA_fnc_clearWaypoints;

if (_triggering) then {
  (_unit setVariable ["triggering", true]);
};

if (_handy) exitWith {
  _code = [_unit, _explosive, _ladung] call zumi_fnc_assign_cellphone_to_ied;
  [_explosive, _code];
};

[_explosive];
