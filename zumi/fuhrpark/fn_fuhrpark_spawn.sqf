/*

  Spawnt das eingeparkte Fahrzeug

*/

params ["_value", "_uid", "_name"];

if (garage getVariable ["in_arbeit", false]) exitWith {};

garage setVariable ["in_arbeit", true];

//Aus Datenbank abrufen
private _inidbi = ["new", "us"] call OO_INIDBI;

private _whitelist  = ["read", ["Whitelist", "Logistiker", []]] call _inidbi;
if ({_x isEqualTo _uid} count _whitelist < 1) exitWith {
  garage setVariable ["in_arbeit", false];
};

_array = ["read", ["Fuhrpark", format ["fzg_%1", _value], []]] call _inidbi;
if ((count _array) < 1) exitWith {
  garage setVariable ["in_arbeit", false];
};

_array params ["_id", "_aktiv", "_status", "_typ", "_obj", "_dmg", "_ammo", "_fuel", "_san", "_rep", "_cargo" ,["_refueler",-1], ["_ammotruck",0], "_pitch_bank_yaw", ["_locked", 0]];
_blockiert = false;
if (_typ isKindOf "air") then {
  if (count ((getPosATL garage) nearEntities [["CAManBase","Landvehicle", "Air"], 10]) > 0) then {
    _blockiert = true;
  };
} else {
  if (count ((getPosATL garage) nearEntities [["CAManBase","Landvehicle", "Air"], 8]) > 0) then {
    _blockiert = true;
  };
};

if (_blockiert) exitWith {
  garage setVariable ["in_arbeit", false];
};

_veh = createVehicle [_typ, [0,0,0], [], 0, "CAN_COLLIDE"];
_veh setPosATL getPosATL garage;
_veh setDir getDir garage;


if (_typ IN ["UK3CB_BAF_LandRover_Panama_Sand_A_MTP", "B_UAV_02_dynamicLoadout_F"]) then {
  createVehicleCrew _veh;
};

if (_typ IN ["rhsusf_stryker_m1126_m2_d","rhsusf_stryker_m1126_mk19_d","rhsusf_stryker_m1127_m2_d","rhsusf_stryker_m1132_m2_np_d","rhsusf_stryker_m1132_m2_d","rhsusf_stryker_m1134_d"]) then {
  [_veh, "tan"] call BIS_fnc_initVehicle;
};


(Fahrzeuge_Temp select (_value - 1)) set [2, (getPosATL garage)];
(Fahrzeuge_Temp select (_value - 1)) set [4, _veh];
(Fahrzeuge_Temp select (_value - 1)) set [5, _name];
(Fahrzeuge_Temp select (_value - 1)) set [6, ("getTimeStamp" call _inidbi)];
publicvariable "Fahrzeuge_Temp";
(Fahrzeuge select (_value - 1)) set [2, (getPosATL garage)];
(Fahrzeuge select (_value - 1)) set [4, _name];
(Fahrzeuge select (_value - 1)) set [5, ("getTimeStamp" call _inidbi)];

["write", ["Fuhrpark", "Fahrzeuge", Fahrzeuge]] call _inidbi;

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

_cargo params ["_weps", "_mags", "_items", "_containers"];
if !(_weps isEqualTo []) then {
  for "_i" from 0 to (count _weps)-1 do {
    _veh addWeaponWithAttachmentsCargoGlobal  [_weps select _i, 1];
  };
};
if !(_mags isEqualTo []) then {
  for "_i" from 0 to (count (_mags select 0))-1 do {
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
          (_weparray select _j) params ["_weaponClass", "_suppressor", "_laser", "_optics", "_magazine", "_bipod"];
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

_veh lock _locked;

private _pitchbankyaw_new = [_veh] call ace_common_fnc_getPitchBankYaw;
private _newpos = getPosATL _veh;
["write", ["Fuhrpark", format ["fzg_%1", _id],
  [_id, true, _newpos, _typ, "obj", _dmg, _ammo, _fuel, _san, _rep, _cargo, _refueler, _ammotruck, _pitchbankyaw_new]
]] call _inidbi;
//Schliesse Tore der Halle
/*
garage setVariable ["bis_disabled_door_3", 0, true];
garage setVariable ["bis_disabled_door_4", 0, true];
[garage, 3, 1] call BIS_fnc_Door;
[garage, 4, 1] call BIS_fnc_Door;
*/

garage setVariable ["in_arbeit", false];
