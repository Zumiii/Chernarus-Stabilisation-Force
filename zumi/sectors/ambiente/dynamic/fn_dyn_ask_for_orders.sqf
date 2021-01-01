/*

  Die Einheit erhält neue Befehle, abhängig davon, was sie ist

*/


params [["_positions", []], ["_grpID", grpNull], ["_veh", []], ["_element", []], ["_befehl", []], ["_active", false]];
_element params [["_fzg", []], ["_side", "east"], ["_fullcrew", []], ["_markertype", []], ["_markercolor", []], ["_art", []]];


//Process Unit, assign order

_befehl params ["_neuziel", "_alter_befehl"];

private _order = if (_neuziel isEqualTo [0,0,0]) then {
  _alter_befehl params [["_do_until", cba_missionTime], ["_waypointscript", ""]];

  //If the order is old, give a new one
  _temp_order = if (_do_until <= cba_missionTime) then {
    switch _art do {
      case "miliz" : {
        //MOVE, PATROL, can garrison, dountil
        selectRandom [[selectRandom [600, 1200, 1800], "PATROL"], [selectRandom [900, 1800, 2400], "GARRISON"], [0, ""], [selectRandom [900, 1800, 2400], "DEFEND"], [selectRandom [300,600], "SAD"]]
      };
      case "tak" : {
        //MOVE, PATROL, can garrison, dountil
        selectRandom [[selectRandom [600, 1200, 1800], "PATROL"], [selectRandom [900, 1800, 2400], "GARRISON"], [0, ""], [selectRandom [900, 1800, 2400], "DEFEND"], [selectRandom [300,600], "SAD"]]
      };
      case "pol" : {
        //MOVE, PATROL, No garrison, dountil
        selectRandom [[selectRandom [300, 900, 1200], "PATROL"], [0, ""], [selectRandom [300, 900, 1200], "DEFEND"]]
      };
      case "mil" : {
        selectRandom [[selectRandom [600, 1200, 1800], "PATROL"], [0, ""], [selectRandom [900, 1800, 2400], "DEFEND"]]
      };
      default {
        //Move, no script, no garrison, no "do until"
        [0, ""]
      };
    };
  } else {
    [_do_until, _waypointscript];
  };
  [cba_missionTime + (_temp_order select 0), _temp_order select 1]

} else {
  _temp_order = switch _art do {
    case "miliz" : {
      //MOVE, PATROL, can garrison, dountil
      selectRandom [[selectRandom [600, 1200, 1800], "PATROL"], [selectRandom [900, 1800, 2400], "GARRISON"], [0, ""], [selectRandom [900, 1800, 2400], "DEFEND"], [selectRandom [300,600], "SAD"]]
    };
    case "tak" : {
      //MOVE, PATROL, can garrison, dountil
      selectRandom [[selectRandom [600, 1200, 1800], "PATROL"], [selectRandom [900, 1800, 2400], "GARRISON"], [0, ""], [selectRandom [900, 1800, 2400], "DEFEND"], [selectRandom [300,600], "SAD"]]
    };
    case "pol" : {
      //MOVE, PATROL, No garrison, dountil
      selectRandom [[selectRandom [300, 900, 1200], "PATROL"], [0, ""], [selectRandom [300, 900, 1200], "DEFEND"]]
    };
    case "mil" : {
      selectRandom [[selectRandom [600, 1200, 1800], "PATROL"], [0, ""], [selectRandom [900, 1800, 2400], "DEFEND"]]
    };
    default {
      //Move, no script, no garrison, no "do until"
      [0, ""]
    };
  };
  [cba_missionTime + (_temp_order select 0), _temp_order select 1]
};



if !(_active) exitWith {

  [(_positions call BIS_fnc_SelectRandom), _order];

};


//Set Orders if active
if (!(isNull _grpID)) then {
  _grpID setVariable ["has_orders", _order select 0, true];
};


_return = if (_art IN ["tak", "miliz", "mil"]) then {
  private _optionen = if (count zumi_stellungen > 0) then {zumi_stellungen select {alive (_x select 0)}} else {[]};
  _temp = if (count _optionen > 0) then {
    private _weights = [];
    private _destinations = [];
    {
      _weights pushBack (_x select 4);
      _destinations pushBack (_x select 5);
    } forEach _optionen;
    private _destination = [_destinations selectRandomWeighted _weights, _order];
    if (!(isNull _grpID)) then {
      private _index = _optionen findif {(_x select 5) isEqualTo (_destination select 0)};
      private _intelfrom  = _optionen select _index;
      _intelfrom params ["_structure", "_pos_and_dir", "_marker", "_desc", "_importance", "_offsetPos", "_revealed"];
      private _inteldetails = [_pos_and_dir select 0, _desc, _marker, "ColorEast"];
      (leader _grpID) setVariable ["intel", [["Enemy patrol orders", format ["That patrol has been ordered to guard %1 in map grid %2. It is now marked on the map.", _desc, mapGridPosition (_pos_and_dir select 0)],""], _inteldetails, true, [configFile >> "CfgVehicles" >> (typeOf _structure) >> "Editorpreview", "STRING", "a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa"] call CBA_fnc_getConfigEntry, west, [west], _index]];
    };
    _destination;
  } else {
    [(_positions call BIS_fnc_SelectRandom), _order];
  };
  _temp;
} else {
  [(_positions call BIS_fnc_SelectRandom), _order];
};

_return;
