/*

  Dieses Skript wählt abhängig von den Möglichkeiten des Feindes und der Art des Ziels eine Reaktion aus.

*/

if !isServer exitWith {};

params ["_ziel"];

private ["_threat","_steilfeuer","_class","_optionen","_return"];

_return = [];

_threat = getArray (configFile >> "CfgVehicles" >> typeOf _ziel >> "threat");

//Klassen sind: "Men", "Car", "Armored", "Air", "Support", "Static"
_class = getText (configFile >> "CfgVehicles" >> typeOf _ziel >> "vehicleClass");

//["Truppengattung",Wahrscheinlichkeit,dauer]
_optionen = switch _class do {
  case "Men" : {
    [["inf_fuss",0.5,1200,1],["inf_mot",0.25,900,1],["inf_mech",0.25,1200,2],["inf_stell",0,1],["panzer",0.15,1200,2],["panzerabwehr",0,600,2],["luftabwehr",0,600,2],["luftschlag",0.1,600,1],["kampfjets",0,600,1],["moerser",0.1,1600,2]]
  };
  case "Car" : {
    [["inf_fuss",0.15,1200,1],["inf_mot",0.5,900,1],["inf_mech",0.25,900,2],["inf_stell",0,600,1],["panzer",0.15,900,2],["panzerabwehr",0.05,300,2],["luftabwehr",0,600,2],["luftschlag",0.2,1600,1],["kampfjets",0,600,1],["moerser",0.1,1200,3]]
  };
  case "Armored" : {
    [["inf_fuss",0,600,1],["inf_mot",0,600,1],["inf_mech",0.15,600,3],["inf_stell",0,600,1],["panzer",0.5,600,2],["panzerabwehr",0.5,900,2],["luftabwehr",0,600,1],["luftschlag",0.4,900,2],["kampfjets",0.15,900,2],["steilfeuer",0.25,300,3]]
  };
  case "Air" : {
    [["inf_fuss",0,600,1],["inf_mot",0,600,1],["inf_mech",0.05,300,1],["inf_stell",0,600,1],["panzer",0,600,1],["panzerabwehr",0,600,1],["luftabwehr",0.75,1200,3],["luftschlag",0,1200,2],["kampfjets",0.25,1200,2],["steilfeuer",0,600,3]]
  };
  case "Support" : {
    [["inf_fuss",0.5,1600,1],["inf_mot",0.25,1200,1],["inf_mech",0.25,1200,1],["inf_stell",0,600,1],["panzer",0.15,900,1],["panzerabwehr",0.15,900,1],["luftabwehr",0.1,900,1],["luftschlag",0.1,900,1],["kampfjets",0.05,900,1],["moerser",0.15,900,3]]
  };
  case "Static" : {
    [["inf_fuss",0.5,1600,1],["inf_mot",0.25,1200,1],["inf_mech",0.15,1600,2],["inf_stell",0,600,1],["panzer",0.15,1200,2],["panzerabwehr",0.15,900,1],["luftabwehr",0,600,1],["luftschlag",0.15,1200,2],["kampfjets",0,600,1],["steilfeuer",0.15,1200,2]]
  };
  default {
    [["inf_fuss",0.5,1200,1],["inf_mot",0.25,1200,1],["inf_mech",0.15,1200,1],["inf_stell",0,600,1],["panzer",0.15,900,1],["panzerabwehr",0.15,900,1],["luftabwehr",0.1,900,1],["luftschlag",0.05,900,1],["kampfjets",0.05,900,1],["steilfeuer",0.15,900,2]]
  };
};

//Aktualisiere lebende Teile des Feindes
for "_i" from 0 to (count zumi_truppenteile) - 1 do {
	if (count (zumi_truppenteile select _i) > 0) then {
		_grps = [];
		{
			if (count (_x call CBA_fnc_getAlive) > 0) then {
				_grps pushBack _x;
			};
		} forEach (zumi_truppenteile select _i);
  	zumi_truppenteile set [_i, _grps];

	};
};

for "_i" from 0 to (count _optionen)-2 do {
  if (_i >= 7) exitwith {};
  if !((zumi_truppenteile select _i) isEqualTo []) then {
    _return pushBack [(_optionen select _i) select 0,(_optionen select _i) select 2];
    _return pushBack ((_optionen select _i) select 1);
  };
};
//Prüfe, ob Steilfeuer möglich ist, falls Chance > 0
if ((((_optionen select 9) select 1) > 0) && (((_optionen select 9) select 0) IN ["moerser","steilfeuer"])) then {
  if ([((_optionen select 9) select 0)] call zumi_fnc_steilfeuerbereitschaft) then {
    _return pushBack [(_optionen select 9) select 0,(_optionen select 9) select 2,(_optionen select 9) select 3];
    _return pushBack ((_optionen select 9) select 1);
  };
};

if ((count _return) < 1) exitwith {
  _return = [];
  _return;
};

_return = (_return call BIS_fnc_selectRandomWeighted);

_return;
