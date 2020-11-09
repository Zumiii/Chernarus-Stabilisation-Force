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


player setUnitLoadout [[["rhs_weap_m16a4","","","rhsusf_acc_acog",[],[],""],[],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_rifleman",[["rhsusf_lwh_helmet_marpatwd",1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["HandGrenade",2,1],["SmokeShell",2,1]]],[],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","","ItemCompass","ItemWatch",""]], false];
[
  {
    params ["_p", "_ins"];
    [_p, _ins] call BIS_fnc_setUnitInsignia;
  },
  [player, "alpha_1_1_private"],
  1
] call CBA_fnc_waitAndExecute;
