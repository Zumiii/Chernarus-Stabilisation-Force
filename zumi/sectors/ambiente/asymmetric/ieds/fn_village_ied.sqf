if !isServer exitWith {};


params ["_sector"];

private _rad = _sector getVariable ["radius", 200];
private _id = _sector getVariable ["id", _i];
private _securityparams = _sector getVariable ["securityparams", [100, 100, true]];
private _objects = _sector getVariable ["objects", []];
_securityparams params [["_tension", 50],["_humanitarian", 50],["_ied", false]];

private ["_ladung","_ladungen"];


_iedtype = switch (true) do {
  case (_tension >= 0 && _tension < 25) : {
      (["DemoCharge_Remote_Ammo","ACE_IEDUrbanSmall_Range_Ammo","ACE_IEDLandSmall_Range_Ammo"] call BIS_fnc_SelectRandom);
  };
  case (_tension >= 25 && _tension < 50) : {
    (["DemoCharge_Remote_Ammo","SatchelCharge_Remote_Ammo","ACE_IEDUrbanSmall_Range_Ammo","ACE_IEDLandSmall_Range_Ammo"] call BIS_fnc_SelectRandom);
  };
  case (_tension >= 50 && _tension < 75) : {
    (["ACE_IEDUrbanSmall_Range_Ammo","SatchelCharge_Remote_Ammo","ACE_IEDLandSmall_Range_Ammo","ACE_IEDLandBig_Range_Ammo","DemoCharge_Remote_Ammo"] call BIS_fnc_SelectRandom);
  };
  case (_tension >= 75 && _tension <= 100) : {
    (["SatchelCharge_Remote_Ammo","ACE_IEDUrbanBig_Range_Ammo","ACE_IEDLandBig_Range_Ammo","ACE_IEDLandSmall_Range_Ammo","ACE_IEDUrbanSmall_Range_Ammo","DemoCharge_Remote_Ammo"] call BIS_fnc_SelectRandom);
  };
};
_grps = switch _iedtype do {
  case "ACE_IEDUrbanSmall_Range_Ammo" ;
  case "ACE_IEDLandSmall_Range_Ammo" ;
  case "ACE_IEDUrbanBig_Range_Ammo" ;
  case "ACE_IEDLandBig_Range_Ammo" : {
    if (random 1 >= 0.25) then {
      [_position, _iedtype, _rad, true, _id] call zumi_fnc_preplaced_ied
    } else {
      [_position, _iedtype, _rad, false, _id] call zumi_fnc_preplaced_ied
    };
  };
  case "SatchelCharge_Remote_Ammo" ;
  case "DemoCharge_Remote_Ammo" : {
    if (random 1 >= 0.5) then {
      [_objects, _iedtype, true, _id] call zumi_fnc_carbomb;
    } else {
      [_objects, _iedtype, false, _id] call zumi_fnc_carbomb
    };
  };
  default {[grpNull]};
};
if (debug) then {
  systemchat format ["IED des Typs %2 bei %1 vorhanden an Position %3", (villages select _id) select 8, _iedtype, str _position];
};

_grps;
