/*
  Diese Funktion sorgt für Begegnungen jeglicher Art unterwegs
*/
if !isServer exitWith {};



params ["_positions","_dynarray"];


for "_i" from 0 to (count _dynarray)-1 do {
  (_dynarray select _i) params ["_id","_aktiv","_posi","_ziel","_element","_grpID","_veh",["_befehl", []]];
  _element params ["_fzg","_side","_fullcrew","_markertype","_markercolor","_art"];
  if (_aktiv) then {
    (_dynarray select _i) set [2, position (leader _grpID)];
    if (count ([_posi, 2100, [west,civilian,east,resistance], ["CAManBase","LandVehicle","Helicopter"]] call zumi_fnc_nahe_spieler) == 0) then {
      _grpID call CBA_fnc_deleteEntity;
      _veh call CBA_fnc_deleteEntity;
      (_dynarray select _i) set [1, false];
      (_dynarray select _i) set [5, grpNull];
      (_dynarray select _i) set [6, []];
      patcounter = patcounter -1;
    } else {
      if ({alive _x} count (units _grpID) <= 0) then {
        (_dynarray select _i) set [1, false];
        (_dynarray select _i) set [5, grpNull];
        (_dynarray select _i) set [6, []];
        (_dynarray select _i) set [2, (_positions call BIS_fnc_SelectRandom)];
        _return = [_positions, grpNull, [], _element, [[0,0,0],[0, ""]], false] call zumi_fnc_dyn_ask_for_orders;
        _return params ["_neuziel", "_order"];
        (_dynarray select _i) set [7, _return];
        (_dynarray select _i) set [3, _neuziel];
        patcounter = patcounter -1;
      };
      //TODO Hasorders
      if ((_posi distance2d _ziel <= 25) && (((_befehl select 1) select 0) <= cba_missionTime)) then {
        _return = [_positions, _grpID, _veh, _element, _befehl, _aktiv] call zumi_fnc_dyn_ask_for_orders;
        _return params ["_neuziel", "_order"];
        [_grpID, _neuziel, _art, _order] call zumi_fnc_dyn_wegpunkt;
        (_dynarray select _i) set [7, _return];
        (_dynarray select _i) set [3, _neuziel];
      };
    };
  } else {
    if (count ([_posi, 1900, [west], ["CAManBase","LandVehicle","Helicopter"]] call zumi_fnc_nahe_spieler) >= 1 &&
      (_posi distance2d (getmarkerPos "respawn_west") > 1000) && (count ([_posi, 1600, [west,civilian,east,resistance],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) == 0)
    ) then {
      if ((patcounter <= max_spawns) && !((_posi isFlatEmpty [12, -1, 0.35, 3]) isEqualto []) && ({(_posi distance2d (_x select 2)) < 25} count (_dynarray select {!((_x select 2) isEqualTo _posi)}) < 1)) then {
        (_dynarray select _i) set [1, true];
        _spwn = [_posi, _ziel, _fzg, _side, _fullcrew, _art, _befehl] call zumi_fnc_dyn_spawn;
        [(_spwn select 0), _ziel, _art, _befehl] remoteExecCall ["zumi_fnc_dyn_wegpunkt", (_spwn select 0)];
        (_dynarray select _i) set [5, (_spwn select 0)];
        (_dynarray select _i) set [6, (_spwn select 1)];
        patcounter = patcounter + 1;
      } else {
        _posineu = [_posi, _ziel, _art, _fzg] call zumi_fnc_dyn_posupdate;
        (_dynarray select _i) set [2, _posineu];
        //TODO
        if ((_posi distance2d _ziel <= 25) && (((_befehl select 1) select 0) <= cba_missionTime)) then {
          _return = [_positions, _grpID, _veh, _element, _befehl, _aktiv] call zumi_fnc_dyn_ask_for_orders;
          _return params ["_neuziel", "_order"];
          (_dynarray select _i) set [3, _neuziel];
          (_dynarray select _i) set [7, _return];
        };
      };
    } else {
      _posineu = [_posi, _ziel, _art, _fzg] call zumi_fnc_dyn_posupdate;
      (_dynarray select _i) set [2, _posineu];
      if (_posi distance2d _ziel <= 25) then {
         if (((_befehl select 1) select 0) <= cba_missionTime) then {
           _return = [_positions, _grpID, _veh, _element, _befehl, _aktiv] call zumi_fnc_dyn_ask_for_orders;
           _return params ["_neuziel", "_order"];
           (_dynarray select _i) set [3, _neuziel];
           (_dynarray select _i) set [7, _return];
         };
      };
    };
  };
  if (debug) then {
    format ["dyn_entity%1", _id] setMarkerPosLocal _posi;
  };
  dyn_array set [_i, (_dynarray select _i)];
};


[
  {
    params ["_positions","_dynarray"];
    [_positions, _dynarray] call zumi_fnc_dyn_loop;
  },
  [_positions, dyn_array],
  8
] call CBA_fnc_waitAndExecute;
