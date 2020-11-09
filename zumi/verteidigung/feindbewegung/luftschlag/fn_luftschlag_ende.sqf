/*

  Flugzeug kriegt einen Feuerbefehl zugewiesen

*/

if !isServer exitWith {};

params ["_grp"];

(_grp getvariable ["befehl", []]) params [["_pos", [0,0,0], ["_auftrag", "luftschlag"], ["_dauer", -1]]];

_target = _grp getvariable ["target", objNull];

for "_i" from 0 to 3 do {
  (vehicle (leader _grp)) addMagazine "LIB_1Rnd_SC50";
};
(vehicle (leader _grp))  addWeapon "LIB_SC50_Bomb_Mount";
(vehicle (leader _grp)) addMagazine "LIB_1Rnd_SC500";
(vehicle (leader _grp))  addWeapon "LIB_SC500_Bomb_Mount";

_vehicle = (vehicle _target);

_wep = switch (true) do {
  case (_vehicle isKindOf "CAManBase") : {
    selectRandomWeighted ["LIB_2xMG151_JU87",0.8,"LIB_SC50_Bomb_Mount",0.2,"LIB_SC500_Bomb_Mount",0.05]
  };
  case (_vehicle isKindOf "Car") : {
    selectRandomWeighted ["LIB_2xMG151_JU87",0.7,"LIB_SC50_Bomb_Mount",0.3,"LIB_SC500_Bomb_Mount",0.1]
  };
  case (_vehicle isKindOf "Wheeled_APC_F") : {
    selectRandomWeighted ["LIB_2xMG151_JU87",0.6,"LIB_SC50_Bomb_Mount",0.4,"LIB_SC500_Bomb_Mount",0.15]
  };
  case (_vehicle isKindOf "Tank") : {
    selectRandomWeighted ["LIB_2xMG151_JU87",0.5,"LIB_SC50_Bomb_Mount",0.5,"LIB_SC500_Bomb_Mount",0.25]
  };
  case (_vehicle isKindOf "Helicopter") : {
    selectRandomWeighted ["LIB_2xMG151_JU87",1,"LIB_SC50_Bomb_Mount",0,"LIB_SC500_Bomb_Mount",0]
  };
  case (_vehicle isKindOf "Plane") : {
    selectRandomWeighted ["LIB_2xMG151_JU87",1,"LIB_SC50_Bomb_Mount",0,"LIB_SC500_Bomb_Mount",0]
  };
  default {
    selectRandomWeighted ["LIB_2xMG151_JU87",1,"LIB_SC50_Bomb_Mount",0.25,"LIB_SC500_Bomb_Mount",0.1]
  };
};


(leader _grp) doTarget _target;

//_handle = (vehicle (leader _grp)) fireAtTarget [_target];

//Warte, bis die Distanz klein genug ist und das Flugzeug gut genug gezielt hat
_vehicle setVariable  ["IFA3_sirenEnabled",1,true];
_vehicle setvariable  ["IFA3_sirenOn",true,true];
[
	{
		params ["_args","_handle"];
		_args params ["_grp","_vehicle","_target", "_wep"];
    if (({alive _x} count (units _grp) < 1) || (!alive _vehicle) || (damage _target >= 0.9)) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
    if ((_vehicle aimedAtTarget [_target, _wep]) >= 1) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
      /*if ([_target] call ace_common_fnc_isInBuilding) then {
        _target =
      } else {

      };*/
      _did_fire = _vehicle fireAtTarget [_target, _wep];

      if (debug) then {
        systemChat "RIPPERINO";
      };
    };
	},
	3,
	[_grp, _vehicle, _target, _wep]
] call CBA_fnc_addPerFrameHandler;
