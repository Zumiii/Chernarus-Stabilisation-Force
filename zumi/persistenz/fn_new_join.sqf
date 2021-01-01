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


player setUnitLoadout [["hlc_rifle_G36A1","","","",[],[],""],["BWA3_Bunkerfaust","","","",["BWA3_PzF3_DM32",1],[],""],[],["PBW_Uniform3_fleck",[["BWA3_Beret_Jaeger",1],["ACE_Canteen",1],["ACE_MRE_BeefStew",1],["ACE_morphine",1],["ACE_tourniquet",2],["ACE_packingBandage",6],["ACE_epinephrine",1],["ACE_EarPlugs",1],["ACE_quikclot",6],["ACE_CableTie",1],["BWA3_G_Combat_clear",1]]],["pbw_splitter_schtz",[["ACE_EntrenchingTool",1],["BWA3_DM25",2,1],["BWA3_DM51A1",2,1],["hlc_30rnd_556x45_EPR_G36",7,30]]],[],"PBW_muetze2_fleck","",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]];

["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;
