/*

  Diese Funktion retourniert ein der Side und Phase sowie Spannung entsprechendes Fahrzeug mit passenden aufgesessenen Einheiten

  Parameter:
  - Spannung (Skalar)
  - Side (text)
  - Auswählbare Fahrzeuge (Array)

  Return:
  Array [_fzg (String oder Emptystring), _side, _fullcrew (Array zum Lokalisieren bzw. []), _markertyp, _markerfarbe, _art (String)]
*/

if !isServer exitWith {};

params ["_spannung","_side","_fzg_array","_art",["_chance", 0]];

private _return = [];
/*
  Die Fahrzeugtypen brauchen eine Wahrscheinlichkeitsgewichtung: Wir wollen nicht X random Panzer haben usw.
  Sinnvolle Gewichtung zwischen 0 und 1 (Skalar)
*/
 
_gewichtungs_und_fullcrew_array = [
  //ANP
  [0,0,"b_support","ColorWEST",[]],  [1,0,"b_air","ColorWEST",[]],  [2,0.75,"b_motor_inf","ColorWEST", format ["ANP_PHMV_Gruppe_%1", round random 2]],  [3,0.25,"b_mech_inf","ColorWEST", format ["ANP_APC_Gruppe_%1", round random 2]],  [4,0.75,"b_motor_inf","ColorWEST", format ["ANP_HMV_Gruppe_%1", round random 2]],
  [5,0.5,"b_mech_inf","ColorWEST", format ["ANP_APC_Gruppe_%1", round random 2]],  [6,0,"b_art","ColorWEST",[]],  [7,0,"b_air","ColorWEST",[]],  [8,0,"b_unknown","ColorWEST",[]],  [9,0.5,"b_motor_inf","ColorWEST", format ["ANP_LKW_Gruppe_%1", round random 2]],
  [10,0.25,"b_armor","ColorWEST",[]],  [11,0,"b_installation","ColorWEST",[]],
  //Milizen und Takis
  [12,0.1,"o_support","ColorEAST",[]],  [13,0,"o_air","ColorEAST",[]],  [14,0.5,"o_motor_inf","ColorEAST", format ["AXIS_Gruppe_%1", round random 5]],  [15,0.5,"o_motor_inf","ColorEAST", format ["AXIS_Gruppe_%1", round random 5]],  [16,0.25,"o_mech_inf","ColorEAST", format ["AXIS_APC_Gruppe_%1", round random 2]],
  [17,0.5,"o_motor_inf","ColorEAST", format ["AXIS_Gruppe_%1", round random 5]],  [18,0.25,"o_mech_inf","ColorEAST", format ["AXIS_APC_Gruppe_%1", round random 2]],
  [19,0,"o_art","ColorEAST",[]],  [20,0.1,"o_armor","ColorEAST",[]],  [21,0.5,"o_motor_inf","ColorEAST", format ["AXIS_LKW_Gruppe_%1", round random 2]],  [22,0.5,"o_motor_inf","ColorEAST", format ["AXIS_LKW_Gruppe_%1", round random 2]],  [23,0,"o_support","ColorEAST",[]],
  [24,0,"o_support","ColorEAST",[]],  [25,0,"o_support","ColorEAST",[]],
  [26,0,"o_support","ColorEAST",[]],
  //UN
  [27,0,"n_support","ColorGUER",[]],  [28,0,"n_air","ColorGUER",[]],  [29,0.25,"n_motor_inf","ColorGUER", format ["UN_Offroad_Gruppe_%1", round random 2]],  [30,0.25,"n_mech_inf","ColorGUER", format ["UN_BTR_Gruppe_%1", round random 2]],  [31,0.5,"n_motor_inf","ColorGUER", format ["UN_UAZ_Gruppe_%1", round random 2]],
  [32,0.3,"n_mech_inf","ColorGUER", format ["UN_BTR_Gruppe_%1", round random 2]],  [33,0,"n_art","ColorGUER",[]],
  [34,0,"n_air","ColorGUER",[]],  [35,0.75,"n_motor_inf","ColorGUER", format ["UN_LKW_Gruppe_%1", round random 2]],
  //Zivil
  [36,0.5,"c_car","ColorCIV",[]],
  //IDAP
  [37,0.5,"c_car","ColorCIV",[]],
  //LSF
  [38,0.5,"c_car","ColorGuer", format ["LSF_Gruppe_%1", round random 2]]
];



_tmp_elements = [];
_tmp_weights = [];
_fullcrew = [];

for "_i" from 0 to (count _fzg_array)-1 do {
  for "_j" from 0 to (count _gewichtungs_und_fullcrew_array)-1 do {
    if (((_fzg_array) select _i) == ((_gewichtungs_und_fullcrew_array select _j) select 0)) exitWith {
      _tmp_elements pushBack ((_gewichtungs_und_fullcrew_array select _j) select 0);
      _tmp_weights pushBack ((_gewichtungs_und_fullcrew_array select _j) select 1);
    };
  };
};

_fzg_klasse =  [_tmp_elements,_tmp_weights] call BIS_fnc_selectRandomWeighted;
_fzg = if (random 1 > _chance) then {
  ([_fzg_klasse] call zumi_fnc_fzg_namen) call bis_fnc_selectRandom
} else {
  "zu Fuss"
};

_return set [0, _fzg];
_return set [1, _side];
for "_k" from 0 to (count _gewichtungs_und_fullcrew_array)-1 do {
  if ((((_gewichtungs_und_fullcrew_array) select _k) select 0) isEqualto _fzg_klasse) exitWith {
    _fullcrew = (((_gewichtungs_und_fullcrew_array) select _k) select 4);
    _return set [2, _fullcrew];
    _return set [3, (((_gewichtungs_und_fullcrew_array) select _k) select 2)];
    _return set [4, (((_gewichtungs_und_fullcrew_array) select _k) select 3)];
    _return set [5, _art];
  };
};

_return;
