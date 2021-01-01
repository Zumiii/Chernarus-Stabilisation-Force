/*

  Function checks for persistent enemy plans and initiates enemy movement

*/



if !isServer exitWith {};

//Params

zumi_warfare params [
  ["_neutral", []],
  ["_conquered", []],
  ["_lost", []],
  ["_held", []],
  ["_targets", []],
  ["_losses_old", 0]
];

//Check for player caused losses during last Server Cycle 
private _losses_new = east_losses - _losses_old;

{
  _x params [
    ["_ids", []],
    ["_date_and_restart", []],
    ["_time_untouched", []],
    ["_losses", []],
    ["_kills", []],
    ["_structure_losses", []],
    ["_damaged_houses", []],
    ["_destroyed_houses", []],
    ["_used_as", "passing point"]
  ];
} forEach _neutral;

{
  _x params [
    ["_ids", []],
    ["_date_and_restart", []],
    ["_time_until_conquered", []],
    ["_losses", []],
    ["_kills", []],
    ["_structure_losses", []],
    ["_damaged_houses", []],
    ["_destroyed_houses", []],
    ["_used_as", "supply point"]
  ];
} forEach _conquered;

{
  _x params [
    ["_ids", []],
    ["_date_and_restart", []],
    ["_time_until_lost", []],
    ["_losses", []],
    ["_kills", []],
    ["_structure_losses", []],
    ["_damaged_houses", []],
    ["_destroyed_houses", []],
    ["_used_as", "supply point"]
  ];
} forEach _lost;

{
  _x params [
    ["_ids", []],
    ["_date_and_restart", []],
    ["_time_held", []],
    ["_losses", []],
    ["_kills", []],
    ["_structure_losses", []],
    ["_damaged_houses", []],
    ["_destroyed_houses", []],
    ["_used_as", "supply point"]
  ];
} forEach _held;

{
  _x params [
    ["_ids", []],
    ["_date_and_restart", []],
    ["_attack_for", []],
    ["_losses", []],
    ["_kills", []],
    ["_damaged_houses", []],
    ["_destroyed_houses", []]
  ];
} forEach _targets;

zumi_strategy params [
  ["_strength", 1],
  ["_morale", 1],
  ["_experience", 1],
  ["_tactics", "aggressive"],
  ["_priority", "fight militia"]
];


//Update Strength respecting losses of manpower and infrastructre

[] call zumi_fnc_update_strength;

//Update Morale

[] call zumi_fnc_update_morale;

//Update Priority

[] call zumi_fnc_update_priority;

//Update Experience

[] call zumi_fnc_update_experience;

//Update Tactics

[] call zumi_fnc_update_tactics;
