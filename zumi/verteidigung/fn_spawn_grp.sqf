/*

  Kurzbeschrieb:
  Dieses Skript spawnt eine Gruppe am gewünschten Ort
  ];
*/

if !isServer exitWith {};

params ["_position", ["_side", independent], "_typ"];

private ["_grp","_unit","_units"];


_units = if (toupper (typename _typ) == "STRING") then {_typ call zumi_fnc_grp_namen} else {_typ};
_grp = createGroup _side;

if (count _units == 0 || isNull _grp) exitWith {};

for "_i" from 0 to (count _units) - 1 do {
	private _unit = _grp createUnit [_units select _i, [0,0,0], [], 0, "CAN_COLLIDE"];
	_unit setPosATL _position;
	_unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
	_unit setPos (formationPosition _unit);
};


_grp
