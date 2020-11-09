if !isServer exitWith {};

params [
  "_posi",
  "_ziel",
  "_classname",
  "_side",
  "_fullcrew",
  "_art",
  "_befehl"
];

private ["_grp","_veh","_dir","_spawn","_return"];

_driver = if (_art IN ["smug","terr"]) then {
  "LOP_CHR_Civ_Random"
} else {
  ""
};




_spawn = if !(_classname isEqualTo "zu Fuss") then {
  [_posi, _side, _classname, _fullcrew, "CAN_COLLIDE", _driver] call zumi_fnc_spawn_fzg
} else {
  [_posi, _side, _fullcrew] call zumi_fnc_spawn_grp
};

_spawn params ["_grp", ["_veh", objNull]];

if (!isNull _veh) then {
  _dir = [_posi, _ziel] call BIS_fnc_dirTo;
  _veh setDir _dir;

  if (_art IN ["smug","terr"]) then {
    _unit = (leader _grp);
    removeAllWeapons _unit;
    _unit setCaptive true;
    _unit disableAI "AUTOCOMBAT";
    _unit allowfleeing 0;
    {_unit removeWeapon _x} forEach (weapons _unit);
    {_unit removeMagazine _x} forEach (magazines _unit);
    removeVest _unit;
    removeHeadgear _unit;
    removeGoggles _unit;
    if (_art isEqualTo "terr") then {

    } else {
      //[_unit,_veh,_ziel] call zumi_fnc_schmuggler; TODO
    };
  };
};

//Chance auf ein Intel

switch _side do {
 case west : {
   //Gesprächspartner
   _intel = ["Intel","Gather Information",["\A3\ui_f\data\igui\cfg\simpleTasks\types\listen_CA.paa", "##a6ff4d"],
     {
       params ["_t","_p","_actionparams"];
       if (_t getVariable ["greeted", false]) exitWith {};
       [_t, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
       [_p, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
       _t setVariable ["greeted", true];
     },{alive _target},{},[], [0,0,0], 2, [false, false, false, true, false]] call zumi_fnc_interaction_create;
     _jip_str = ["zumi_interaction_add_to_object", [(leader _grp), _intel, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
     [_jip_str, (leader _grp) ] call CBA_fnc_removeGlobalEventJIP;
     private _aktion = ["Sichtungen","Have you seen armed men?","\z\ace\addons\nametags\UI\icon_position_ffv.paa",{
        params ["_t","_p","_actionparams"];
        _actionparams params ["_id","_frage"];
        ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
      },{alive _target},{},[-1, "bewaffnete_wo"]] call zumi_fnc_interaction_create;
      _jip_str = ["zumi_interaction_add_to_object", [(leader _grp), _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
      [_jip_str, (leader _grp) ] call CBA_fnc_removeGlobalEventJIP;
 };
 case east : {
   //Intel
   private _closesttarget = [zumi_stellungen, {-((leader _grp) distance2d ((_x select 1) select 0))}, []] call CBA_fnc_selectBest;
   if !(_closesttarget isEqualto []) then {
     private _pos = ((_closesttarget select 1) select 0);
     private _dirto = [getPos (leader _grp) getDir _pos, 45] call BIS_fnc_roundDir;
     private _dir = switch _dirto do {
       case 0 : {"north"};
       case 45 : {"northeast"};
       case 90 : {"east"};
       case 135 : {"southeast"};
       case 180 : {"south"};
       case 225 : {"southwest"};
       case 270 : {"west"};
       case 315 : {"northwest"};
       default {"north"};
     };
     _dist = (leader _grp) distance2d _pos;
     _entfernung = switch (true) do {
       case (_dist <= 1000) : {"within 1 kilometer"};
       case (_dist > 1000 && _dist <= 2000) : {"one, maybe two  kilometer from here (<150m)"};
       case (_dist > 2000 && _dist <= 3000) : {"about two to three  kilometer away from here"};
       case (_dist > 3000 && _dist <= 5000) : {"about three to five  kilometer away from here"};
       default {"far away"};
     };
     [leader _grp, "acex_intelitems_notepad", format ["According to the notes there is a %1 towards %2, %3.", (_closesttarget select 3), _dir, _entfernung]] call acex_intelitems_fnc_addIntel;
   };
 };
 case resistance : {
   //Intel
   private _closesttarget = [zumi_stellungen, {-((leader _grp) distance2d ((_x select 1) select 0))}, []] call CBA_fnc_selectBest;
   if !(_closesttarget isEqualto []) then {
     private _pos = ((_closesttarget select 1) select 0);
     private _dirto = [getPos (leader _grp) getDir _pos, 45] call BIS_fnc_roundDir;
     private _dir = switch _dirto do {
       case 0 : {"north"};
       case 45 : {"northeast"};
       case 90 : {"east"};
       case 135 : {"southeast"};
       case 180 : {"south"};
       case 225 : {"southwest"};
       case 270 : {"west"};
       case 315 : {"northwest"};
       default {"north"};
     };
     _dist = (leader _grp) distance2d _pos;
     _entfernung = switch (true) do {
       case (_dist <= 1000) : {"within 1 kilometer"};
       case (_dist > 1000 && _dist <= 2000) : {"one, maybe two  kilometer from here (<150m)"};
       case (_dist > 2000 && _dist <= 3000) : {"about two to three  kilometer away from here"};
       case (_dist > 3000 && _dist <= 5000) : {"about three to five  kilometer away from here"};
       default {"far away"};
     };
     [leader _grp, "acex_intelitems_notepad", format ["According to the notes there is a %1 towards %2, %3.", (_closesttarget select 3), _dir, _entfernung]] call acex_intelitems_fnc_addIntel;
   };

 };
 case civilian : {
   //Gesprächspartner
   _intel = ["Intel","Gather Information",["\A3\ui_f\data\igui\cfg\simpleTasks\types\listen_CA.paa", "##a6ff4d"],
     {
       params ["_t","_p","_actionparams"];
       if (_t getVariable ["greeted", false]) exitWith {};
       [_t, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
       [_p, selectRandom ["gestureHi", "gestureHiC"]] call ace_common_fnc_doGesture;
       _t setVariable ["greeted", true];
     },{alive _target},{},[], [0,0,0], 2, [false, false, false, true, false]] call zumi_fnc_interaction_create;
     _jip_str = ["zumi_interaction_add_to_object", [(leader _grp), _intel, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
     [_jip_str, (leader _grp) ] call CBA_fnc_removeGlobalEventJIP;
     private _aktion = ["Sichtungen","Have you seen armed men?","\z\ace\addons\nametags\UI\icon_position_ffv.paa",{
        params ["_t","_p","_actionparams"];
        _actionparams params ["_id","_frage"];
        ["zumi_befrage_informant", [_t, _p, _id, _frage], _t] call CBA_fnc_targetEvent;
      },{alive _target},{},[-1, "bewaffnete_wo"]] call zumi_fnc_interaction_create;
      _jip_str = ["zumi_interaction_add_to_object", [(leader _grp), _aktion, 0, ["ACE_MainActions","Intel"]]] call CBA_fnc_globalEventJIP;
      [_jip_str, (leader _grp) ] call CBA_fnc_removeGlobalEventJIP;
 };
 default {};
};

_return = [_grp, [_veh]];

_return;
