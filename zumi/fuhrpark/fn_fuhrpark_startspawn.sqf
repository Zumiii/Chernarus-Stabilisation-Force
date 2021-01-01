/*

  Spawnt beim Serverstart aktive Fahrzeuge serverseitig

*/

if !isServer exitWith {};

params ["_id"];

private _inidbi = ["new", "us"] call OO_INIDBI;

_array = ["read", ["Fuhrpark", format ["fzg_%1", _id], []]] call _inidbi;

_array params ["_id", "_aktiv", "_status", "_typ", "_obj", "_dmg", "_ammo", "_fuel", "_san", "_rep", "_cargo" ,["_refueler",-1], ["_ammotruck",0], "_pitch_bank_yaw", ["_locked", 0]];

private _veh = createVehicle [_typ, [0,0,0], [], 0, "CAN_COLLIDE"];


[_veh, (_pitch_bank_yaw select 0), (_pitch_bank_yaw select 1), (_pitch_bank_yaw select 2)] call ace_common_fnc_setPitchBankYaw;
_veh setPosATL _status;

if (_typ IN ["UK3CB_BAF_LandRover_Panama_Sand_A_MTP", "B_UAV_02_dynamicLoadout_F"]) then {
  createVehicleCrew _veh;
};

if (_typ IN ["rhsusf_stryker_m1126_m2_d","rhsusf_stryker_m1126_mk19_d","rhsusf_stryker_m1127_m2_d","rhsusf_stryker_m1132_m2_np_d","rhsusf_stryker_m1132_m2_d","rhsusf_stryker_m1134_d"]) then {
  [_veh, "tan"] call BIS_fnc_initVehicle;
};



{
  if ((_x select 2) > 0) then {
    _veh setHit [(_x select 1), (_x select 2), false];
  };
} forEach _dmg;

if !(_ammo isEqualTo []) then {
  _veh setVehicleAmmo 0;
  reverse _ammo;
  {
    _x params ["_magclass","_trtpath","_isPylon","_pylonIndex","_maxmags","_currmags","_maxrounds","_currrounds"];
    if (_currmags == 0) exitWith {};
    for "_i" from 0 to _currmags-1 do {
      [_veh, _trtpath, _magclass, _currrounds] call ace_rearm_fnc_setTurretMagazineAmmo;
    };
  } forEach _ammo;
};
_veh setFuel _fuel;
_veh setVariable ["ace_medical_medicClass", _san, true];
_veh setVariable ["ace_isRepairVehicle", _rep, true];
if (_refueler > 0) then {
  _veh setVariable ["ace_refuel_currentFuelCargo", _refueler, true];
};
if (_ammotruck > 0) then {
  _veh setVariable ["ace_rearm_currentSupply", _ammotruck, true];
};
clearBackpackCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;

_veh setVariable ["id", _id, true];
_veh setVariable ["kann_weg", false];

if (count _cargo > 0) then {
  _cargo params ["_weps", "_mags", "_items", "_containers"];
  if !(_weps isEqualTo []) then {
    for "_i" from 0 to (count _weps)-1 do {
      _veh addWeaponWithAttachmentsCargoGlobal [_weps select _i, 1];
    };
  };
  if !(_mags isEqualTo []) then {
    for "_i" from 0 to (count _mags)-1 do {
      //_veh addMagazineCargoGlobal [(_mags select 0) select _i, (_mags select 1) select _i];
      _veh addMagazineAmmoCargo [(_mags select _i) select 0, 1, (_mags select _i) select 1];
    };
  };
  if !(_items isEqualTo [[],[]]) then {
    for "_i" from 0 to (count (_items select 0))-1 do {
      _veh addItemCargoGlobal [(_items select 0) select _i, (_items select 1) select _i];
    };
  };
  if !(_containers isEqualTo []) then {
    for "_i" from 0 to (count _containers)-1 do {
      (_containers select _i) params ["_klasse", "_weparray", "_magarray", "_itemarray"];
      _veh addBackpackCargoGlobal [_klasse, 1];
      if !(_weparray isEqualTo []) then {
        for "_j" from 0 to (count _weparray)-1 do {
          _bp = (((everyContainer _veh) select _i) select 1);
          _bp addWeaponWithAttachmentsCargoGlobal  [(_weparray select _j), 1];
        };
      };
      if !(_magarray isEqualTo []) then {
        for "_j" from 0 to (count _magarray)-1 do {
          _bp = (((everyContainer _veh) select _i) select 1);
          _bp addMagazineAmmoCargo [(_magarray select _j) select 0, 1, (_magarray select _j) select 1];
        };
      };
      if !(_itemarray isEqualTo []) then {
        for "_j" from 0 to (count _itemarray)-1 do {
          _bp = (((everyContainer _veh) select _i) select 1);
          _bp addItemCargoGlobal [(_itemarray select _j), 1];
        };
      };
    };
  };
};

private _pitchbankyaw_new = [_veh] call ace_common_fnc_getPitchBankYaw;
private _newpos = getPosATL _veh;

_veh lock _locked;

["write", ["Fuhrpark", format ["fzg_%1", _id],
  [_id, true, _newpos, _typ, "obj", _dmg, _ammo, _fuel, _san, _rep, _cargo, _refueler, _ammotruck, _pitchbankyaw_new]
]] call _inidbi;

(Fahrzeuge_Temp select (_id - 1)) set [2, (getPosATL _veh)];
(Fahrzeuge_Temp select (_id - 1)) set [4, _veh];
publicvariable "Fahrzeuge_Temp";
