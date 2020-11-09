/*

  Funktion spawnt einen Fallschirmabwurf. Es kann Frachtgut, Infanterie oder ein Fahrzeug abgeworfen werden.

*/

if !isServer exitWith {};

params [
  ["_zielkoordinate",[0,0,0]], //ARRAY
  ["_startkoordinate",[0,0,0]], //ARRAY
  ["_side", east], //SIDE
  ["_flugzeugklasse","LIB_Ju52"], //STRING
  ["_cargo",[]], //ARRAY
  ["_unterstelle_dem_feind",true] //BOOLEAN
];

private _spawn = [_startkoordinate, _side, _flugzeugklasse, [], "FLY", _dir] call zumi_fnc_spawn_fzg;
_spawn params ["_piloten_grp","_frachtmaschine"];
_frachtmaschine setDir ([_startkoordinate,_zielkoordinate] call bis_fnc_dirTo);
_frachtmaschine flyInHeight 130;
_zielkoordinate set [2, 130];
[_piloten_grp] call CBA_fnc_clearWaypoints;
//Weise Wegpunkt zu --> KI feuert nur zurück
[_piloten_grp, _zielkoordinate, 0, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_addWaypoint;
[_piloten_grp, _startkoordinate, 0, "MOVE", "AWARE", "YELLOW", "FULL", "COLUMN","(leader (group this)) call zumi_fnc_airdrop_cleanup;"] call CBA_fnc_addWaypoint;

private _parachuters = if (toupper (typename _cargo) == "STRING") then {_cargo call zumi_fnc_grp_namen} else {[]};

private _cargogrp = createGroup _side;
if (count _parachuters > 0) then {
	{
		if !(( _frachtmaschine emptyPositions "cargo") > 0) exitWith {};
		private _unit = _cargogrp createUnit [_x, [0,0,0], [], 0, "CAN_COLLIDE"];
    _unit setSkill ["aimingAccuracy", aimingAccuracy];
  	_unit setSkill ["aimingShake", aimingShake];
  	_unit setSkill ["aimingSpeed", aimingSpeed];
  	_unit setSkill ["spotDistance", spotDistance];
  	_unit setSkill ["spotTime", spotTime];
  	_unit setSkill ["courage", courage];
  	_unit setSkill ["reloadSpeed", reloadSpeed];
  	_unit setSkill ["commanding", commanding];
		_unit assignAsCargo _frachtmaschine;
		_unit moveInCargo _frachtmaschine;
	} forEach _parachuters;
};
_cargogrp setVariable ["befehl", [_zielkoordinate, "eintreffen", 600]];
_cargogrp setVariable ["truppengattung","fallschirmjaeger"];

[
  {
    params ["_piloten","_frachtmaschine","_ziel","_cargogrp","_unterstelle_dem_feind"];
    (({alive _x} count (units _piloten) == 0) || !(alive _frachtmaschine) || (_frachtmaschine distance2d _ziel <= 300))
  },
  {
    params ["_piloten_grp","_frachtmaschine","_zielkoordinate","_cargogrp","_unterstelle_dem_feind"];
    if ((alive _frachtmaschine) && ((vehicle (leader _piloten_grp)) == _frachtmaschine)) then {
      for "_i" from 0 to (count (units _cargogrp))-1 do {
        [
          {
            params ["_unit"];
            unassignVehicle _unit;
            _unit allowDamage false;
            moveOut _unit;
          },
          [((units _cargogrp) select _i)],
          (0.75 + _i*0.75)
        ] call CBA_fnc_waitAndExecute;
        /*
        [
          {
            params ["_unit"];
            private _parachute = createVehicle ["LIB_GER_Parachute",(getPosATL _unit), [], 0, "FLY"];
            _unit moveInDriver _parachute;
            _unit allowDamage true;
          },
          [((units _cargogrp) select _i)],
          (2.5 + _i*0.5)
        ] call CBA_fnc_waitAndExecute;
        */
      };
      if (_unterstelle_dem_feind) then {
        {zumi_soldaten pushBack _x;} forEach (units _cargocrp);
        [_cargogrp, getPos (leader _cargogrp)] call zumi_fnc_befehl_erfragen;
      };

    } else {
      if (_unterstelle_dem_feind) then {
        {zumi_soldaten pushBack _x;} forEach (units _cargocrp);
        [_cargogrp, getPos (leader _cargogrp)] call zumi_fnc_befehl_erfragen;
      };
    };
  },
  [_piloten_grp,_frachtmaschine,_zielkoordinate,_cargogrp,_unterstelle_dem_feind]
] call CBA_fnc_waitUntilAndExecute;

_cargogrp;
