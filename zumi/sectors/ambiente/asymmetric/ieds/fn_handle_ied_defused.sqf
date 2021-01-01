if !isServer exitWith {};

params ["_ied","_pio"];

if (_ied in zumi_ieds) then {
  zumi_ieds deleteAt (zumi_ieds find _ied);
  publicVariable "zumi_ieds";
  _id = (_ied getVariable ["id", -1]);
  if (_id >= 0) then {
    ((villages select _id) select 3) set [2, false];
    ["zumi_sanktion", [10, _id]] call CBA_fnc_serverEvent;
  } else {
    ["zumi_sanktion", [10, -1]] call CBA_fnc_serverEvent;
  };

  "Explosive defused!" remoteExecCall ["hint", _pio];
  ieds_defused = ieds_defused + 1;
};
