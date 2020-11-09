/*

  Diese Funktion spawnt Minen an gewünschter Stelle

*/

if !isServer exitWith {};

params ["_pos", ["_rad", 50], ["_anzahl", 15], ["_abstand", 10], ["_typ", "mixed"], ["_modus", 1], ["_revealside", [west]], ["_noclip", false], ["_strasse", false], ["_wasser", false], ["_wald", false]];

_minen = [];

//Suche position
_posarray = [_pos, _rad, _modus, _anzahl, _abstand, 2, 0.45, _noclip, _strasse, _wasser, _wald] call zumi_fnc_rnd_pos;


if ((count _posarray) < 1) exitwith {
  if (debug) then {
    systemChat "Keine Position für das Minenfeld";
  };
  _minen;
};

//TODO
//Land_WW2_BET_Achtung_Minen einbauen ev

switch _typ do {
  case "mixed" : {
    for "_i" from 0 to (count _posarray) - 1 do {
      _mine = createMine [selectRandom ["APERSMine","ATMine"], (_posarray select _i), [], 0];
			_minen pushBack _mine;
      _mine setDir random 360;
      _mine setVectorUp surfaceNormal (position _mine);
      {
        _x revealMine _mine;
      } forEach _revealside;
    };
  };
  case "ap" : {
    for "_i" from 0 to (count _posarray) - 1 do {
      _mine = createMine ["APERSMine", (_posarray select _i), [], 0];
			_minen pushBack _mine;
      _mine setDir random 360;
      _mine setVectorUp surfaceNormal (position _mine);
      {
        _x revealMine _mine;
      } forEach _revealside;
    };
  };
  case "at" : {
    for "_i" from 0 to (count _posarray) - 1 do {
      _mine = createMine ["ATMine", (_posarray select _i), [], 0];
			_minen pushBack _mine;
      _mine setDir random 360;
      _mine setVectorUp surfaceNormal (position _mine);
      {
        _x revealMine _mine;
      } forEach _revealside;
    };
  };
};

_minen;
