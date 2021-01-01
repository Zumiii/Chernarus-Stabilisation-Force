//if !isServer exitWith {};

params ["_player","_unit"];

if !(local _unit) exitWith {};

if (isNull _unit || !alive _unit || _unit getVariable ["ergeben",false]) exitWith {};

if (_unit getVariable ["combattant", false]) exitWith {
  [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
};

private ["_captive","_veh","_driver"];

_captive = if (captive _unit) then {true} else {false};

if ((vehicle _unit) iskindOf "Landvehicle") then {
  _veh = vehicle _unit;
  _unit = driver _veh;
  _veh engineOn false;
  _unit setVariable ["ergeben", true];
  _unit action ["Eject", _veh];
  _unit setVariable ["kooperiert", true];
  _unit setVariable ["info_1",false];
  [
    {
      [(_this select 0), true] call ACE_captives_fnc_setSurrendered;
    },
    [_unit],
    1
  ] call CBA_fnc_waitAndExecute;
  "You signal the driver to stop, get out and put his hands up" remoteExecCall ["hint", _player];
} else {
  [_unit, true] call ACE_captives_fnc_setSurrendered;
  _unit setVariable ["ergeben", true];
  _unit setVariable ["kooperiert", true];
  _unit setVariable ["info_1",false];
  "You signal the man to stop and put his hands up." remoteExecCall ["hint", _player];
};


[
  {
    //weaponLowered (_this select 0) || ((_this select 0) distance2d (_this select 1) >= 25) || !alive (_this select 1)
    ((_this select 0) distance2d (_this select 1) >= 25) || !alive (_this select 1)
  },
  {
    [
      {
        if (isNull (_this select 1) || !alive (_this select 1)) exitWith {};
        [(_this select 1), false] call ACE_captives_fnc_setSurrendered;
        if ((_this select 2)) then {(_this select 1) setCaptive true;};
        (_this select 1) setVariable ["ergeben", false];
      },
      [(_this select 0),(_this select 1),(_this select 2)],
      5
    ] call CBA_fnc_waitAndExecute;
  },
  [_player,_unit,_captive]
] call CBA_fnc_waitUntilAndExecute;
