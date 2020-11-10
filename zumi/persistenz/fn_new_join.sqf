if (!hasInterface) exitWith {};

"ladebildschirm" cutFadeOut 10;

switch (typeOf player) do {
  case "B_Pilot_F" : {
    if (player getVariable ["323_pilot", 0] < 1) then {
      ["Für diesen Slot besitzen Sie noch keine Berechtigung!", false, 2, false] call BIS_fnc_endMission;
    };
  };

  case "B_officer_F" : {
    if ((player getVariable ["323_logistiker", 0]) < 1) then {
      ["Für diesen Slot besitzen Sie noch keine Berechtigung!", false, 2, false] call BIS_fnc_endMission;
    };
  };
  default {};
};


player setUnitLoadout [[],[],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["",[]],[],"rhs_8point_marpatwd","",["","","","",[],[],""],["ItemMap","","","ItemCompass","ItemWatch",""]];
