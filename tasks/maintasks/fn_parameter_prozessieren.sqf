/*

  Skript prozessiert die Missionsparameter

*/

if !isServer exitWith {};

aimingAccuracy = ["aimingAccuracy", 1] call BIS_fnc_getParamValue;
aimingShake = ["aimingShake", 1] call BIS_fnc_getParamValue;
aimingSpeed = ["aimingSpeed", 1] call BIS_fnc_getParamValue;
spotDistance = ["spotDistance", 1] call BIS_fnc_getParamValue;
spotTime = ["spotTime", 1] call BIS_fnc_getParamValue;
courage = ["courage", 1] call BIS_fnc_getParamValue;
reloadSpeed = ["reloadSpeed", 1] call BIS_fnc_getParamValue;
commanding = ["commanding", 1] call BIS_fnc_getParamValue;


[] call zumi_fnc_init_villages;






if (true) exitWith {};
