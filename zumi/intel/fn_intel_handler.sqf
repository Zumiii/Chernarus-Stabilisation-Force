/*

  Funktion regelt ein Intel - Event serverseitig

*/

if !isServer exitWith {};

params ["_typ", "_task", "_genutzt_durch", "_dauer", "_info"];



zumi_intels pushBack [_zeitpunkt_des_fundes, _intel];
