if !isServer exitWith {};

params [["_incr", 0], ["_cba_missionTime", 0]];

//Process the Intels
private _inidbi = ["new", "us"] call OO_INIDBI;
mission_intels = ["read", ["Missionspersistenz", "mission_intels", []]] call _inidbi;

if (count mission_intels < 1) exitWith {

};

{
  _x params [["_task", "boss"], ["_stage", 0], ["_found_here", [0,0,0]], ["_title", "test"], ["_desc_string_and_params", []]];
  


} forEach mission_intels;
