if !isServer exitWith {};

params ["_pos", "_housepositions", "_grps", "_situation", "_id", "_decoratives"];
_situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];


//Find civs that are uncooperative and make them potentially hostile

{
  private _unit = (leader _x);
  private _renitenz = _unit getVariable ["renitenz", 0];
  if (_renitenz >= 3) then {
    private _oldGrp = group _unit;
    private _grp = createGroup east;
    [_unit] joinSilent _grp;
    _unit disableAI "AUTOCOMBAT";
    _unit allowfleeing 0;
    _jip_str = ["ace_common_setCaptive", [_unit, 1]] call CBA_fnc_globalEventJIP;
    [_jip_str, _unit] call CBA_fnc_removeGlobalEventJIP;
    _grps deleteAt (_grps find _oldgrp);
    _grps pushBack _grp;
    private _house = _unit getVariable ["house", objNull];
    //private _inteldetails = (villages select _id) select 15;
    private _inteldetails = [getPosATL _house, "Discovered weapons cache", "hd_warning"];
    private _stashes = [
      [["rhs_weap_ak74","rhs_acc_dtk1983","","",["rhs_30Rnd_545x39_7N6M_AK",30],[],""], [["rhs_30Rnd_545x39_7N6M_AK", 2]], [["rhs_mag_rgd5", 1]]],
      [[], [["DemoCharge_Remote_Ammo", 1]], [], "B_Messenger_Coyote_F"],
      [["rhs_weap_makarov_pm","","","",["rhs_mag_9x18_8_57N181S",8],[],""], [["rhs_mag_9x18_8_57N181S", 4]], [], ""],
      [["rhs_weap_savz61_folded","","","",["rhsgref_20rnd_765x17_vz61",20],[],""], [["rhsgref_20rnd_765x17_vz61", 2]], [["rhs_mag_rgd5", 1]], ""],
      [["rhs_weap_rpg7","","","",["rhs_rpg7_PG7VL_mag",1],[],""], [["rhs_rpg7_PG7VL_mag",1]], [], "B_Messenger_Coyote_F"]
    ];
    _house setVariable ["hiddenweapons", selectRandom _stashes, true];
    _house setVariable ["intel", [["Weapon stash", format ["AK-74, magazines and a grenade were found hidden inside a house in %1", (villages select _id) select 8],""], _inteldetails, true, getText (configfile >> "CfgWeapons" >> "rhs_weap_ak74" >> "picture"), west, [west, civilian]], true];
    _unit setVariable ["combattant", true];
    [_unit] call CBA_fnc_clearWaypoints;
    private _spawnpos = _unit getVariable ["spawn_pos", getPosATL _unit];
    if (_unit getVariable ["athome", false]) then {
      [_unit, _spawnpos, 0, "HOLD", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
    } else {
      [_unit, _spawnpos, 0, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "", [45, 60, 90]] call CBA_fnc_addWaypoint;
      {
        _x params ["_pos","_dir","_class"];
        [_unit, _pos getPos [2 + (floor (random 20)), _dir] , 0, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "count ([this call CBA_fnc_getPos, 150, east, 2] call zumi_fnc_meldungen) >= 1", "this call zumi_fnc_rearm", [5, 15, 25]] call zumi_fnc_addWaypoint;
      } forEach ([_decoratives, 2] call CBA_fnc_selectRandomArray);
      [_unit, _spawnpos, 0, "CYCLE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "count ([this call CBA_fnc_getPos, 50, east, 2] call zumi_fnc_meldungen) >= 1", "this call zumi_fnc_rearm"] call zumi_fnc_addWaypoint;
    };
  };


} forEach (_grps select {((leader _x) getVariable ["story", 1]) != 10});

if ((random (linearconversion [0, 100, _tension, 0, 1, true])) < 0.5) exitWith {
  _grps;
};

private _grp = createGroup east;
private _unit = _grp createUnit ["LOP_CHR_Civ_Random", [0,0,0], [], 0, "CAN_COLLIDE"];
private _hpos = (selectrandom _housepositions) getPos [0, 0.5];
_unit setPosATL _hpos;
_unit setDir (random 360);
_unit setVariable ["spawn_pos", _hpos, true];
[_unit, getPosATL _unit, 0] call zumi_fnc_c4_vest;
_grps pushBack _grp;

_grps;
