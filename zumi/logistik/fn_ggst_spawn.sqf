/*

  Diese Funktion spawnt sämtliche persistenten Behälter / Dinge, welche über die reguläre Logistik gespawnt wurden.

*/

if !isServer exitWith {};

params ["_ggst"];

private _inidbi = ["new", "us"] call OO_INIDBI;


_ggst params ["_nr", "_klasse", "_posatl", "_pby", "_san", "_rep", "_cargo" ,["_refueler",-1], ["_ammotruck",0], ["_verladen", 0]];

if (_verladen < 0) exitWith {
  lagerbestand deleteAt (lagerbestand find [_nr]);
  ["deleteKey", ["Lager", format ["ggst_%1", _nr]]] call _inidbi;
  ["write", ["Lager", "Lagerbestand", lagerbestand]] call _inidbi;
};

_pby params ["_pitch","_bank","_yaw"];

private _objekt = createVehicle [_klasse, [0,0,0], [], 0, "CAN_COLLIDE"];
lagerbestand_Temp pushBack [_nr, _objekt];

if (_objekt isKindOf "StaticWeapon") then {
  _objekt enableWeaponDisassembly false;
};

//Entleere Objektinventar
if !(_cargo isEqualTo []) then {
  clearBackpackCargoGlobal _objekt;
  clearMagazineCargoGlobal _objekt;
  clearWeaponCargoGlobal _objekt;
  clearItemCargoGlobal _objekt;
};

//San, Rep, Cargo, Refueler, Ammo
_objekt setVariable ["ace_rearm_currentSupply", _ammotruck, true];
_objekt setVariable ["ace_medical_medicClass", _san, true];
_objekt setVariable ["ACE_isRepairVehicle", _rep, true];
_objekt setVariable ["ace_refuel_currentFuelCargo", _refueler, true];

//Objekt hat eine Kennnummer
_objekt setVariable ["nr", _nr];
_objekt setVariable ["kann_weg", false];

//Tragbar machen
_jip_str = ["zumi_ace_carry", [_objekt, true]] call CBA_fnc_globalEventJIP;
[_jip_str, _objekt] call CBA_fnc_removeGlobalEventJIP;

if (count _cargo > 0) then {
  _cargo params ["_weps", "_mags", "_items", "_containers"];
  if !(_weps isEqualTo []) then {
    for "_i" from 0 to (count _weps)-1 do {
      _objekt addWeaponWithAttachmentsCargoGlobal [_weps select _i, 1];
    };
  };
  if !(_mags isEqualTo []) then {
    for "_i" from 0 to (count _mags)-1 do {
      //_objekt addMagazineCargoGlobal [(_mags select 0) select _i, (_mags select 1) select _i];
      _objekt addMagazineAmmoCargo [(_mags select _i) select 0, 1, (_mags select _i) select 1];
    };
  };
  if !(_items isEqualTo [[],[]]) then {
    for "_i" from 0 to (count (_items select 0))-1 do {
      _objekt addItemCargoGlobal [(_items select 0) select _i, (_items select 1) select _i];
    };
  };
  if !(_containers isEqualTo []) then {
    for "_i" from 0 to (count _containers)-1 do {
      (_containers select _i) params ["_klasse", "_weparray", "_magarray", "_itemarray"];
      _objekt addBackpackCargoGlobal [_klasse, 1];
      if !(_weparray isEqualTo []) then {
        for "_j" from 0 to (count _weparray)-1 do {
          _bp = (((everyContainer _objekt) select _i) select 1);
          _bp addWeaponWithAttachmentsCargoGlobal  [(_weparray select _j), 1];
        };
      };
      if !(_magarray isEqualTo []) then {
        for "_j" from 0 to (count _magarray)-1 do {
          _bp = (((everyContainer _objekt) select _i) select 1);
          _bp addMagazineAmmoCargo [(_magarray select _j) select 0, 1, (_magarray select _j) select 1];
        };
      };
      if !(_itemarray isEqualTo []) then {
        for "_j" from 0 to (count _itemarray)-1 do {
          _bp = (((everyContainer _objekt) select _i) select 1);
          _bp addItemCargoGlobal [(_itemarray select _j), 1];
        };
      };
    };
  };
};
//Wurde das Objekt verladen in ein persistentes Fahrzeug? Wenn ja, verlade es.
if (_verladen > 0) then {
  (Fahrzeuge_Temp select (_verladen - 1)) params ["_id", "_aktiv", "_status", "_typ", "_obj", "_dmg", "_ammo", "_fuel", "_san", "_rep", "_cargo" ,["_refueler",-1], ["_ammotruck",0], "_pitch_bank_yaw", ["_locked", 0]];
  if (_locked > 0) then {
    ((Fahrzeuge_Temp select (_verladen - 1)) select 4) lock 0;
  };
  [_objekt, (Fahrzeuge_Temp select (_verladen - 1)) select 4, true] call ace_cargo_fnc_loadItem;
  _objekt setVariable ["verladen", _verladen];
  if (_locked > 0) then {
    ((Fahrzeuge_Temp select (_verladen - 1)) select 4) lock _locked;
  };
} else {
  [_objekt, _pitch, _bank, _yaw] call ace_common_fnc_setPitchBankYaw;
  _objekt setPosATL _posatl;
};
