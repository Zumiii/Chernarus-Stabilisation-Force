if !isServer exitWith {};

private ["_position","_vehicle","_besatzungsart","_grp","_unit","_mobil"];

_position	= _this select 0;
_vehicle	= _this select 1;
_besatzungsart	= _this select 2;
_mobil	= _this select 3;

_grp = createGroup west;

if (typeOf _vehicle == "rhs_gaz66_r142_msv") then {[_vehicle,1] spawn RHS_fnc_gaz66_radioDeploy;};

if ((_vehicle emptyPositions "commander") > 0) then {
	_unit = _grp createUnit ["LOP_ChDKZ_Infantry_Crewman", _position, [], 25, "NONE"];
	_unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
	_unit moveinCommander _vehicle;
};

if ((_vehicle emptyPositions "gunner") > 0) then {
	_unit = _grp createUnit ["LOP_ChDKZ_Infantry_Crewman", _position, [], 25, "NONE"];
	_unit setSkill ["aimingAccuracy", aimingAccuracy];
	_unit setSkill ["aimingShake", aimingShake];
	_unit setSkill ["aimingSpeed", aimingSpeed];
	_unit setSkill ["spotDistance", spotDistance];
	_unit setSkill ["spotTime", spotTime];
	_unit setSkill ["courage", courage];
	_unit setSkill ["reloadSpeed", reloadSpeed];
	_unit setSkill ["commanding", commanding];
	_unit moveinGunner _vehicle;
};

if (_mobil) then {
	if ((_vehicle emptyPositions "driver") > 0) then {
		_unit = _grp createUnit ["LOP_ChDKZ_Infantry_Crewman", _position, [], 25, "NONE"];
		_unit setSkill ["aimingAccuracy", aimingAccuracy];
		_unit setSkill ["aimingShake", aimingShake];
		_unit setSkill ["aimingSpeed", aimingSpeed];
		_unit setSkill ["spotDistance", spotDistance];
		_unit setSkill ["spotTime", spotTime];
		_unit setSkill ["courage", courage];
		_unit setSkill ["reloadSpeed", reloadSpeed];
		_unit setSkill ["commanding", commanding];
		_unit moveinDriver _vehicle;
	};
};


_grp
