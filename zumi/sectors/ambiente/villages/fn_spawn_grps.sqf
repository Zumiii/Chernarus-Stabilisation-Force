//if !isServer exitWith {};

params ["_sector"];

private _active = _sector getVariable ["active", false];
private _center = _sector getVariable ["center", [0,0,0]];
private _polygon = _sector getVariable ["polygon", [[0,0,0],[0,0,1],[0,1,0]]];
private _rad = _sector getVariable ["radius", 200];
private _name = _sector getVariable ["name", "Test"];
private _score = _sector getVariable ["score", -15];
private _id = _sector getVariable ["id", _i];
private _securityparams = _sector getVariable ["securityparams", [100, 100, true]];
private _indicator = _sector getVariable ["indicator", 0];
private _groups = _sector getVariable ["groups", []];
private _objects = _sector getVariable ["objects", []];
private _decoratives = _sector getVariable ["decoratives", []];
private _housepositions = _sector getVariable ["housepositions", []];
private _chiefshouse = _sector getVariable ["chiefshouse", [0,0,0]];
private _task = _sector getVariable ["task", -1];
private _timestamp = _sector getVariable ["timestamp", timestamp];
private _intel = _sector getVariable ["intel", []];
private _players_in_sector = _sector getVariable ["players_in_sector", []];

_securityparams params [["_tension", 50],["_humanitarian", 50],["_ied", false]];


_intel = ["Intel","Gather Information",["\A3\ui_f\data\igui\cfg\simpleTasks\types\listen_CA.paa", "##a6ff4d"],
  {
    params ["_t","_p","_actionparams"];
    if (_t getVariable ["greeted", false]) exitWith {};
    [_t, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
    [_p, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
    _t setVariable ["greeted", true];
  },{alive _target},{},[], [0,0,0], 2, [false, false, false, true, false]] call zumi_fnc_interaction_create;
_kontrolle = ["Kontrolle","Control",["\A3\ui_f\data\igui\cfg\simpleTasks\types\interact_CA.paa", "#ff9900"],{
  params ["_t","_p","_actionparams"];
  if (_t getVariable ["greeted", false]) exitWith {};
  [_t, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
  [_p, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
  _t setVariable ["greeted", true];
},{alive _target},{},[], [0,0,0], 2, [false, false, false, true, false]] call zumi_fnc_interaction_create;
_human = ["Humanitär","Humanitarian",["\A3\Data_F_Orange\Logos\arma3_orange_picture_ca.paa", "#0066ff"],{
  params ["_t","_p","_actionparams"];
  if (_t getVariable ["greeted", false]) exitWith {};
  [_t, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
  [_p, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
  _t setVariable ["greeted", true];
},{alive _target},{},[], [0,0,0], 2, [false, false, false, true, false]] call zumi_fnc_interaction_create;
_anweisung = ["Anweisung","Give order",["\A3\ui_f\data\igui\cfg\simpleTasks\types\talk_ca.paa", "#ff1a1a"],{
  params ["_t","_p","_actionparams"];
  if (_t getVariable ["greeted", false]) exitWith {};
  [_t, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
  [_p, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
  _t setVariable ["greeted", true];
},{alive _target},{},[], [0,0,0], 2, [false, false, false, true, false]] call zumi_fnc_interaction_create;


private _grps = [];

_security = linearConversion [10, 90, _tension, 0, 0.9, true];
_needs = linearConversion [10, 100, _humanitarian, 3, 12, true];
_civ_max_count = linearConversion [250, 350, _rad, 5, (count _housepositions), true];
_civ_min_count = linearConversion [250, 350, _rad, 2, (count _housepositions) / 2.5, true];


for "_i" from 0 to (floor (linearConversion [6, 2, {(_x select 1)} count villages, _civ_min_count, _civ_max_count, true])) - 1 do {
  private _grp = createGroup civilian;
	private _unit = _grp createUnit ["LOP_CHR_Civ_Random", [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit setPosATL (_housepositions select _i);
  _unit setDir (random 360);
  _unit setVariable ["spawn_pos", (_housepositions select _i), true];
  _grps pushBack _grp;
  _unit setVariable ["id", _id];
  _array = _unit call CBA_fnc_getNearestBuilding;
  _array params ["_building", "_buildingPositions"];
  _unit setVariable ["house", _building, true];
  _building setVariable ["owner", _unit, true];

  private _renitenz = switch (true) do {
    case (_security < 0.25) : {
      ([[0,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
    };
    case ((_security >= 0.25) && (_security < 0.75)) : {
      ([[0,1,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
    };
    case (_security >= 0.75) : {
      ([[0,0,1,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
    };
    default {
      ([[0,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
    };
  };
  _unit setVariable ["renitenz", _renitenz, true];

  if (round (random 1) <= _security) then {
    [_unit, (_housepositions select _i), 0, "HOLD", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
    _unit setVariable ["athome", true];
    for "_i" from 1 to 22 do	{
  		_building setVariable [format ["bis_disabled_door_%1", _i], 1, true];
  	};
  } else {
    [_unit, (_housepositions select _i), 0, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "", [45, 60, 90]] call CBA_fnc_addWaypoint;
    {
      _x params ["_pos","_dir","_class"];
      [_unit, _pos getPos [2 + (floor (random 20)), _dir] , 0, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", "", [5, 15, 25]] call CBA_fnc_addWaypoint;
    } forEach ([_decoratives, 2] call CBA_fnc_selectRandomArray);
    [_unit, (_housepositions select _i), 0, "CYCLE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
  };
  switch (floor random _needs) do {
    case 0 : {
      _unit setVariable ["bandage", 1, true];
    };
    case 1 : {
      _unit setVariable ["hunger", 1, true];
    };
    case 2 : {
      _unit setVariable ["durst", 1, true];
    };
    default {};
  };
  _unit setVariable ["story", floor (round random 10), true];
  //Erstelle Interaktionen für Zivis

  //Intel
  _jip_str = ["zumi_interaction_add_to_object", [_unit, _intel, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["chef_wo","Where can I find the chieftain?","\A3\ui_f\data\igui\cfg\simpleTasks\types\navigate_CA.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_frage"];
    ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
  },{alive _target && !((animationState _target) isEqualTo "ainvpercmstpsnonwnondnon")},{},[_id, "chef_wo"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Sichtungen","Have you seen armed men?","\z\ace\addons\nametags\UI\icon_position_ffv.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_frage"];
    ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
  },{alive _target},{},[_id, "bewaffnete_wo"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["bomben_wo","Are you aware of explosives in the area?","\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_CA.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_frage"];
    ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
  },{alive _target},{},[_id, "bomben_wo"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  //Kontrolle
  _jip_str = ["zumi_interaction_add_to_object", [_unit, _kontrolle, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Effekten","Show me what you are carrying with you!","\A3\ui_f\data\igui\cfg\simpleTasks\types\search_CA.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_handlung"];
    ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
  },{alive _target && !((animationState _target) isEqualTo "ainvpercmstpsnonwnondnon")},{},[_id, "effekten"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Ausweiskontrolle","Papers, please!","\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_CA.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_handlung"];
    ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
  },{alive _target},{},[_id, "pass"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Wohin","What are you up to?","\A3\ui_f\data\igui\cfg\simpleTasks\types\walk_CA.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_handlung"];
    ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
  },{alive _target},{},[_id, "woduwolle"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Haus_Zeigen","May I enter your house?","\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_handlung"];
    ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
  },{alive _target},{},[_id, "woduwohne"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  //Humanitär

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _human, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Wasser","Give water bottle","\z\acex\addons\field_rations\ui\item_waterbottle_full_co.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_item"];
    ["zumi_item_erhalten", [_t, _p, _id, _item], _t] call CBA_fnc_targetEvent;
  },{alive _target && (_target getVariable ["durst", 0] > 0)},{},[_id, "ACE_WaterBottle"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Essen","Give MRE","\z\acex\addons\field_rations\ui\item_mre_human_co.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_item"];
    ["zumi_item_erhalten", [_t, _p, _id, _item], _t] call CBA_fnc_targetEvent;
  },{alive _target && (_target getVariable ["hunger", 0] > 0)},{},[_id, "ACE_Humanitarian_Ration"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Bandage","Give a packing bandage","\z\ace\addons\medical_treatment\ui\packingBandage_ca.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_item"];
    ["zumi_item_erhalten", [_t, _p, _id, _item], _t] call CBA_fnc_targetEvent;
  },{alive _target && (_target getVariable ["bandage", 0] > 0)},{},[_id, "ACE_packingBandage"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  //Anweisungen
  _jip_str = ["zumi_interaction_add_to_object", [_unit, _anweisung, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Kopf_runter","Keep your head down!","\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_anweisung"];
    ["zumi_anweisen", [_t, _p, _id, _anweisung], _t] call CBA_fnc_targetEvent;
  },{alive _target && !(_target getVariable ["in_deckung", 0] > 0)},{},[_id, "kopf_runter"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Anweisung"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["In_deckung","Find cover within a building!","\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_anweisung"];
    ["zumi_anweisen", [_t, _p, _id, _anweisung], _t] call CBA_fnc_targetEvent;
  },{alive _target && !(_target getVariable ["in_deckung", 0] > 0)},{},[_id, "in_deckung"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Anweisung"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

  private _aktion = ["Ist_sicher","It is safe again, you may come out.","\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",{
    params ["_t","_p","_actionparams"];
    _actionparams params ["_id","_anweisung"];
    ["zumi_anweisen", [_t, _p, _id, _anweisung], _t] call CBA_fnc_targetEvent;
  },{alive _target && (_target getVariable ["in_deckung", 0] > 0)},{},[_id, "ist_sicher"]] call zumi_fnc_interaction_create;

  _jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Anweisung"]]] call CBA_fnc_globalEventJIP;
  [_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;
};

//Spawn Mufti
private _grp = createGroup civilian;
private _unit = _grp createUnit ["LOP_CHR_Civ_Priest_01", [0,0,0], [], 0, "CAN_COLLIDE"];
_unit setPosATL _chiefshouse;
_unit setDir (random 360);
_unit setVariable ["spawn_pos", _chiefshouse, true];
_grps pushBack _grp;
_unit setVariable ["story", 10, true];
_array = _unit call CBA_fnc_getNearestBuilding;
_array params ["_building", "_buildingPositions"];
_unit setVariable ["house", _building, true];
_unit setVariable ["id", _id];
private _renitenz = switch (true) do {
  case (_security < 0.25) : {
    ([[0,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
  };
  case ((_security >= 0.25) && (_security < 0.75)) : {
    ([[0,1,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
  };
  case (_security >= 0.75) : {
    ([[0,0,1,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
  };
  default {
    ([[0,1,2,3], 1] call CBA_fnc_selectRandomArray) select 0;
  };
};
_unit setVariable ["renitenz", _renitenz, true];
_building setVariable ["owner", _unit, true];
if (round (random 1) <= _security) then {
  for "_i" from 1 to 22 do	{
    _building setVariable [format ["bis_disabled_door_%1", _i], 1, true];
  };
};
switch (floor random _needs) do {
  case 0 : {
    _unit setVariable ["bandage", 1, true];
  };
  case 1 : {
    _unit setVariable ["hunger", 1, true];
  };
  case 2 : {
    _unit setVariable ["durst", 1, true];
  };
  default {};
};

_unit setVariable ["has_humanitarian_task", true, true];
_unit setVariable ["can_turn_in_humanitarian", false, true];
private _aktion = ["Needs","What is the supply situation?",["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_CA.paa","#cc2900"],{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_humanitarian_situation"];
  if (_humanitarian_situation >= 100) exitWith {
    hint "The chieftain tells you that he and his people are fine at the moment.";
  };
  _t setVariable ["has_humanitarian_task", false, false];
  _t setVariable ["can_turn_in_humanitarian", true, true];
  [_id] remoteExecCall ["zumi_fnc_humanitarian_task", 2];
  hint "The chieftain tells you that he needs humanitarian goods.";
},{(alive _target) && (_target getVariable ["has_humanitarian_task", false])},{},[_id, _humanitarian]] call zumi_fnc_interaction_create;
_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

_insertChildren = {
  params ["_target", "_player", "_params"];
  _params params ["_id"];
  // Add children to this action
  private _actions = [];
  {
      private _childStatement = {
        params ["_target", "_player", "_params"];
        _params params ["_item", "_id"];
        private _size = ([_item] call ace_cargo_fnc_getSizeItem);
        [_id, _size, _player, _target, _item] remoteExecCall ["zumi_fnc_ameliorate_conditions", 2];
      };
      private _action = [format ["%1", [configFile >> "cfgVehicles" >> (typeOf _x)  >> "displayName", "String", "Supplies"] call CBA_fnc_getConfigEntry], _x, "", _childStatement, {true}, {}, [_x, _id],"",4,[false, false, false, false, false], {
        params ["_target", "_player", "_params", "_actionData"];
        _params params ["_item", "_id"];
        // Modify the action - index 1 is the display name, 2 is the icon...
        _actionData set [1, format ["%1", [configFile >> "cfgVehicles" >> (typeOf _item)  >> "displayName", "String", "Supplies"] call CBA_fnc_getConfigEntry]];
      }
    ] call zumi_fnc_interaction_create;
      _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
  } forEach (
    nearestObjects [_target,
      [
        "Land_PaperBox_01_small_closed_brown_F",
        "Land_PaperBox_01_small_closed_brown_F",
        "Land_PaperBox_01_small_stacked_F",
        "Land_WaterBottle_01_stack_F",
        "Land_Portable_generator_F",
        "WaterPump_01_forest_F",
        "Land_CinderBlocks_F",
        "Land_Bricks_V1_F",
        "Land_WoodenPlanks_01_pine_F"
    ], 25, false]
  );
  _actions
};
private _aktion = ["Needs","Offer",["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_CA.paa","#cc2900"],{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id"];
},{(alive _target) && (_target getVariable ["can_turn_in_humanitarian", false])},_insertChildren,[_id]] call zumi_fnc_interaction_create;
_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;


//Intel
_jip_str = ["zumi_interaction_add_to_object", [_unit, _intel, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Sichtungen","Have you seen armed men?","\z\ace\addons\nametags\UI\icon_position_ffv.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_frage"];
  ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
},{alive _target},{},[_id, "bewaffnete_wo"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["bomben_wo","Are you aware of explosives in the area?","\A3\ui_f\data\igui\cfg\simpleTasks\types\destroy_CA.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_frage"];
  ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
},{alive _target},{},[_id, "bomben_wo"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

//Kontrolle
_jip_str = ["zumi_interaction_add_to_object", [_unit, _kontrolle, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Effekten","Show me what you are carrying with you!","\A3\ui_f\data\igui\cfg\simpleTasks\types\search_CA.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_handlung"];
  ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
},{alive _target && !((animationState _target) isEqualTo "ainvpercmstpsnonwnondnon")},{},[_id, "effekten"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Ausweiskontrolle","Papers, please!","\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_CA.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_handlung"];
  ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
},{alive _target},{},[_id, "pass"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Wohin","What are you up to?","\A3\ui_f\data\igui\cfg\simpleTasks\types\walk_CA.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_handlung"];
  ["zumi_kontrollhandlung", [_t, _p, _id, _handlung], _t] call CBA_fnc_targetEvent;
},{alive _target},{},[_id, "woduwolle"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Kontrolle"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

//Humanitär

_jip_str = ["zumi_interaction_add_to_object", [_unit, _human, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Wasser","Give water bottle","\z\acex\addons\field_rations\ui\item_waterbottle_full_co.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_item"];
  ["zumi_item_erhalten", [_t, _p, _id, _item], _t] call CBA_fnc_targetEvent;
},{alive _target && (_target getVariable ["durst", 0] > 0)},{},[_id, "ACE_WaterBottle"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Essen","Give MRE","\z\acex\addons\field_rations\ui\item_mre_human_co.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_item"];
  ["zumi_item_erhalten", [_t, _p, _id, _item], _t] call CBA_fnc_targetEvent;
},{alive _target && (_target getVariable ["hunger", 0] > 0)},{},[_id, "ACE_Humanitarian_Ration"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Bandage","Give a packing bandage","\z\ace\addons\medical_treatment\ui\packingBandage_ca.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_item"];
  ["zumi_item_erhalten", [_t, _p, _id, _item], _t] call CBA_fnc_targetEvent;
},{alive _target && (_target getVariable ["bandage", 0] > 0)},{},[_id, "ACE_packingBandage"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Crowd","How are your people?",["\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_CA.paa",""],{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_item"];
  hint "They do not like you. You scare them.";
},{alive _target},{},[_id]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Humanitär"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

//Anweisungen
_jip_str = ["zumi_interaction_add_to_object", [_unit, _anweisung, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Kopf_runter","Keep your head down!","\A3\ui_f\data\igui\cfg\simpleTasks\types\danger_ca.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_anweisung"];
  ["zumi_anweisen", [_t, _p, _id, _anweisung], _t] call CBA_fnc_targetEvent;
},{alive _target && !(_target getVariable ["in_deckung", 0] > 0)},{},[_id, "kopf_runter"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Anweisung"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["In_deckung","Find cover within a building!","\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_anweisung"];
  ["zumi_anweisen", [_t, _p, _id, _anweisung], _t] call CBA_fnc_targetEvent;
},{alive _target && !(_target getVariable ["in_deckung", 0] > 0)},{},[_id, "in_deckung"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Anweisung"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Ist_sicher","It is safe again, you may come out.","\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_anweisung"];
  ["zumi_anweisen", [_t, _p, _id, _anweisung], _t] call CBA_fnc_targetEvent;
},{alive _target && (_target getVariable ["in_deckung", 0] > 0)},{},[_id, "ist_sicher"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Anweisung"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

private _aktion = ["Mission","Has the chernarussian rebel army set up somewhere recently?","\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_id","_frage"];
  ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
},{alive _target && !(_target getVariable ["befragt", false])},{},[_id, "taskhint"]] call zumi_fnc_interaction_create;

_jip_str = ["zumi_interaction_add_to_object", [_unit, _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _unit ] call CBA_fnc_removeGlobalEventJIP;

_grps;
