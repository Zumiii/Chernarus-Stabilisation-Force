/*

  Script which spawns and handles enemy supply points around the main Area
  The main idea is, that the enemy can be weakened by destroying these structures before attacking their center
  Supply Points can be close to each other eventually

*/

params ["_taskcenter", "_polygon", ["_zumi_enemy_positions", []]];

if (count _zumi_enemy_positions > 0) exitWith {
  {
    _x params ["_class", "_pos_and_dir", "_marker", "_desc", "_importance", "_offsetPos", "_revealed"];
    _pos_and_dir params ["_pos", "_dir"];
    private _enemyposition = createVehicle [_class, [0,0,0], [], 0, "CAN_COLLIDE"];
    _enemyPosition setPosATL _pos;
    _enemyposition setDir _dir;
    _enemyPosition setVectorUp (surfaceNormal (position _enemyPosition));
    if (_revealed) then {
      private _jip_str = ["zumi_intel", [[_pos, _desc, _marker, "ColorEast"]]] call CBA_fnc_globalEventJIP;
      [_jip_str, _enemyposition] call CBA_fnc_removeGlobalEventJIP;
    };
    _x set [0, _enemyPosition];
    switch _desc do {
      case "an antenna" : {
        zumi_funknetz pushBack _antenna;
      };
      case "a mobile headquarter" : {
        zumi_funknetz pushBack _antenna;
      };
    };
  } forEach _zumi_enemy_positions;
};

/*

  Spawn HQs (Part of RadioNet: Lets enemy coordinate and reinforce faster)
  - Considered "very important" by the commanders

*/


//One in Main Zone

private _pos = [_taskcenter, 150, 1, 1, 75, 8, 0.25, true, false, false, false, false, _polygon] call zumi_fnc_rnd_pos;
if !(_pos isequalto []) then {
  private _antenna = createVehicle ["rhs_gaz66_r142_msv", [0,0,0], [], 0, "CAN_COLLIDE"];
  _antenna setPosATL _pos;
  _antenna setVectorUp surfaceNormal (position _antenna);
  private _dir = random 360;
  _antenna setDir _dir;
  if (typeOf _antenna == "rhs_gaz66_r142_msv") then {
    [_antenna, 1] spawn RHS_fnc_gaz66_radioDeploy;
  };
  zumi_stellungen pushBack [_antenna, [_pos, _dir], "loc_Transmitter", "an antenna", 0.75, ([_pos, 15] call CBA_fnc_randPos), false];
  zumi_funknetz pushBack _antenna;
  zumi_misc pushBack _antenna;

};


//Two elsewhere, can be far away

  private _periphery = [true, [500, 5000, _taskcenter], [_taskcenter]] call zumi_fnc_neue_posi;
  private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _antenna = createVehicle [selectRandom ["BRDM2_HQ_TK_GUE_unfolded_Base_EP1","BMP2_HQ_TK_unfolded_Base_EP1"], [0,0,0], [], 0, "CAN_COLLIDE"];
    _antenna setPosATL _pos;
    _antenna setVectorUp surfaceNormal (position _antenna);
    private _dir = random 360;
    _antenna setDir _dir;
    zumi_stellungen pushBack [_antenna, [_pos, _dir], "o_hq", "a mobile headquarter", 0.7, ([_pos, 15] call CBA_fnc_randPos), false];
    zumi_funknetz pushBack _antenna;
    zumi_misc pushBack _antenna;
  };



/*

  Spawn infantry barracks (Part of RadioNet: Works as Relay)
  - Considered "not so important" by the commanders

*/

//Not so far away, if possible

  private _periphery = [true, [500, 4000, _taskcenter], [_taskcenter]] call zumi_fnc_neue_posi;
  private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _barrack = createVehicle ["TK_GUE_WarfareBBarracks_Base_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
    _barrack setPosATL _pos;
    _barrack setVectorUp surfaceNormal (position _barrack);
    private _dir = random 360;
    _barrack setDir _dir;
    zumi_stellungen pushBack [_barrack, [_pos, _dir], "o_installation", "some barracks", 0.4, ([_pos, 20] call CBA_fnc_randPos), false];
    zumi_misc pushBack _barrack;
  };

/*

  Spawn tank factories
  - Considered "important" by the commanders

*/


  private _periphery = [true, [500, 5000, _taskcenter], [_taskcenter]] call zumi_fnc_neue_posi;
  private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _tank_factory = createVehicle ["TK_WarfareBHeavyFactory_Base_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
    _tank_factory setPosATL _pos;
    _tank_factory setVectorUp surfaceNormal (position _tank_factory);
    private _dir = random 360;
    _tank_factory setDir _dir;
    zumi_stellungen pushBack [_tank_factory, [_pos, _dir], "o_installation", "a tank service depot", 0.6, ([_pos, 20] call CBA_fnc_randPos), false];
    zumi_misc pushBack _tank_factory;
  };





/*

  Spawn air factories
  - Considered "important" by the commanders

*/

//One elsewhere, can be very far away

private _periphery = [true, [500, 6000, _taskcenter], [_taskcenter]] call zumi_fnc_neue_posi;
private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
if !(_pos isequalto []) then {
  private _air_factory = createVehicle ["TK_WarfareBHeavyFactory_Base_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
  _air_factory setPosATL _pos;
  _air_factory setVectorUp surfaceNormal (position _air_factory);
  private _dir = random 360;
  _air_factory setDir _dir;
  zumi_stellungen pushBack [_air_factory, [_pos, _dir], "o_maint", "an air service depot", 0.65, ([_pos, 20] call CBA_fnc_randPos), false];
  zumi_misc pushBack _air_factory;
};


/*

  Spawn resupply points for motorized infantry
  - Considered "important" by the commanders

*/

//can be far away

  private _periphery = [true, [500, 5000, _taskcenter], [_taskcenter]] call zumi_fnc_neue_posi;
  private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
  if !(_pos isequalto []) then {
    private _vehicle_depot = createVehicle [selectRandom ["TK_WarfareBVehicleServicePoint_Base_EP1","TK_GUE_WarfareBVehicleServicePoint_Base_EP1"], [0,0,0], [], 0, "CAN_COLLIDE"];
    _vehicle_depot setPosATL _pos;
    _vehicle_depot setVectorUp surfaceNormal (position _vehicle_depot);
    private _dir = random 360;
    _vehicle_depot setDir _dir;
    zumi_stellungen pushBack [_vehicle_depot, [_pos, _dir], "o_support", "a vehicle supply depot", 0.6, ([_pos, 20] call CBA_fnc_randPos), false];
    zumi_misc pushBack _vehicle_depot;
  };


/*

  Spawn Air Radar (Friendly Air Assets are caught by this)
  - Considered "important" by the commanders

*/

//One somewhere
private _periphery = [true, [500, 7000, _taskcenter], [_taskcenter]] call zumi_fnc_neue_posi;
private _pos = [_periphery select 0, 500, 1, 1, 75, 8, 0.25, true, false, false, false, false] call zumi_fnc_rnd_pos;
if !(_pos isequalto []) then {
  private _air_radar = createVehicle ["TK_WarfareBAntiAirRadar_Base_EP1", [0,0,0], [], 0, "CAN_COLLIDE"];
  _air_radar setPosATL _pos;
  _air_radar setVectorUp surfaceNormal (position _air_radar);
  private _dir = random 360;
  _air_radar setDir _dir;
  zumi_stellungen pushBack [_air_radar, [_pos, _dir], "o_uav", "an air radar", 0.6, ([_pos, 20] call CBA_fnc_randPos), false];
  zumi_misc pushBack _air_radar;
};
