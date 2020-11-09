/*

  Gegnerischer Kommandeur wird registriert.

*/

if !isServer exitWith {};

params [["_unit", objNull]];

if (isNull _unit) exitWith {};

zumi_kommandeure pushBack _unit;
