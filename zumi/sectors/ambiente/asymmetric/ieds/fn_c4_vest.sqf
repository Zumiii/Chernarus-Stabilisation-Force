

params ["_unit", "_position", ["_mode", 0]];

private ["_charge","_charges"];

removeAllWeapons _unit;
{_unit removeWeapon _x} forEach (weapons _unit);
{_unit removeMagazine _x} forEach (magazines _unit);
_unit addVest "V_Pocketed_coyote_F";
_unit addItemtoUniform "ACE_DeadManSwitch";
_unit setSkill 1;
_unit setCaptive true;
_unit disableAI "AUTOCOMBAT";
_unit allowfleeing 0;

_charges = [];
for "_i" from 0 to 2 do {
	_charge = createVehicle ["DemoCharge_Remote_Ammo", [0,0,0], [], 0, "CAN_COLLIDE"];
	_charges pushBack _charge;
	switch _i do {
		case 0 : {
			(_charges select 0) attachTo [_unit, [-0.1, 0.1, 0.15], "Pelvis"];
			(_charges select 0) setVectorDirAndUp [ [0.5, 0.5, 0], [-0.5, 0.5, 0] ];
      ["ace_common_setVectorDirAndUp", [(_charges select 0), [[0.5, 0.5, 0], [-0.5, 0.5, 0]]]] call CBA_fnc_globalEventJIP;
		};
		case 1 : {
			(_charges select 1) attachTo [_unit, [0, 0.15, 0.15], "Pelvis"];
			(_charges select 1) setVectorDirAndUp [[1, 0, 0], [0, 1, 0]];
      ["ace_common_setVectorDirAndUp", [(_charges select 1), [[1, 0, 0], [0, 1, 0]]]] call CBA_fnc_globalEventJIP;
		};
		case 2 : {
			(_charges select 2) attachTo [_unit, [0.1, 0.1, 0.15], "Pelvis"];
			(_charges select 2) setVectorDirAndUp [[0.5, -0.5, 0], [0.5, 0.5, 0]];
      ["ace_common_setVectorDirAndUp", [(_charges select 2), [[0.5, -0.5, 0], [0.5, 0.5, 0]]]] call CBA_fnc_globalEventJIP;
		};
	};
};
_unit addEventhandler ["Deleted",{
	if !((attachedObjects (_this select 0)) isequalTo []) then {
		{deleteVehicle _x;} forEach attachedObjects (_this select 0);
	};
}];

[_unit, _position, _mode] call zumi_fnc_c4_wait;
