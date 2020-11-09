if (!hasInterface) exitWith {};

params ["_spielerinfo", ["_befragt", 2]];

"ladebildschirm" cutFadeOut 10;

if ((count _spielerinfo) < 1) exitWith {};

_spielerinfo params ["_loadout","_medical","_rechte","_pos","_timestamp", "_name", ["_insignia", ""], ["_vehicle", [-1, ""]]];
_vehicle params ["_veh","_role", "_turretindex"];
_medical params ["_isDeadPlayer","_isUnconscious", ["_durst", 0], ["_appetit", 0]];
_rechte params ["_arzt", "_pio", "_eod", ["_pilot", 0], ["_pzbes", 0], ["_logistiker", 0], ["_keys", []], ["_waka", 0]];


private _player = player;


_player setVariable ["ace_medical_medicClass", _arzt, true];
_player setVariable ["ACE_IsEngineer", _pio, true];
_player setVariable ["ACE_isEOD", _eod, true];
_player setVariable ["323_pilot", _pilot, true];
_player setVariable ["323_panzer", _pzbes, true];
_player setVariable ["323_logistiker", _logistiker, true];
_player setVariable ["323_keys", _keys, true];
_player setVariable ["323_waka", _waka, true];
_player setVariable ["acex_field_rations_thirst", _durst, true];
_player setVariable ["acex_field_rations_hunger", _appetit, true];

/*
if (_befragt < 1) exitWith {
  spielerinfo = _spielerinfo;
  [
    {
      createDialog "jip_dialog";
    },
    [],
    5
  ] call CBA_fnc_waitAndExecute;
};
*/

_timestamp params [["_restart", restart_nummer], ["_time", cba_missiontime]];




_player setUnitLoadout [_loadout, false];

{
  if ((_x isEqualto "ACE_key_customKeyMagazine") || (_x isEqualto "ACE_key_master") || (_x IN ["acex_intelitems_notepad","acex_intelitems_document","acex_intelitems_photo"])) then {
    [_player, _x] call CBA_fnc_removeItem;
  };
} forEach (magazines _player);

{
  if ((_x isEqualto "ACE_key_customKeyMagazine")|| (_x isEqualto "ACE_key_master")) then {
    [_player, _x] call CBA_fnc_removeItem;
  };
} forEach (items _player);

if (!("ACE_EarPlugs" in (items _player))) then {
  [_player, "ACE_EarPlugs"] call CBA_fnc_addItem;
};


if (_isUnconscious) then {
  [_player, true] call ace_medical_fnc_setUnconscious;
};



if (_befragt > 1) then {
  //Der Spieler darf, wenn er einen Disconnect in den letzten 10 Minuten hatte, an Ort und Stelle sein
  if ((_restart < restart_nummer) && ((_player distance2d zumi_taskpos) < 1000)) then {
    hint "You were to close to the AO and spawn in Base therefor";
  } else {
    if ((cba_missiontime > (_time + 600)) && ((_player distance2d zumi_taskpos) < 1000)) then {
      hint "You were to close to the AO and disconnected for ten minutes, you spawned in Base therefor";
    } else {
      _player setPosATL _pos;
    };
  };
};


switch (typeOf _player) do {
  case "B_Pilot_F" : {
    if (_player getVariable ["323_pilot", 0] < 1) then {
      ["You are not authorized to use this slot!!", false, 2, false] call BIS_fnc_endMission;
    };
  };

  case "B_officer_F" : {
    if ((_player getVariable ["323_logistiker", 0]) < 1) then {
      ["You are not authorized to use this slot!", false, 2, false] call BIS_fnc_endMission;
    };
  };
  default {};
};

[
  {
    params ["_p", "_ins"];
    [_p, _ins] call BIS_fnc_setUnitInsignia;
  },
  [_player, _insignia],
  1
] call CBA_fnc_waitAndExecute;

if (_veh >= 0) then {
  if (alive ((fahrzeuge_temp select (_veh - 1)) select 4)) then {
    private _index = if (_turretindex isEqualTo []) then {
      -1
    } else {
      _turretindex
    };
    [_player, ((fahrzeuge_temp select (_veh - 1)) select 4), _role, _index] call ace_common_fnc_getInPosition;
  };
};

if (_logistiker > 0) exitWith {
  [_player, "ACE_key_master"] call CBA_fnc_addItem;
};

for "_i" from 0 to (count fahrzeuge_temp) - 1 do {
  (Fahrzeuge_Temp select _i) params ["_id","_aktiv","_status","_typ","_objekt", "_name", "_datum"];
  if (((_id-1) IN _keys) && (!isNull _objekt)) then {
    [_player, _objekt, true] call ACE_VehicleLock_fnc_addKeyForVehicle;
  };
};
