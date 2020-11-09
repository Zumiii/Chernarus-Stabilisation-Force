/*

  Diese Funktion konkretisiert die zufälligen Begegnungen abhängig von Missionsphase und Spannung.

  Parameter:
  - Phase (Skalar)
  - Spannung (Skalar)

*/

if !isServer exitWith {};

params ["_phase","_spannung", "_count_villages"];



//Lege Häufigkeit aufgrund Phase und Spannung fest, sowie Chance auf Absitzen


_idap_count = switch _phase do {
  case 1 : { [1,2,0.15] };
  case 2 : { [2,3,0.15] };
  case 3 : { [0,0,0] };
  case 4 : { [0,0,0] };
  case 5 : { [1,2,0] };
  case 6 : { [0,0,0] };
  default { [0,0,0] };
};

_anp_pol_count = switch _phase do {
  case 1 : { [1,3,0.25] };
  case 2 : { [1,2,0.15] };
  case 3 : { [1,2,0.15] };
  case 4 : { [1,2,0.15] };
  case 5 : { [2,3,0.15] };
  case 6 : { [1,2,0.15] };
  default { [0,0,0] };
};


_anp_mil_count = switch _phase do {
  case 1 : { [0,0,0] };
  case 2 : { [1,2,0.25] };
  case 3 : { [2,3,0.25] };
  case 4 : { [1,3,0.25] };
  case 5 : { [3,5,0.25] };
  case 6 : { [1,4,0.25] };
  default { [0,0,0] };
};

_un_count = switch _phase do {
  case 1 : { [0,0,0] };
  case 2 : { [1,3,0.25] };
  case 3 : { [0,0,0] };
  case 4 : { [0,0,0] };
  case 5 : { [4,7,0.25] };
  case 6 : { [0,0,0] };
  default { [0,0,0] };
};

_smug_count = switch _phase do {
  case 1 : { [1,2,0.25] };
  case 2 : { [1,3,0.25] };
  case 3 : { [1,3,0.25] };
  case 4 : { [1,2,0.25] };
  case 5 : { [1,2,0.25] };
  case 6 : { [1,2,0.25] };
  default { [0,0,0] };
};

_terr_count = switch _phase do {
  case 1 : { [1,2,0]; };
  case 2 : { [1,2,0]; };
  case 3 : { [1,2,0]; };
  case 4 : { [1,2,0]; };
  case 5 : { [2,3,0]; };
  case 6 : { [1,2,0]; };
  default { [0,0,0] };
};

_miliz_count = switch _phase do {
  case 1 : { [2,5,0.3] };
  case 2 : { [3,5,0.3] };
  case 3 : { [4,5,0.3] };
  case 4 : { [3,4,0.3] };
  case 5 : { [7,9,0.25] };
  case 6 : { [2,4,0.3] };
  default { [0,0,0] };
};

_tak_count = switch _phase do {
  case 1 : { [0,0,0] };
  case 2 : { [0,0,0] };
  case 3 : { [0,0,0] };
  case 4 : { [2,5,0.25] };
  case 5 : { [7,9,0.25] };
  case 6 : { [1,5,0.25] };
  default { [0,0,0] };
};

_lsf_count = switch _phase do {
  case 1 : { [1,3,0.4] };
  case 2 : { [1,3,0.3] };
  case 3 : { [1,2,0.3] };
  case 4 : { [1,3,0.3] };
  case 5 : { [5,8,0.25] };
  case 6 : { [1,2,0.3] };
  default { [0,0,0] };
};

_zwischentotal = 0;
{
  _zwischentotal = _zwischentotal + (_x select 1);
} forEach [_idap_count, _anp_pol_count, _anp_mil_count, _un_count, _smug_count, _terr_count, _miliz_count, _tak_count, _lsf_count];

_civ_count = [3, ceil (linearConversion [35, 43, _zwischentotal, 14, 8, true]), 0.3];

//Fahrzeugtypen festlegen
_anp_pol_fzg = switch _phase do {
  case 1 : {
    [2]
  };
  case 2 : {
    [2]
  };
  case 3 : {
    [2]
  };
  case 4 : {
    [2]
  };
  case 5 : {
    [2]
  };
  case 6 : {
    [2]
  };
};

_anp_mil_fzg = switch _phase do {
  case 1 : {
    [4,5,9]
  };
  case 2 : {
    [4,5,9]
  };
  case 3 : {
    [4,9]
  };
  case 4 : {
    [4,9]
  };
  case 5 : {
    [4,5,9]
  };
  case 6 : {
    [3,5,9]
  };
};

_miliz_fzg = switch _phase do {
  case 1 : {
    [14,38]
  };
  case 2 : {
    [14,36]
  };
  case 3 : {
    [14,21,38]
  };
  case 4 : {
    [14,15,21,38]
  };
  case 5 : {
    [14,15,16,21,38]
  };
  case 6 : {
    [14,15,16,21,38]
  };
};

_tak_fzg = switch _phase do {
  case 1 : {
    [17,18,22]
  };
  case 2 : {
    [17,18,22]
  };
  case 3 : {
    [17,18,22]
  };
  case 4 : {
    [17,18,22]
  };
  case 5 : {
    [12,17,18,21,22]
  };
  case 6 : {
    [12,17,18,20,21,22]
  };
};

//Versehe mit Chance, zu Fuss unterwegs zu sein
_temp = [
  [_civ_count, civilian, [36], "civ", (_civ_count select 2)],
  [_idap_count, civilian, [37], "idap", (_idap_count select 2)],
  [_anp_pol_count, west, [2], "pol", (_anp_pol_count select 2)],
  [_anp_mil_count, west, _anp_mil_fzg, "mil", (_anp_mil_count select 2)],
  [_un_count, independent, [29,30,35,31], "un", (_un_count select 2)],
  [_smug_count, east, [36], "smug", (_smug_count select 2)],
  [_terr_count, east, [36], "terr", (_terr_count select 2)],
  [_miliz_count, east, _miliz_fzg, "miliz", (_miliz_count select 2)],
  [_tak_count, east, _tak_fzg, "tak", (_tak_count select 2)],
  [_lsf_count, independent, [38], "lsf", (_lsf_count select 2)]
];

private _return = [];
for "_i" from 0 to (count _temp)-1 do {
  if ((((_temp select _i) select 0) select 1) > 0) then {
    for "_j" from 1 to (((_temp select _i) select 0) select 1) do {
      private _element = [_spannung, ((_temp select _i) select 1), ((_temp select _i) select 2), ((_temp select _i) select 3), ((_temp select _i) select 4)] call zumi_fnc_dyn_definiere;
      _return pushBack _element;
    };
  };
};

_return call BIS_fnc_arrayShuffle;

_return;
