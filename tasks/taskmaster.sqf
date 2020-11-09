if !isServer exitWith {};


//Missionsphase wird nicht übersprungen
skip = false;
phase = 1;

//Missionsphase starten
[] execVM format ["tasks\phase_%1.sqf", Phase];


if (true) exitWith {};
