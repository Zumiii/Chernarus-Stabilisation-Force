//if !isServer exitWith {};

params ["_player","_unit"];

if !(local _unit) exitWith {};

if (isNull driver _unit || (!alive (driver _unit)) || (_unit getVariable ["kooperiert",false])) exitWith {};

if (_unit getVariable ["combattant", false]) exitWith {
  [_unit, "gestureHib" , 1] call ace_common_fnc_doGesture;
};

private ["_veh","_driver"];

if ((vehicle _unit) iskindOf "Landvehicle") then {
  _veh = vehicle _unit;
  _unit = driver _veh;
  "You signal the driver to stop" remoteExecCall ["hint", _player];
  _unit disableAI "MOVE";
  _unit setVariable ["kooperiert", true, true];
} else {
  "You signal the man to stop." remoteExecCall ["hint", _player];
  _unit disableAI "MOVE";
  _unit setVariable ["kooperiert", true, true];
};

[
  {
    ((_this select 0) distance2d (_this select 1) >= 25) || !alive (_this select 1)
  },
  {
    [
      {
        if (isNull (_this select 0) || !alive (_this select 0) || !((_this select 0) getVariable ["kooperiert", false])) exitWith {};
        (_this select 0) enableAI "MOVE";
        (_this select 0) setVariable ["kooperiert", false, true];
      },
      [(_this select 1)],
      5
    ] call CBA_fnc_waitAndExecute;
  },
  [_player, _unit]
] call CBA_fnc_waitUntilAndExecute;
