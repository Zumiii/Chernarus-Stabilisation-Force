
params ["_player","_unit"];

if !(local _unit) exitWith {};

if (_unit getVariable ["combattant", false]) exitWith {
  [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
};

if (isNull (driver _unit) || !alive (driver _unit) || (_unit getVariable ["ace_captives_isHandcuffed", false])) exitWith {};

if ((vehicle _unit) iskindOf "Landvehicle") then {
  "You signal the driver drive on." remoteExecCall ["hint", _player];
} else {
  "You signal the man to go on." remoteExecCall ["hint", _player];
};

[_unit, false] call ACE_captives_fnc_setSurrendered;
_unit enableAI "MOVE";
_unit setVariable ["kooperiert", false, true];
_unit setVariable ["ergeben", false, true];
