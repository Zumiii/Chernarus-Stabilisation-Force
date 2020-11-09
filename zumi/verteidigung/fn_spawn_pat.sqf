if !isServer exitWith {};

params ["_position",["_side",independent],"_typ",["_rad",150],["_timeout",[5,10,15]]];

private ["_grp","_unit","_units","_wp_anzahl"];

if (isNil "bot_skill") then {bot_skill = 0.5};

private _units = if (toupper (typename _typ) == "STRING") then {_typ call zumi_fnc_grp_namen} else {_typ};
_grp = createGroup _side;

if (count _units == 0 || isNull _grp) exitWith {};

for "_i" from 0 to (count _units) - 1 do {
	_unit = _grp createUnit [_units select _i, [0,0,0], [], 0, "CAN_COLLIDE"];
	_unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
	_unit setPosATL _position;
	_unit setPos formationPosition _unit;
};

_wp_anzahl = (round (_rad / 50) max 3) min 6;

[_grp, _position, _rad, _wp_anzahl, "MOVE", "SAFE", "YELLOW", "LIMITED", "STAG COLUMN", "", _timeout] call CBA_fnc_taskPatrol;

_grp
