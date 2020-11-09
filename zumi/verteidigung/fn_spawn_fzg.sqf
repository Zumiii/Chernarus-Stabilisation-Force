if !isServer exitWith {};

params ["_position", ["_side", independent], "_typ", ["_cargo", []], ["_status", "CAN_COLLIDE"], ["_driver", ""]];


private _units = if (toupper (typename _cargo) == "STRING") then {_cargo call zumi_fnc_grp_namen} else {_cargo};


if (_status == "FLY") then {_position set [2,((_position select 2) + 120)]};

_veh = createVehicle [_typ, [0,0,0], [], 0, _status];
_veh setPos _position;
if !(_status == "FLY") then {
  _roads = _position nearRoads 15;
  if (count _roads > 0) then {
    _veh setDir getDir ((roadsConnectedTo (_roads select 0)) select 0);
  } else {
    _veh setDir random 360;
  };
};
if ((_status isEqualTo "FLY") && (_sim IN ["airplane","airplanex"])) then {
	_veh setVelocity [70*(sin (getDir _veh)), 70*(cos (getDir _veh)), 0];
};
_grp = createGroup _side;
_sim = getText(configFile >> "CfgVehicles" >> _typ >> "simulation");
_crewtyp = if (_driver isEqualTo "") then {
  getText (configFile >> "CfgVehicles" >> _typ >> "crew")
} else {
  _driver
};

if ((_veh emptyPositions "driver") > 0) then {
  private _unit = _grp createUnit [_crewtyp, [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
  _unit assignasDriver _veh;
	_unit moveinDriver _veh;

};

if ((_veh emptyPositions "commander") > 0) then {
	private _unit = _grp createUnit [_crewtyp, [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
  _unit assignasCommander _veh;
	_unit moveinCommander _veh;
};

if ((_veh emptyPositions "gunner") > 0) then {
  private _unit = _grp createUnit [_crewtyp, [0,0,0], [], 0, "CAN_COLLIDE"];
  _unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
  _unit assignasGunner _veh;
	_unit moveinGunner _veh;
};


_grp addVehicle _veh;




if (count _units < 1) exitWith {
  [_grp, _veh];
};

for "_i" from 0 to (count _units) - 1 do {
  if ((_veh emptyPositions "cargo") > 0) then {
  	private _unit = _grp createUnit [_units select _i, [0,0,0], [], 0, "CAN_COLLIDE"];
    _unit setSkill ["aimingAccuracy", aimingAccuracy];
  	_unit setSkill ["aimingShake", aimingShake];
  	_unit setSkill ["aimingSpeed", aimingSpeed];
  	_unit setSkill ["spotDistance", spotDistance];
  	_unit setSkill ["spotTime", spotTime];
  	_unit setSkill ["courage", courage];
  	_unit setSkill ["reloadSpeed", reloadSpeed];
  	_unit setSkill ["commanding", commanding];
  	_unit moveInCargo _veh;
  };
};

[_grp, _veh];
