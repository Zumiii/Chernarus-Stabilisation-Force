if !isServer exitWith {};

params ["_villages"];

for "_i" from 0 to (count _villages) - 1 do {
  (_villages select _i) params ["_id","_active","_pos","_situation","_indicator","_groups","_objects","_decoratives","_name","_rad","_polygon","_housepositions","_chiefshouse","_task","_timestamp", ["_intel", []]];
  _situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];
  //Check if active
  if (_active) then {
    //If mo one nearby, cleanup everything
    if (count ([_pos, (4 * _rad) + 300, [west, civilian, east, resistance], ["CAManBase","LandVehicle","Helicopter"]] call zumi_fnc_nahe_spieler) < 1) then {
      _groups call CBA_fnc_deleteEntity;
      (_objects select {!isPlayer _x}) call CBA_fnc_deleteEntity;
      (villages select _i) set [5, []];
      (villages select _i) set [6, []];
      (villages select _i) set [1, false];
      (commy_sectors select _i) setVariable ["active", false, true];
    };

  } else {

    //If someone nearby, activate
    if (count ([_pos, (4 * _rad), [west, civilian, east, resistance], ["CAManBase","LandVehicle","Helicopter"]] call zumi_fnc_nahe_spieler) > 0) then {
      (villages select _i) set [14, timestamp];
      (villages select _i) set [1, true];
      (villages select _i) set [4, cba_missiontime];
      (commy_sectors select _i) setVariable ["active", true, true];
      //Spawn Civilians and Combattants
      private _groups = [_pos, _housepositions, _chiefshouse, _pos, _rad, _tension, _id, _decoratives, _task] call zumi_fnc_citizens;
      private _allgroups = [_pos, _housepositions, _groups, _situation, _id, _decoratives] call zumi_fnc_combattants;
      (villages select _i) set [5, _allgroups];

      //Spawn decoratives (Cars and stuff)
      private _objects = [_decoratives, _id] call zumi_fnc_decorate;
      (villages select _i) set [6, _objects];
      //Spawn Ieds
      if (_ied) then {
        _ied_grps = [_pos, _tension, _objects, _id, _rad] call zumi_fnc_village_ied;
        (villages select _i) set [5, _allgroups + _ied_grps];
      };

    };
  };

};


[
  {
    params ["_villages"];
    [_villages] call zumi_fnc_villages_loop;
  },
  [villages],
  6
] call CBA_fnc_waitAndExecute;
