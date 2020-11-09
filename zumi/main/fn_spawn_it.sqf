

if !isServer exitWith {};

private ["_position","_pos","_dir","_array","_naheobjekte","_posATL","_obj","_vectorup","_spez","_spezial","_return"];

params ["_position","_dir","_array","_vectorUp",["_spez", false]];

_vehicles = [];
_units = [];
_objects = [];

_objekte = _array select 0;
_fahrzeuge = _array select 1;
_einheiten = _array select 2;
_spezial = _array select 3;

If (_position isEqualTo []) exitWith {[_units, _vehicles, _objects]};

_pos = ATLToASL _position;
_posATL = ASLToATL _pos;
{
    _obj = _x select 0;
    _objoffset = _x select 1;
    _pitch = _x select 2;
    _bank = _x select 3;
    _yaw = _x select 4;
    _objoffset params ["_d_x", "_d_y", "_d_z"];
    _newpos = [_objoffset, _vectorUp,  -1 * _dir] call CBA_fnc_vectRotate3D;
    //_newpos = [_objoffset, _vectorUp,  _dir] call CBA_fnc_vectRotate3D;
    _newpos = _pos vectorAdd _newpos;

    _terNorm = _vectorup;
    _newpos = ASLToATL _newpos;
    //_newpos set [2, ((_newpos select 2) - abs _d_z)]; //Try

    private _yaw = _yaw + _dir;
    private _bank = ((_terNorm select 0) atan2 (_terNorm select 2)) + _bank;
    private _pitch = ((_terNorm select 1) atan2 (_terNorm select 2)) + _pitch;


    private ["_vehicle"];
    _vehicle = createVehicle [_obj, [0,0,0], [], 0, "CAN_COLLIDE"];
    _vehicle setPosATL _newpos;
    //_vehicle setVectorUp _vectorUp;
    [_vehicle, _pitch, _bank, _yaw] call ace_common_fnc_setPitchBankYaw;

    //[_vehicle, [_yaw, _pitch, _bank]] call BIS_fnc_setobjectrotation;
    _vehicle setVectorUp _vectorUp;
    //_vehicle modelToWorld getPos _vehicle;
    _objects pushBack _vehicle;
} forEach _objekte;

if !(_fahrzeuge isEqualTo []) then {
 {
    _obj = _x select 0;
    _objoffset = _x select 1;
    _pitch = _x select 2;
    _bank = _x select 3;
    _yaw = _x select 4;
    _objoffset params ["_d_x", "_d_y", "_d_z"];
    _newpos = [_objoffset, _vectorUp,  -1 * _dir] call CBA_fnc_vectRotate3D;
    //_newpos = [_objoffset, _vectorUp,  _dir] call CBA_fnc_vectRotate3D;
    _newpos = _pos vectorAdd _newpos;

    _terNorm = _vectorup;
    _newpos = ASLToATL _newpos;
    //_newpos set [2, ((_newpos select 2) - abs _d_z)]; //Try

    private _yaw = _yaw + _dir;
    private _bank = ((_terNorm select 0) atan2 (_terNorm select 2)) + _bank;
    private _pitch = ((_terNorm select 1) atan2 (_terNorm select 2)) + _pitch;

    private ["_fahrzeug"];
    _fahrzeug = createVehicle [_obj, [0,0,0], [], 0, "CAN_COLLIDE"];
    _fahrzeug setPosATL _newpos;
    [_fahrzeug, _pitch, _bank, _yaw] call ace_common_fnc_setPitchBankYaw;
    _fahrzeug setVectorUp _vectorUp;
    if (typeOf _fahrzeug == "rhs_gaz66_r142_msv") then {[_fahrzeug, 1] spawn RHS_fnc_gaz66_radioDeploy;};
    _vehicles pushBack _fahrzeug;
    if (_fahrzeug isKindOf "StaticWeapon") then {
      _crewman = [configFile >> "CfgVehicles" >> (TypeOf _fahrzeug) >> "Crew", "String", "LOP_ChDKZ_Infantry_Crewman"] call CBA_fnc_getConfigEntry;
      _grp = createGroup east;
      _unit = _grp createUnit [_crewman, [0,0,0], [], 0, "CAN_COLLIDE"];
      _unit moveInGunner _fahrzeug;
      _units pushBack _grp;
    };
    if ((TypeOf _fahrzeug) IN ["LOP_ChDKZ_BM21","rhs_2b14_82mm_msv"]) then {
      _crewman = [configFile >> "CfgVehicles" >> (TypeOf _fahrzeug) >> "Crew", "String", "LOP_ChDKZ_Infantry_Crewman"] call CBA_fnc_getConfigEntry;
      _grp = createGroup east;
      _unit = _grp createUnit [_crewman, [0,0,0], [], 0, "CAN_COLLIDE"];
      _unit moveInGunner _fahrzeug;
      _units pushBack _grp;
      [_fahrzeug] call zumi_fnc_rohr_registrieren;
    };
    if ((_fahrzeug isKindOf "Car") || (_fahrzeug isKindOf "Tank")) then {
      _crewman = [configFile >> "CfgVehicles" >> (TypeOf _fahrzeug) >> "Crew", "String", "LOP_ChDKZ_Infantry_Crewman"] call CBA_fnc_getConfigEntry;
      _grp = createGroup east;
      private _gunner = _grp createUnit [_crewman, [0,0,0], [], 0, "CAN_COLLIDE"];
      private _commander = _grp createUnit ["LOP_ChDKZ_Infantry_Crewman", [0,0,0], [], 0, "CAN_COLLIDE"];
      _gunner moveInGunner _fahrzeug;
      _commander moveInCommander _fahrzeug;
      _units pushBack _grp;
    };
 } forEach _fahrzeuge;
};

if !(_einheiten isEqualTo []) then {
 _grp = createGroup east;
 {
    _obj = _x select 0;
    _objoffset = _x select 1;
    _pitch = _x select 2;
    _bank = _x select 3;
    _yaw = _x select 4;
    _unitpos = _x select 5;
    _objoffset params ["_d_x", "_d_y", "_d_z"];
    _newpos = [_objoffset, _vectorUp,  -1 * _dir] call CBA_fnc_vectRotate3D;
    //_newpos = [_objoffset, _vectorUp,  _dir] call CBA_fnc_vectRotate3D;
    _newpos = _pos vectorAdd _newpos;

    _terNorm = _vectorup;
    _newpos = ASLToATL _newpos;
    //_newpos set [2, ((_newpos select 2) - abs _d_z)]; //Try

    private _yaw = _yaw + _dir;
    private _bank = ((_terNorm select 0) atan2 (_terNorm select 2)) + _bank;
    private _pitch = ((_terNorm select 1) atan2 (_terNorm select 2)) + _pitch;

     private ["_unit"];
     _unit = _grp createUnit [_obj, [0,0,0], [], 0, "CAN_COLLIDE"];
     _unit setPosATL _newpos;
      if (_obj IN ["LOP_ChDKZ_Infantry_Commander"]) then {
        [_unit] call zumi_fnc_kommandant_registrieren;
      };


     //_unit disableAI "Move";
     doStop _unit;
     _unit setUnitPos _unitpos;
     [_unit, _pitch, _bank, _yaw] call ace_common_fnc_setPitchBankYaw;
     _unit setVectorUp _vectorUp;
 } forEach _einheiten;
  _units pushBack _grp;
};

{
  _x setVariable ["statisch", true];
} forEach _units;

[_units, _vehicles, _objects];
