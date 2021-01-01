params ["_pos", ["_type","ACE_IEDLandSmall_Range_Ammo"], ["_rad", 500], ["_triggerman",false], "_id"];

_grps = [];


private _position = [_pos, _rad, 1, 1, 2, 1, 0.45, false, true] call zumi_fnc_rnd_pos;
if !(_position isequalTo []) then {
  private _ied = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
  _ied setDir random 360;
  //_position = _position vectorAdd [0,0,-0.1];
  _ied setPosATL _position;
  east revealmine _ied;
  civilian revealmine _ied;
  _ied setVariable ["id", _id];
  zumi_ieds pushBack _ied;
  publicVariable "zumi_ieds";
  if (_triggerman) then {
    _grp = createGroup east;
    private _unit = _grp createUnit ["LOP_CHR_Civ_Random", [0,0,0], [], 0, "CAN_COLLIDE"];
    _grps pushBack _grp;
    _unit setPosATL [(_position select 0) + 5,(_position select 1),(_position select 2)];
    removeAllWeapons _unit;
    _unit setCaptive true;
    _unit disableAI "AUTOCOMBAT";
    _unit allowfleeing 0;
    {_unit removeWeapon _x} forEach (weapons _unit);
    {_unit removeMagazine _x} forEach (magazines _unit);
    removeVest _unit;
    removeHeadgear _unit;
    removeGoggles _unit;
    _unit addItemToUniform "ACE_Cellphone";
    _code = [_unit, _ied, _type] call zumi_fnc_assign_cellphone_to_ied;

    [_unit, _position, _ied] call zumi_fnc_watch_ied;
    //Triggerman handle
    [
     {
       params ["_args","_handle"];
       _args params ["_unit","_ied","_id"];
       if !((villages select _id) select 1) exitWith {
         [_handle] call CBA_fnc_removePerFrameHandler;
         [_unit, _ied] call CBA_fnc_deleteEntity;
       };
       if (!alive _ied || !("ACE_Cellphone" IN ((items _unit) + (assignedItems _unit)))) exitWith {
         [_unit] call CBA_fnc_clearWaypoints;
         [_handle] call CBA_fnc_removePerFrameHandler;
      };
      private _ziele = ([getPos _ied, 15, [west, civilian, resistance], ["CAManBase", "LandVehicle"]] call zumi_fnc_nahe_spieler) + ([getPos _unit, 15, [west, resistance], ["CAManBase", "LandVehicle"]] call zumi_fnc_nahe_ki);
      if (_ziele isEqualTo []) exitWith {};
  		if ({_unit knowsAbout _x >= 3.5} count _ziele > 0) then {
        [_unit, (_unit getVariable ["ied_code", 0000])] call zumi_fnc_call_ied;
        [_handle] call CBA_fnc_removePerFrameHandler;
        ((villages select _id) select 3) set [2, false];
      };
     },
     1,
     [_unit, _ied, _id]
    ] call CBA_fnc_addPerFrameHandler;
  };
};

_grps;
