
/*

  Defines

*/


befestigungsobjekte = [
  ["Land_BagFence_Long_F",5],
  ["Land_BagFence_Round_F",5],
  ["Land_BagFence_Short_F",5],
  ["Land_SandbagBarricade_01_half_F",5],
  ["Land_SandbagBarricade_01_F",5],
  ["Land_SandbagBarricade_01_hole_F",5],
  ["Land_BagBunker_Small_F",5],
  ["Land_BagBunker_Large_F",5],
  ["Land_Fort_Watchtower_EP1",5],
  ["Land_Razorwire_F",5],
  ["Land_Plank_01_4m_F",5],
  ["Land_Plank_01_8m_F",5],
  ["Land_HBarrier_3_F",5],
  ["Land_HBarrier_5_F",5],
  ["Land_HBarrier_1_F",5]
];

zumi_carbombs = [
	["LOP_CHR_Civ_Landrover",[-1.1,-0.1,-0.2]],
	["LOP_CHR_Civ_Offroad",[-1.05,0.9,-1.3]],
	["LOP_CHR_Civ_UAZ",[-0.5,0,-1.1]],
	["LOP_CHR_Civ_Ural",[-0.3,0.5,-1,5]],
	["LOP_CHR_Civ_Ural_Open",[-0.3,0.5,-1,5]],
	["C_Truck_02_transport_F",[-1,0.1,-1.5]],
	["C_IDAP_Truck_02_transport_F",[-1,0.1,-1.5]],
	["C_IDAP_Truck_02_F",[-1,0.1,-1.5]],
	["C_IDAP_Truck_02_water_F",[-1,0.1,-1.5]],
	["C_IDAP_Offroad_01_F",[-1.05,0.9,-1.3]],
	["C_Van_01_box_F",[-0.65,-0.5,-1.5]],
	["C_Van_01_fuel_F",[-0.7,-0.3,-1.7]],
	["C_Tractor_01_F",[-0.7,-0.3,-1.7]]
];

Bestellbare = [
  [
    "Deployable Weapons",
    "\A3\Weapons_F\Data\UI\icon_at_CA.paa",
    [
      [1,"RHS_Stinger_AA_pod_D","","Stinger Pad",2,[]],
      [2,"RHS_M2StaticMG_D","","M2 (High)",2,[]],
      [3,"RHS_M2StaticMG_MiniTripod_D","","M2 (Low)",2,[]],
      [4,"RHS_TOW_TriPod_D","","TOW",2,[]],
      [5,"RHS_MK19_TriPod_D","","MK19",2,[]]
    ]
  ],
  [
    "Signaling",
    "\A3\ui_f\data\map\vehicleicons\iconStaticSearchlight_ca.paa",
    [
      [1,"ACE_Box_Chemlights","","Chemlights",2,[["ACE_Chemlight_White", 20],["Chemlight_blue", 5],["Chemlight_green", 5],["Chemlight_red", 5]]],
      [2,"ACE_Box_Chemlights","","Flares (Handheld)",2,[["ACE_HandFlare_White", 20],["ACE_HandFlare_Red", 5],["ACE_HandFlare_Yellow", 5],["ACE_HandFlare_Green", 5]]],
      [3,"ACE_Box_Chemlights","","Flares (Underbarell)",2,[["UGL_FlareWhite_F", 30],["UGL_FlareRed_F", 5],["UGL_FlareGreen_F", 5],["UGL_FlareCIR_F", 5]]],
      [4,"ACE_Box_Chemlights","", "IR Grenades",2,[["B_IR_Grenade", 40]]]
    ]
  ],
  [
    "Ammunition",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa",
    [
      [1,"ACE_Box_Ammo","","M855A1 Stanag",2,[["rhs_mag_30Rnd_556x45_M855A1_Stanag",30],["rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",30]]],
      [2,"ACE_Box_Ammo","","SCAR 762x51",2,[["rhs_mag_20Rnd_SCAR_762x51_m80a1_epr",20],["rhs_mag_20Rnd_SCAR_762x51_m62_tracer",20]]],
      [3,"ACE_Box_Ammo","","SR25 762x51",2,[["rhsusf_20Rnd_762x51_SR25_m118_special_Mag",20], ["rhsusf_20Rnd_762x51_SR25_m62_Mag",20]]],
      [4,"ACE_Box_Ammo","","Shotgun Shells",2,[["rhsusf_8Rnd_FRAG",30],["rhsusf_8Rnd_SLUG",30]]],
      [5,"ACE_Box_Ammo","","M24 762x51",2,[["rhsusf_5Rnd_762x51_m118_special_Mag",50]]],
      [6,"ACE_Box_Ammo","","M14 762x51",2,[["rhsusf_20Rnd_762x51_m118_special_Mag",20],["rhsusf_20Rnd_762x51_m62_Mag",20]]],
      [7,"ACE_Box_Ammo","","M249 556x45",2,[["rhsusf_200Rnd_556x45_box",4],["rhsusf_200rnd_556x45_mixed_box",4],["rhsusf_100Rnd_556x45_soft_pouch_ucp",8],["rhsusf_100Rnd_556x45_mixed_soft_pouch_ucp",8]]],
      [8,"ACE_Box_Ammo","","M240 762x51",2,[["rhsusf_100Rnd_762x51_m80a1epr",4],["rhsusf_100Rnd_762x51_m62_tracer",4],["rhsusf_50Rnd_762x51_m80a1epr",8],["rhsusf_50Rnd_762x51_m62_tracer",8]]],
      [9,"ACE_Box_Ammo","","M1911 7x45acp",2,[["rhsusf_mag_7x45acp_MHP",40]]],
      [10,"ACE_Box_Ammo","","M9 9x19",2,[["rhsusf_mag_15Rnd_9x19_FMJ",20],["rhsusf_mag_15Rnd_9x19_JHP",20]]],
      [11,"ACE_Box_Ammo","","Glock 9x19",2,[["rhsusf_mag_17Rnd_9x19_FMJ",20],["rhsusf_mag_17Rnd_9x19_JHP",20]]]
    ]
  ],
  [
    "Utilities",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa",
    [
      [1,"ACE_Box_Misc","\z\ace\addons\sandbag\data\m_sandbag_ca.paa","Empty Sandbags",2,[["ACE_Sandbag_empty",50]]],
      [2,"ACE_Wheel","\z\ace\addons\repair\ui\tire_ca.paa","Tire",1,[]],
      [3,"ACE_Track","\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa","Track",2,[]],
      [4,"ACE_ConcertinaWireCoil","\A3\Ui_f\data\GUI\Cfg\KeyframeAnimation\IconControlPoint_CA.paa","Wirefence coil",1,[]],
      [5,"Box_NATO_Equip_F","\A3\Weapons_F\Items\data\UI\gear_Toolkit_CA.paa","Tools",2,[["ACE_EntrenchingTool",4],["ACE_DefusalKit",4],["ToolKit",4],["ACE_Fortify",4],["ACE_wirecutter",2]]]
    ]
  ],
  [
    "Explosives",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\mine_ca.paa",
    [
      [1,"Box_NATO_AmmoOrd_F","","Demolition Equipment",2,[["SatchelCharge_Remote_Mag",8],["ACE_Clacker", 1],["ACE_M26_Clacker", 1]]],
      [2,"Box_NATO_AmmoOrd_F","","Frag Grenades",2,[["HandGrenade",50]]],
      [3,"Box_NATO_AmmoOrd_F","","Smoke Grenades",2,[["SmokeShell",30],["SmokeShellBlue",5],["SmokeShellRed",5],["SmokeShellPurple",5],["SmokeShellYellow",5]]],
      [4,"Box_NATO_AmmoOrd_F","","AT Mines",2,[["ATMine_Range_Mag",8]]],
      [5,"Box_NATO_AmmoOrd_F","","Underbarrel Grenades",2,[["rhs_mag_M441_HE",20],["1Rnd_Smoke_Grenade_shell",20],["1Rnd_SmokeRed_Grenade_shell",5],["rhs_mag_M433_HEDP",10],["ACE_HuntIR_M203",5]]],
      [6,"ACE_Box_82mm_Mo_HE","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa","Mortar shells (HE)",2,[]],
      [7,"ACE_Box_82mm_Mo_Illum","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa","Mortar shells (Illum)",2,[]],
      [8,"ACE_Box_82mm_Mo_Smoke","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa","Mortar shells (Smoke)",2,[]],
      [9,"ACE_Box_82mm_Mo_Combo","\A3\Static_f\Mortar_01\data\UI\Mortar_01_ca.paa","Mortar shells (Mixed)",2,[]]
    ]
  ],
  [
    "Medical",
    "\z\ace\addons\medical_gui\ui\cross_T_9.paa",
    [
      [1,"ACE_medicalSupplyCrate_advanced","\z\ace\addons\medical_treatment\ui\surgicalKit_ca.paa","Medical Crate",2,[["ACE_elasticBandage",20],["ACE_quikclot",50],["ACE_packingBandage",75],["ACE_tourniquet",20],["ACE_morphine",15],["ACE_epinephrine",15],["ACE_adenosine",5],["ACE_surgicalKit",15],["ACE_personalAidKit",5],["ACE_Splint",12]]],
      [2,"Land_MetalCase_01_medium_F","\z\ace\addons\medical_treatment\ui\salineIV_ca.paa","IVs",2,[["ACE_salineIV",50],["ACE_salineIV_500",10],["ACE_salineIV_250",10],["ACE_plasmaIV",20],["ACE_plasmaIV_500",10],["ACE_plasmaIV_250",10],["ACE_bloodIV",20],["ACE_bloodIV_500",10],["ACE_bloodIV_250",10]]]
    ]
  ],
  [
    "Fuel",
    "\z\ace\addons\refuel\ui\icon_module_refuel.paa",
    [
      [1,"FlexibleTank_01_sand_F","\z\ace\addons\refuel\ui\icon_refuel_interact.paa","Fuel Tank",4,[]]
    ]
  ],
  [
    "Vehicle Ammo",
    "\z\ace\addons\rearm\ui\icon_module_rearm.paa",
    [
      [1,"Box_NATO_AmmoVeh_F","\z\ace\addons\rearm\ui\icon_rearm_interact.paa","Ammo container",2,[]]
    ]
  ],
  [
    "Food",
    "\z\ace\addons\disarming\ui\potato_ca.paa",
    [
      [1,"Land_PaperBox_01_small_closed_brown_F","\z\acex\addons\field_rations\ui\item_canteen_co.paa","Canteens",2,[["ACE_Canteen", 40]]],
      [2,"Land_PaperBox_01_small_closed_brown_F","\z\acex\addons\field_rations\ui\item_mre_type2_co.paa","MREs",2,[["ACE_MRE_BeefStew", 40]]]
    ]
  ],
  [
    "Optic Devices",
    "\A3\ui_f\data\igui\cfg\simpleTasks\types\scout_ca.paa",
    [
      [1,"ACE_Box_Misc","","Binoculars",2,[["ACE_Vector",4],["ACE_Yardage450",4],["ACE_MX2A",1],["Laserdesignator",2],["Laserbatteries",2]]],
      [2,"ACE_Box_Misc","","NVGs",2,[["rhsusf_ANPVS_14",10],["rhsusf_ANPVS_15",10]]]
    ]
  ]
];

grp_presets = [

/* ANP (Old)*/
  ["ANP_Gruppe_0", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_grenadier_rpg","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_marksman"] ]
  ,["ANP_Gruppe_1", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_engineer","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_specialist_aa"] ]
  ,["ANP_Gruppe_2", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_aks74", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_Gruppe_3", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_specialist_aa","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_akm", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_Gruppe_4", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_rifleman"] ]
  ,["ANP_Gruppe_5", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_medic","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_marksman"] ]
  ,["ANP_LKW_Gruppe_0", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_grenadier_rpg","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_marksman"] ]
  ,["ANP_LKW_Gruppe_1", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_engineer","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_specialist_aa"] ]
  ,["ANP_LKW_Gruppe_2", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_aks74", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_PHMV_Gruppe_0", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_specialist_aa","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_akm", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_PHMV_Gruppe_1", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_rifleman"] ]
  ,["ANP_PHMV_Gruppe_2", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_medic","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_marksman"] ]
  ,["ANP_HMV_Gruppe_0", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_grenadier_rpg","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_marksman"] ]
  ,["ANP_HMV_Gruppe_1", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_engineer","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_specialist_aa"] ]
  ,["ANP_HMV_Gruppe_2", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_aks74", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_APC_Gruppe_0", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_specialist_aa","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_akm", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_APC_Gruppe_1", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_rifleman"] ]
  ,["ANP_APC_Gruppe_2", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_medic","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_marksman"] ]
  ,["ANP_Offroad_Gruppe_0", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_specialist_aa","rhsgref_cdf_b_reg_machinegunner","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_rifleman_akm", "rhsgref_cdf_b_reg_medic"] ]
  ,["ANP_Offroad_Gruppe_1", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_rifleman_lite","rhsgref_cdf_b_reg_rifleman_rpg75","rhsgref_cdf_b_reg_grenadier","rhsgref_cdf_b_reg_rifleman"] ]
  ,["ANP_Offroad_Gruppe_2", ["rhsgref_cdf_b_reg_squadleader","rhsgref_cdf_b_reg_rifleman_aks74","rhsgref_cdf_b_reg_medic","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_rifleman_akm","rhsgref_cdf_b_reg_marksman"] ]

/* Taki-Milizen und Armee */
  ,["AXIS_AA_Gruppe", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_Marksman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman"] ]
	,["AXIS_Gruppe_0", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_Rifleman"] ]
	,["AXIS_Gruppe_1", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_Marksman"] ]
	,["AXIS_Gruppe_2", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_AT_Asst","LOP_ChDKZ_Infantry_Rifleman"] ]
	,["AXIS_Gruppe_3", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_GL"] ]
	,["AXIS_Gruppe_4",["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_GL"] ]
	,["AXIS_Gruppe_5", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_Rifleman"] ]
  ,["AXIS_APC_Gruppe_0", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_Marksman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman"] ]
	,["AXIS_APC_Gruppe_1", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_Rifleman"] ]
	,["AXIS_APC_Gruppe_2", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_Marksman"] ]
	,["AXIS_LKW_Gruppe_0", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_GL","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_AT","LOP_ChDKZ_Infantry_AT_Asst","LOP_ChDKZ_Infantry_Rifleman"] ]
	,["AXIS_LKW_Gruppe_1", ["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_GL"] ]
	,["AXIS_LKW_Gruppe_2",["LOP_ChDKZ_Infantry_TL","LOP_ChDKZ_Infantry_SL","LOP_ChDKZ_Infantry_Corpsman","LOP_ChDKZ_Infantry_MG","LOP_ChDKZ_Infantry_Rifleman","LOP_ChDKZ_Infantry_GL"] ]
  /* UN Truppen */
  ,["UN_Gruppe_0", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_GL"] ]
  ,["UN_Gruppe_1", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_Gruppe_2", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_Gruppe_3", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_GL"] ]
  ,["UN_Gruppe_4", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_Gruppe_5", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_LKW_Gruppe_0", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_GL"] ]
  ,["UN_LKW_Gruppe_1", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_LKW_Gruppe_2", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_UAZ_Gruppe_0", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_GL"] ]
  ,["UN_UAZ_Gruppe_1", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_UAZ_Gruppe_2", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]

  ,["UN_Offroad_Gruppe_0", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_Offroad_Gruppe_1", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_Offroad_Gruppe_2", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_GL"] ]
  ,["UN_BTR_Gruppe_0", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_Marksman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_BTR_Gruppe_1", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_GL","LOP_NAPA_Infantry_MG","LOP_NAPA_Infantry_Rifleman"] ]
  ,["UN_BTR_Gruppe_2", ["LOP_NAPA_Infantry_TL","LOP_NAPA_Infantry_SL","LOP_NAPA_Infantry_Corpsman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_Rifleman","LOP_NAPA_Infantry_AT","LOP_NAPA_Infantry_GL"] ]

  /* LSF */
  ,["LSF_Gruppe_0", ["rhsgref_nat_pmil_commander","rhsgref_nat_pmil_rifleman_akm","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_rifleman","rhsgref_nat_pmil_grenadier","rhsgref_nat_pmil_grenadier_rpg"] ]
  ,["LSF_Gruppe_1", ["rhsgref_nat_pmil_commander","rhsgref_nat_pmil_rifleman_akm","rhsgref_nat_pmil_machinegunner","rhsgref_nat_pmil_specialist_aa","rhsgref_nat_pmil_rifleman"] ]
  ,["LSF_Gruppe_2", ["rhsgref_nat_pmil_commander","rhsgref_nat_pmil_rifleman_akm","rhsgref_nat_pmil_grenadier_rpg","rhsgref_nat_pmil_rifleman_aksu","rhsgref_nat_pmil_rifleman","rhsgref_nat_pmil_rifleman_aksu"] ]

];



/*
  Fahrzeuge
*/

fzg_presets = [
  /* ANP */
  /* 0 - Luftabwehr  */	 ["LOP_CDF_ZSU234"]
  /* 1 - Kampfhelis	 */		,["LOP_CDF_Mi24V_UPK23","LOP_CDF_Mi24V_AT","LOP_CDF_Mi24V_FAB"]
  /* 2 - Offroader  */		,["LOP_CDF_Offroad_M2","LOP_CDF_Offroad_AT"]
  /* 3 - BMPs  */		,["LOP_CDF_BMP1D","LOP_CDF_BMP1","LOP_CDF_BMD1"]
  /* 4 - Leicht  */		,["LOP_CDF_UAZ_AGS","LOP_CDF_UAZ_DshKM","LOP_CDF_UAZ_SPG"]
  /* 5 - APCs  */		,["LOP_CDF_BTR60","LOP_CDF_BTR70"]
  /* 6 - Arty  */	,["LOP_CDF_BM21"]
  /* 7 - Transportheli */ 		,["LOP_CDF_Mi8MT_Cargo"]
  /* 8 - Starrflügler AXIS */ 		,["rhs_l39_cdf_b_cdf","rhsgref_cdf_b_su25"]
  /* 9 - LKWs */ 	,["LOP_CDF_KAMAZ_Covered","LOP_CDF_KAMAZ_Transport","LOP_CDF_Truck","LOP_CDF_Ural","LOP_CDF_Ural_open"]
  /* 10 - MBTs  */	,["LOP_CDF_T72BA"]
  /* 11 - Statisch */	,["LOP_CDF_Kord_High"]

  /* Milizen und Takis */
  /* 12 - Luftabwehr AXIS */	 ,["LOP_ChDKZ_ZSU234"]
  /* 13 - Kampfhelis */		,["LOP_ChDKZ_Mi8MTV3_UPK23"]
  /* 14 - Unbewaffnet Miliz */	,["LOP_ChDKZ_UAZ","LOP_ChDKZ_UAZ_Open"]
  /* 15 - MTechnicals */	,["LOP_ChDKZ_UAZ_AGS","LOP_ChDKZ_UAZ_DshKM","LOP_ChDKZ_UAZ_SPG"]
  /* 16 - MAPCs */	,["LOP_ChDKZ_BTR70","LOP_ChDKZ_BTR60"]
  /* 17 - ATechnicals */	,["LOP_ChDKZ_UAZ_AGS","LOP_ChDKZ_UAZ_DshKM","LOP_ChDKZ_UAZ_SPG"]
  /* 18 - AAPCs */	,["LOP_ChDKZ_BMP1","LOP_ChDKZ_BMP2"]
  /* 19 - Arty */		,["LOP_ChDKZ_BM21"]
  /* 20 - MBTs */	,["LOP_ChDKZ_T72BA"]
  /* 21 - MLKWs */	,["LOP_ChDKZ_Ural_open","LOP_ChDKZ_Ural"]
  /* 22 - ALKWs */	,["LOP_ChDKZ_Ural_open","LOP_ChDKZ_Ural"]
  /* 23 - Kampfjets */	,["LOP_ChDKZ_Mi8MTV3_FAB"]
  /* 24 - Transporthelis */				,["LOP_ChDKZ_Mi8MT_Cargo"]
  /* 25 - Unbewaffnet AXIS */				,["LOP_ChDKZ_UAZ_Open","LOP_ChDKZ_UAZ"]
  /* 26 - Luftabwehr AXIS */			,["LOP_ChDKZ_ZSU234"]

  /* UN Truppen */
  /* 27 - Luftabwehr  */	 ,["rhsgref_nat_ural_Zu23"]
  /* 28 - Kampfhelis	 */		,["LOP_ChDKZ_Mi8MTV3_UPK23"]
  /* 29 - Offroader 	 */	,["rhsgref_nat_van"]
  /* 30 - BMPs  */		,["rhsgref_nat_btr70"]
  /* 31 - UAZs  */		,["rhsgref_nat_uaz","rhsgref_nat_uaz_open","rhsgref_nat_uaz_dshkm","rhsgref_nat_uaz_ags"]
  /* 32 - BTRs */		,["rhsgref_nat_btr70"]
  /* 33 - Arty */	,["LOP_ChDKZ_BM21"]
  /* 34 - Transportheli */ 		,["LOP_ChDKZ_Mi8MT_Cargo"]
  /* 35 - LKWs  */	,["rhsgref_nat_van","rhsgref_nat_ural","rhsgref_nat_ural_open"]

  /* Zivile Fahrzeuge */
  /* 36 - Zivile Vehikel */	,["LOP_CHR_Civ_Landrover","LOP_CHR_Civ_Offroad","LOP_CHR_Civ_UAZ","LOP_CHR_Civ_Ural","LOP_CHR_Civ_Ural_Open","C_Truck_02_transport_F","C_Van_01_box_F","C_Van_01_fuel_F"]
  /* IDAP Fahrzeuge */
  /* 37 - IDAP Vehikel */	,["C_IDAP_Truck_02_transport_F","C_IDAP_Truck_02_F","C_IDAP_Truck_02_water_F","C_IDAP_Offroad_01_F"]
  /* 38 - LSF Vehikel */,["rhsgref_nat_ural_work","rhsgref_nat_ural_work_open"]

];


verstaerkungsarten = [
  ["spaeher", 0, 900, 2],
  ["fusstrupp", 0, 120, 1],
  ["at_trupp", 0, 120, 2],
  ["aa_trupp", 0, 300, 2],
  ["trupp_mot", 0, 0, 2],
  ["trupp_mech", 0, 180, 4],
  ["panzer", 0, 180, 5],
  ["fallschirmjaeger", 0, 900, 2],
  ["mobile_luftabwehr", 0, 900, 3],
  ["drehfluegler", 0, 900, 8],
  ["starrfluegler", 0, 1200, 10],
  ["artillerie", 0, 3600, 8],
  ["funkmobil", 0, 1200, 2]
];


ziviarray = [
  "LIB_CIV_Citizen_1",
  "LIB_CIV_Citizen_2",
  "LIB_CIV_Citizen_3",
  "LIB_CIV_Citizen_4",
  "LIB_CIV_Citizen_5",
  "LIB_CIV_Citizen_6",
  "LIB_CIV_Citizen_7",
  "LIB_CIV_Citizen_8"
];


//Feind verfügt bei gewisser stärke und Phase potenziell über dies und das

feindkraft_arsenal = [
  [1, [["_spaeher", 0],["_stiefel", 0],["_motorisierte", 0],["_mechanisierte", 50],["_befestigte", 50],["_panzer", -1],["_luftabwehr", -1],["_drehfluegler", -1],["_starrfluegler", -1],["_funker", 0]]],
  [2, [["_spaeher", 0],["_stiefel", 0],["_motorisierte", 0],["_mechanisierte", 50],["_befestigte", 40],["_panzer", 90],["_luftabwehr", 80],["_drehfluegler", -1],["_starrfluegler", -1],["_funker", 0]]],
  [3, [["_spaeher", 0],["_stiefel", 0],["_motorisierte", 0],["_mechanisierte", 40],["_befestigte", 30],["_panzer", 60],["_luftabwehr", 70],["_drehfluegler", 80],["_starrfluegler", -1],["_funker", 0]]],
  [4, [["_spaeher", 0],["_stiefel", 0],["_motorisierte", 0],["_mechanisierte", 30],["_befestigte", 30],["_panzer", 40],["_luftabwehr", 50],["_drehfluegler", 50],["_starrfluegler", 60],["_funker", 0]]],
  [5, [["_spaeher", 0],["_stiefel", 0],["_motorisierte", 0],["_mechanisierte", 30],["_befestigte", 20],["_panzer", 40],["_luftabwehr", 50],["_drehfluegler", 50],["_starrfluegler", 70],["_funker", 0]]],
  [6, [["_spaeher", 0],["_stiefel", 0],["_motorisierte", 0],["_mechanisierte", 60],["_befestigte", 40],["_panzer", 60],["_luftabwehr", 70],["_drehfluegler", 70],["_starrfluegler", 80],["_funker", 0]]]
];

/*
	Waka - Loadouts
*/

Armory =  [
  //0 - Ami Loadouts
  [
    ["USMC Roles", "\A3\ui_f\data\map\markers\flags\usa_ca.paa"],
    //Loadouts der Rollen hier unten in selben Format einfügen
    [

      [
        ["Squad Leader", getText (configfile >> "CfgWeapons" >> "ACRE_PRC152" >> "picture")],
        [["rhs_weap_m4a1_carryhandle_grip3","","","rhsusf_acc_acog",[],[],"rhsusf_acc_grip3"],[],["rhsusf_weap_m1911a1","","","",[],[],""],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",1],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_squadleader",[["rhsusf_lwh_helmet_marpatwd_headset_blk",1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1],["rhsusf_mag_7x45acp_MHP",2,6],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["HandGrenade",1,1],["SmokeShell",1,1],["ACRE_PRC152",1]]],[],"rhs_8point_marpatwd","rhs_googles_black",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]]
      ],
			[
        ["Team Leader", getText (configfile >> "CfgWeapons" >> "rhs_weap_m4a1_carryhandle_m203" >> "picture")],
        [["rhs_weap_m4a1_carryhandle_m203","","","rhsusf_acc_acog",[],[],""],[],["rhsusf_weap_m1911a1","","","",[],[],""],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",1],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_teamleader",[["rhsusf_lwh_helmet_marpatwd_headset_blk",1],["SmokeShellBlue",1,1],["SmokeShellRed",1,1],["rhsusf_mag_7x45acp_MHP",2,6],["rhs_mag_30Rnd_556x45_M855A1_Stanag",6,30],["HandGrenade",1,1],["SmokeShell",1,1],["ACRE_PRC152",1]]],["rhsusf_assault_eagleaiii_coy",[["rhs_mag_M441_HE",6,1],["rhs_mag_M433_HEDP",4,1],["1Rnd_SmokeRed_Grenade_shell",2,1]]],"rhs_8point_marpatwd","rhs_googles_black",["ACE_Vector","","","",[],[],""],["ItemMap","ItemGPS","","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Rifleman", getText (configfile >> "CfgWeapons" >> "rhs_weap_m16a4" >> "picture")],
        [["rhs_weap_m16a4","","","rhsusf_acc_acog",[],[],""],[],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_rifleman",[["rhsusf_lwh_helmet_marpatwd",1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["HandGrenade",2,1],["SmokeShell",2,1]]],[],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Pointman (M72A7)", getText (configfile >> "CfgWeapons" >> "rhs_weap_m72a7" >> "picture")],
        [["rhs_weap_m4","","","rhsusf_acc_compm4",[],[],""],["rhs_weap_m72a7","","","",["rhs_m72a7_mag",1],[],""],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_rifleman",[["rhsusf_lwh_helmet_marpatwd",1],["HandGrenade",2,1],["SmokeShell",1,1],["ACE_M84",1,1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30]]],[],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Rifleman (AT4)", getText (configfile >> "CfgWeapons" >> "rhs_weap_M136" >> "picture")],
        [["rhs_weap_m16a4","","","rhsusf_acc_compm4",[],[],""],["rhs_weap_M136","","","",["rhs_m136_mag",1],[],""],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_rifleman",[["rhsusf_lwh_helmet_marpatwd",1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["HandGrenade",2,1],["SmokeShell",2,1]]],[],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Machine gunner (SAW)", getText (configfile >> "CfgWeapons" >> "rhs_weap_m249_pip" >> "picture")],
        [["rhs_weap_m249_pip","","","rhsusf_acc_ELCAN",[],[],""],[],["rhsusf_weap_m9","","","",[],[],""],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_mg",[["rhsusf_lwh_helmet_marpatwd",1],["HandGrenade",2,1],["SmokeShell",2,1],["rhsusf_100Rnd_556x45_soft_pouch_coyote",1,200],["rhsusf_mag_15Rnd_9x19_FMJ",3,15]]],["rhsusf_assault_eagleaiii_coy",[["ACE_EntrenchingTool",1],["rhsusf_100Rnd_556x45_soft_pouch_coyote",3,200]]],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Machine gunner (M240)", getText (configfile >> "CfgWeapons" >> "rhs_weap_m240B" >> "picture")],
        [["rhs_weap_m240B","","","",["rhsusf_100Rnd_762x51_m80a1epr",100],[],""],[],["rhsusf_weap_m9","","","",[],[],""],["rhs_uniform_FROG01_wd",[["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1],["ACRE_PRC343",1]]],["rhsusf_spc_mg",[["rhsusf_lwh_helmet_marpatwd",1],["HandGrenade",2,1],["SmokeShell",2,1],["rhsusf_mag_15Rnd_9x19_FMJ",3,15],["rhsusf_100Rnd_762x51_m80a1epr",1,100]]],["rhsusf_assault_eagleaiii_coy",[["ACE_EntrenchingTool",1],["rhsusf_100Rnd_762x51_m80a1epr",3,100]]],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Auto-Rifleman (M27 IAR)", getText (configfile >> "CfgWeapons" >> "rhs_weap_m27iar" >> "picture")],
        [["rhs_weap_m27iar","","","rhsusf_acc_su230",[],[],"rhsusf_acc_grip1"],[],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_iar",[["rhsusf_lwh_helmet_marpatwd",1],["HandGrenade",2,1],["SmokeShell",2,1],["rhs_mag_30Rnd_556x45_M855A1_PMAG",7,30]]],["rhsusf_assault_eagleaiii_coy",[["ACE_EntrenchingTool",1],["rhs_mag_100Rnd_556x45_M855A1_cmag",4,100]]],"rhs_8point_marpatwd","rhs_googles_black",["ACE_VectorDay","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
      ],
      [
        ["DMR", getText (configfile >> "CfgWeapons" >> "rhs_weap_m14ebrri" >> "picture")],
        [["rhs_weap_m14ebrri","","","rhsusf_acc_leupoldmk4",[],[],"rhsusf_acc_harris_bipod"],[],["rhsusf_weap_m9","","","",[],[],""],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_sniper",[["rhsusf_lwh_helmet_marpatwd",1],["HandGrenade",2,1],["SmokeShell",2,1],["20Rnd_762x51_Mag",5,20],["rhsusf_mag_15Rnd_9x19_FMJ",2,15]]],[],"rhs_8point_marpatwd","rhs_googles_black",["ACE_VectorDay","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
      ],
      [
        ["CFR Bravo", "\z\ace\addons\medical_gui\ui\cross_T_9.paa"],
        [["rhs_weap_m4a1_carryhandle_grip3","","","rhsusf_acc_eotech_552",[],[],"rhsusf_acc_grip3"],[],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_corpsman",[["rhsusf_lwh_helmet_marpatwd",1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["HandGrenade",2,1],["SmokeShell",2,1]]],["rhsusf_assault_eagleaiii_coy",[["ACE_surgicalKit",1],["ACE_quikclot",15],["ACE_elasticBandage",5],["ACE_adenosine",2],["ACE_epinephrine",10],["ACE_morphine",10],["ACE_packingBandage",20],["ACE_tourniquet",4],["ACE_salineIV",6],["ACE_splint",8]]],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
        true
      ],
      [
        ["Radioman", getText (configfile >> "CfgWeapons" >> "ACRE_PRC117F" >> "picture")],
        [["rhs_weap_m4a1_carryhandle_grip3","","","rhsusf_acc_ACOG",[],[],"rhsusf_acc_grip3"],[],[],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_rifleman",[["rhsusf_lwh_helmet_marpatwd",1],["ACRE_PRC152",1],["rhs_mag_30Rnd_556x45_M855A1_Stanag",7,30],["HandGrenade",1,1],["SmokeShell",2,1]]],["rhsusf_assault_eagleaiii_coy",[["ACRE_PRC117F",1]]],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]]
      ],
      [
        ["Pilot", getText (configfile >> "CfgWeapons" >> "H_PilotHelmetHeli_B" >> "picture")],
        [["rhsusf_weap_MP7A2","","","",["rhsusf_mag_40Rnd_46x30_FMJ",0],[],""],[],[],["U_B_HeliPilotCoveralls",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1],["rhsusf_mag_40Rnd_46x30_FMJ",1,40]]],["V_TacVest_blk",[["ACRE_PRC152",1],["rhsusf_ANPVS_15",1],["rhsusf_mag_40Rnd_46x30_FMJ",5,40],["SmokeShellBlue",1,1],["B_IR_Grenade",1,1]]],[],"H_PilotHelmetHeli_B","",["Binocular","","","",[],[],""],["ItemMap","ItemGPS","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
        true
      ],
      [
        ["Sapper", getText (configfile >> "CfgWeapons" >> "rhs_weap_M590_8RD" >> "picture")],
        [["rhs_weap_M590_8RD","","","",[],[],""],[],["ACE_VMM3","","","",[],[],""],["rhs_uniform_FROG01_wd",[["ACRE_PRC343",1],["ACE_quikclot",6],["ACE_epinephrine",1],["ACE_morphine",1],["ACE_packingBandage",6],["ACE_tourniquet",2],["ACE_EarPlugs",1],["ACE_CableTie",3],["ACE_Canteen",1],["ACE_MRE_BeefStew",1]]],["rhsusf_spc_rifleman",[["rhsusf_lwh_helmet_marpatwd",1],["ACE_DefusalKit",1],["ACE_Clacker",1],["HandGrenade",1,1],["SmokeShell",1,1],["rhsusf_8Rnd_00Buck",3,8],["rhsusf_8Rnd_Slug",3,8]]],["rhsusf_assault_eagleaiii_coy",[["ACE_EntrenchingTool",1],["ACE_wirecutter",1],["ACE_Fortify",1],["ToolKit",1],["ClaymoreDirectionalMine_Remote_Mag",1,1],["rhsusf_8Rnd_Slug",3,8],["rhsusf_8Rnd_00Buck",3,8],["DemoCharge_Remote_Mag",2,1]]],"rhs_8point_marpatwd","rhs_googles_black",["Binocular","","","",[],[],""],["ItemMap","","ItemRadioAcreFlagged","ItemCompass","ItemWatch",""]],
        true
      ]
    ]
  ],
  //2 - Backpacks
  [
    ["USMC Backpacks", getText (configfile >> "CfgVehicles" >> "rhsusf_assault_eagleaiii_coy" >> "picture")],
    [
      [
        ["Backpack (Rifleman)", getText (configfile >> "CfgMagazines" >> "rhs_mag_30Rnd_556x45_M855A1_Stanag" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_Canteen",1],["ACE_EntrenchingTool",1],["ACE_Humanitarian_Ration",1],["ACE_MRE_MeatballsPasta",1],["ACE_WaterBottle",2],["rhs_mag_30Rnd_556x45_M855A1_Stanag",12]]]
      ],
      [
        ["Backpack (LMG)", getText (configfile >> "CfgMagazines" >> "rhsusf_100Rnd_556x45_soft_pouch_coyote" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_Canteen",1],["ACE_Humanitarian_Ration",1],["ACE_MRE_MeatballsPasta",1],["ACE_WaterBottle",2],["rhsusf_100Rnd_556x45_soft_pouch_coyote",2],["ACE_SpareBarrel",1]]]
      ],
      [
        ["Backpack (MMG)", getText (configfile >> "CfgMagazines" >> "rhsusf_100Rnd_762x51_m80a1epr" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_Canteen",1],["ACE_Humanitarian_Ration",1],["ACE_MRE_MeatballsPasta",1],["ACE_WaterBottle",2],["rhsusf_100Rnd_762x51_m80a1epr",4],["ACE_SpareBarrel",1]]]
      ],
      [
        ["Backpack (Food)", getText (configfile >> "CfgWeapons" >> "ACE_MRE_MeatballsPasta" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_Canteen",12],["ACE_MRE_MeatballsPasta",12]]]
      ],
      [
        ["Backpack (CFR)", getText (configfile >> "CfgWeapons" >> "ACE_surgicalKit" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_packingBandage",20],["ACE_elasticBandage",10],["ACE_morphine",10],["ACE_epinephrine",10],["ACE_tourniquet",4],["ACE_adenosine",2],["ACE_salineIV_250",1],["ACE_salineIV_500",1],["ACE_salineIV",6],["ACE_quikclot",20],["ACE_surgicalKit",1]]]
      ],
      [
        ["Backpack (Sapper)", getText (configfile >> "CfgWeapons" >> "ToolKit" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_Fortify",1],["ACE_wirecutter",1],["ACE_Sandbag_empty",6],["ACE_SpraypaintGreen",2],["ToolKit",1]]]
      ],
      [
        ["Backpack (Ordnance)", getText (configfile >> "CfgMagazines" >> "ClaymoreDirectionalMine_Remote_Mag" >> "picture")],
        ["rhsusf_assault_eagleaiii_coy",[["ACE_DefusalKit",1],["ACE_EntrenchingTool",1],["SatchelCharge_Remote_Mag",1,1],["ClaymoreDirectionalMine_Remote_Mag",2,1],[["ACE_VMH3","","","",[],[],""],1]]]
      ],
      [
        ["Mark 19 (Gun)", getText (configfile >> "CfgVehicles" >> "RHS_Mk19_Gun_Bag" >> "picture")],
        ["RHS_Mk19_Gun_Bag",[]]
      ],
      [
        ["Mark 19 (Tripod)", getText (configfile >> "CfgVehicles" >> "RHS_Mk19_Tripod_Bag" >> "picture")],
        ["RHS_Mk19_Tripod_Bag",[]]
      ],
      [
        ["M2 (Gun)", getText (configfile >> "CfgVehicles" >> "RHS_M2_Gun_Bag" >> "picture")],
        ["RHS_M2_Gun_Bag",[]]
      ],
      [
        ["M2 (Mini-Tripod)", getText (configfile >> "CfgVehicles" >> "RHS_M2_MiniTripod_Bag" >> "picture")],
        ["RHS_M2_MiniTripod_Bag",[]]
      ],
      [
        ["M2 (Tripod)", getText (configfile >> "CfgVehicles" >> "RHS_M2_Tripod_Bag" >> "picture")],
        ["RHS_M2_Tripod_Bag",[]]
      ],
      [
        ["No Backpack", ""],
        []
      ]
    ]
  ]
];


stellung_1 = [[["Land_fortified_nest_big_EP1",[-0.92868,-2.45487,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_MG",[-0.0107422,1.18604,0.17978],0,0,352.601,"Auto"],["LOP_ChDKZ_Infantry_MG",[-2.99854,0.961426,0.17978],0,0,352.601,"Auto"],["LOP_ChDKZ_Infantry_Marksman",[2.95654,-3.26465,0.179779],0,-0,105.85,"Auto"],["LOP_ChDKZ_Infantry_MG_Asst",[-2.6958,-5.62646,0.179779],0,-0,98.4501,"Auto"]],[],[]];

stellung_2 = [[["Land_fortified_nest_big_EP1",[-0.92868,-2.45487,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_MG",[-0.0107422,1.18604,0.17978],0,0,352.601,"Auto"],["LOP_ChDKZ_Infantry_MG",[-2.99854,0.961426,0.17978],0,0,352.601,"Auto"],["LOP_ChDKZ_Infantry_Marksman",[2.95654,-3.26465,0.179779],0,-0,105.85,"Auto"],["LOP_ChDKZ_Infantry_MG_Asst",[-2.6958,-5.62646,0.179779],0,-0,98.4501,"Auto"]],[],[]];

stellung_3 = [[["WarfareBCamp",[0.285077,2.3077,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_MG_Asst",[-0.790527,-2.76074,0.156612],0,0,180,"Auto"],["LOP_ChDKZ_Infantry_MG",[-1.72119,2.54395,0.322909],0,0,2.25303,"Auto"],["LOP_ChDKZ_Infantry_MG",[2.14893,2.54395,0.345487],0,0,2.25303,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_2",[2.15479,-2.97949,0.152356],0,-0,135.272,"Auto"]],[],[]];

stellung_4 = [[["WarfareBCamp",[0.285077,2.3077,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_MG_Asst",[-0.790527,-2.76074,0.156612],0,0,180,"Auto"],["LOP_ChDKZ_Infantry_MG",[-1.72119,2.54395,0.322909],0,0,2.25303,"Auto"],["LOP_ChDKZ_Infantry_MG",[2.14893,2.54395,0.345487],0,0,2.25303,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_2",[2.15479,-2.97949,0.152356],0,-0,135.272,"Auto"]],[],[]];

stellung_5 = [[["WarfareBCamp",[0.285077,2.3077,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_MG_Asst",[-0.790527,-2.76074,0.156612],0,0,180,"Auto"],["LOP_ChDKZ_Infantry_MG",[-1.72119,2.54395,0.322909],0,0,2.25303,"Auto"],["LOP_ChDKZ_Infantry_MG",[2.14893,2.54395,0.345487],0,0,2.25303,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_2",[2.15479,-2.97949,0.152356],0,-0,135.272,"Auto"]],[],[]];

at_1 = [[["Land_fort_rampart_EP1",[5.53223,2.30115,0],0,0,285],["Land_fort_rampart_EP1",[-6.57373,2.55457,0],0,0,75],["Land_fort_rampart_EP1",[-0.453125,10.1757,0],0,0,180]],[["LOP_ChDKZ_BTR70",[-0.44657,2.727668,-0.0213523],-0.0355121,-0.0166354,4.80641e-005]],[],[],[]];

at_2 = [[["Land_fort_rampart_EP1",[-3.79639,0.634157,0],0,0,75],["Land_fort_rampart_EP1",[2.32422,8.25525,0],0,0,180],["Land_fort_rampart_EP1",[8.30957,0.380739,0],0,0,285]],[["LOP_ChDKZ_UAZ_SPG",[-0.0582609,1.0237437,0.000421047],0.28293,-0.0557951,345],["LOP_ChDKZ_UAZ_DshKM",[3.79281,0.0216924,1.000414848],0.22654,-0.0550429,14.9996]],[],[],[]];

at_3 = [[["Land_fort_rampart_EP1",[-4.49951,1.41785,0],0,0,75],["Land_fort_rampart_EP1",[1.62109,9.03894,0],0,0,180],["Land_fort_rampart_EP1",[7.60645,1.16443,0],0,0,285]],[["LOP_ChDKZ_UAZ_AGS",[-0.0582609,0.0353643,0.000906944],0.225674,1.0547475,345],["LOP_ChDKZ_UAZ_DshKM",[3.79281,0.0197393,1.000812531],0.227336,-0.0575522,14.9976]],[],[],[]];

at_4 = [[["Land_fort_rampart_EP1",[5.53223,2.30115,0],0,0,285],["Land_fort_rampart_EP1",[-6.57373,2.55457,0],0,0,75],["Land_fort_rampart_EP1",[-0.453125,10.1757,0],0,0,180]],[["LOP_ChDKZ_BTR60",[-0.44657,2.727668,-0.0213523],-0.0355121,-0.0166354,4.80641e-005]],[],[],[]];

aa_1 = [[["Land_fort_artillery_nest_EP1",[0.135742,9.42211,0],0,0,5.60216],["Land_fort_artillery_nest_EP1",[-0.197266,-3.14576,0],0,0,180]],[["LOP_ChDKZ_ZU23",[-0.0347021,7.14212,0],-2.15108e-005,8.42917e-006,180],["LOP_ChDKZ_ZU23",[-0.0410497,-1.81443,-0.00256205],6.69606e-006,-4.55504e-006,180]],[["LOP_ChDKZ_Infantry_Marksman",[4.41943,1.32178,0.00143909],0,-0,101.519,"Middle"],["LOP_ChDKZ_Infantry_GL",[-5.98633,-1.38428,0.00143909],0,0,247.274,"Middle"]],[],[]];

aa_2 = [[["Land_fort_artillery_nest_EP1",[0.135742,9.42211,0],0,0,5.60216],["Land_fort_artillery_nest_EP1",[-0.197266,-3.14576,0],0,0,180]],[["LOP_ChDKZ_ZU23",[-0.0347021,7.14212,0],-2.15108e-005,8.42917e-006,180],["LOP_ChDKZ_ZU23",[-0.0410497,-1.81443,-0.00256205],6.69606e-006,-4.55504e-006,180]],[["LOP_ChDKZ_Infantry_Marksman",[4.41943,1.32178,0.00143909],0,-0,101.519,"Middle"],["LOP_ChDKZ_Infantry_GL",[-5.98633,-1.38428,0.00143909],0,0,247.274,"Middle"]],[],[]];

aa_3 = [[["Land_fort_artillery_nest_EP1",[0.135742,9.42211,0],0,0,5.60216],["Land_fort_artillery_nest_EP1",[-0.197266,-3.14576,0],0,0,180]],[["LOP_ChDKZ_ZU23",[-0.0347021,7.14212,0],-2.15108e-005,8.42917e-006,180],["LOP_ChDKZ_ZU23",[-0.0410497,-1.81443,-0.00256205],6.69606e-006,-4.55504e-006,180]],[["LOP_ChDKZ_Infantry_Marksman",[4.41943,1.32178,0.00143909],0,-0,101.519,"Middle"],["LOP_ChDKZ_Infantry_GL",[-5.98633,-1.38428,0.00143909],0,0,247.274,"Middle"]],[],[]];

rb_1 = [[["Land_fortified_nest_small_EP1",[-0.58213,-0.73322,0],0,0,180],["Land_SandbagBarricade_01_hole_F",[2.6365,-1.86602,0],0,0,45],["Land_SandbagBarricade_01_half_F",[-3.9364,-1.6563,0],0,0,330],["Land_SandbagBarricade_01_hole_F",[-5.20334,-3.87677,0],0,0,270]],[],[["LOP_ChDKZ_Infantry_MG",[-0.0991211,-0.0322266,0.00143909],0,0,1.27498e-005,"Middle"],["LOP_ChDKZ_Infantry_MG_Asst",[-1.3335,-0.103516,0.00143909],0,0,1.27498e-005,"Middle"],["LOP_ChDKZ_Infantry_Rifleman_2",[2.53125,-3.29248,0.00143909],0,0,1.27498e-005,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_3",[-3.31006,-3.16309,0.00143909],0,0,1.27498e-005,"Auto"]],[],[]];

rb_2 = [[["Land_fortified_nest_small_EP1",[-1.08213,-1.23322,0],0,0,180],["Land_SandbagBarricade_01_hole_F",[2.30984,-1.09454,0],0,0,0],["Land_BagFence_Round_F",[-4.36121,-1.76994,0],0,0,180],["Land_SandbagBarricade_01_hole_F",[-6.51731,-2.65118,0],0,-0,120]],[],[["LOP_ChDKZ_Infantry_MG",[-0.0991211,-0.0322266,0.00143909],0,0,1.27498e-005,"Middle"],["LOP_ChDKZ_Infantry_MG_Asst",[-1.3335,-0.103516,0.00143909],0,0,1.27498e-005,"Middle"],["LOP_ChDKZ_Infantry_Rifleman_2",[2.78711,-3.3457,0.00143909],0,0,1.27498e-005,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_3",[-4.5166,-3.29883,0.00143909],0,0,1.27498e-005,"Auto"]],[],[]];

rb_3 = [[["Land_fortified_nest_small_EP1",[-0.58213,-0.73322,0],0,0,180],["Land_SandbagBarricade_01_hole_F",[2.6365,-1.86602,0],0,0,45],["Land_SandbagBarricade_01_half_F",[-3.9364,-1.6563,0],0,0,330],["Land_SandbagBarricade_01_hole_F",[-5.20334,-3.87677,0],0,0,270]],[],[["LOP_ChDKZ_Infantry_MG",[-0.0991211,-0.0322266,0.00143909],0,0,1.27498e-005,"Middle"],["LOP_ChDKZ_Infantry_MG_Asst",[-1.3335,-0.103516,0.00143909],0,0,1.27498e-005,"Middle"],["LOP_ChDKZ_Infantry_Rifleman_2",[2.53125,-3.29248,0.00143909],0,0,1.27498e-005,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_3",[-3.31006,-3.16309,0.00143909],0,0,1.27498e-005,"Auto"]],[],[]];

steilfeuer_1 = [[["Land_SandbagBarricade_01_hole_F",[-3.80149,-0.0774504,0],0,0,273.851],["Land_SandbagBarricade_01_half_F",[-3.52478,1.99653,0],0,0,283.328],["Land_SandbagBarricade_01_half_F",[-3.47107,-2.31988,0],0,0,254.218],["Land_fort_rampart_EP1",[1.66553,6.09314,0],0,0,180],["Land_fort_rampart_EP1",[1.55518,-5.7511,0],0,0,1.27498e-005],["Land_SandbagBarricade_01_hole_F",[7.10525,0.0675691,0],0,0,88.0194],["Land_SandbagBarricade_01_half_F",[7.05139,-2.20708,0],0,-0,97.1204],["Land_SandbagBarricade_01_half_F",[7.16516,2.44477,0],0,0,85.21]],[["rhs_2b14_82mm_msv",[0.0577393,0.13748,0.00396156],0.174749,-0.352641,179.999],["rhs_2b14_82mm_msv",[2.98108,0.136504,0.00396156],0.174749,-0.352641,179.999]],[["LOP_ChDKZ_Infantry_Marksman",[-2.65186,0.275391,0.00143909],0,0,244.91,"Auto"],["LOP_ChDKZ_Infantry_GL",[-1.78223,2.24023,0.00143909],0,0,261.009,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[5.38379,0.375977,0.00143909],0,-0,95.4247,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[5.42969,-1.16113,0.00143909],0,0,80.3232,"Auto"]],[],[]];

steilfeuer_2 = [[["Land_SandbagBarricade_01_hole_F",[-3.80149,-0.0774504,0],0,0,273.851],["Land_SandbagBarricade_01_half_F",[-3.52478,1.99653,0],0,0,283.328],["Land_SandbagBarricade_01_half_F",[-3.47107,-2.31988,0],0,0,254.218],["Land_fort_rampart_EP1",[1.66553,6.09314,0],0,0,180],["Land_fort_rampart_EP1",[1.55518,-5.7511,0],0,0,1.27498e-005],["Land_SandbagBarricade_01_hole_F",[7.10525,0.0675691,0],0,0,88.0194],["Land_SandbagBarricade_01_half_F",[7.05139,-2.20708,0],0,-0,97.1204],["Land_SandbagBarricade_01_half_F",[7.16516,2.44477,0],0,0,85.21]],[["rhs_2b14_82mm_msv",[0.0577393,0.13748,0.00396156],0.174749,-0.352641,179.999],["rhs_2b14_82mm_msv",[2.98108,0.136504,0.00396156],0.174749,-0.352641,179.999]],[["LOP_ChDKZ_Infantry_Marksman",[-2.65186,0.275391,0.00143909],0,0,244.91,"Auto"],["LOP_ChDKZ_Infantry_GL",[-1.78223,2.24023,0.00143909],0,0,261.009,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[5.38379,0.375977,0.00143909],0,-0,95.4247,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[5.42969,-1.16113,0.00143909],0,0,80.3232,"Auto"]],[],[]];

kdo_bunker_1 = [[["WarfareBDepot",[-1.47056,-0.079847,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_Commander",[-0.428711,0.844238,0.519063],0,0,26.9173,"Auto"],["LOP_ChDKZ_Infantry_MG",[5.72412,1.27881,0.95535],0,-0,117.125,"Auto"],["LOP_ChDKZ_Infantry_MG_Asst",[-4.57715,5.5459,0.95535],0,0,343.354,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[-5.63623,-4.61914,0.95535],0,0,272.483,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_2",[3.81982,-5.78076,2.98697],0,0,214.935,"Auto"],["LOP_ChDKZ_Infantry_Marksman",[-5.72412,4.41455,2.98697],0,0,274.746,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[5.58252,-5.146,2.98697],0,-0,92.003,"Auto"],["LOP_ChDKZ_Infantry_MG",[5.03662,5.86523,2.98697],0,0,357.229,"Auto"]],[],[]];

kdo_bunker_2 = [[["WarfareBDepot",[-1.47056,-0.079847,0],0,0,180]],[],[["LOP_ChDKZ_Infantry_Commander",[-0.428711,0.844238,0.519063],0,0,26.9173,"Auto"],["LOP_ChDKZ_Infantry_MG",[5.72412,1.27881,0.95535],0,-0,117.125,"Auto"],["LOP_ChDKZ_Infantry_MG_Asst",[-4.57715,5.5459,0.95535],0,0,343.354,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[-5.63623,-4.61914,0.95535],0,0,272.483,"Auto"],["LOP_ChDKZ_Infantry_Rifleman_2",[3.81982,-5.78076,2.98697],0,0,214.935,"Auto"],["LOP_ChDKZ_Infantry_Marksman",[-5.72412,4.41455,2.98697],0,0,274.746,"Auto"],["LOP_ChDKZ_Infantry_Rifleman",[5.58252,-5.146,2.98697],0,-0,92.003,"Auto"],["LOP_ChDKZ_Infantry_MG",[5.03662,5.86523,2.98697],0,0,357.229,"Auto"]],[],[]];
