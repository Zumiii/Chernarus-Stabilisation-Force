/*

  Skript prüft, ob Spieler in der Nähe, die einem Ziel bekannt sind, einen Gefechtshelm tragen.

*/


params ["_unit"];

if !(local _unit) exitWith {};

_return = 0;
{
  private _armor = [configfile >> "CfgWeapons" >> (headgear _x) >> "ItemInfo" >> "HitpointsProtectionInfo" >> "Head" >> "Armor", "NUMBER", 0] call CBA_fnc_getConfigEntry;
  if (_armor > 5) then {
    _return = _return + 1;
  };
} forEach (([] call cba_fnc_players) select {(_unit knowsAbout _x >= 0.5) && (_x distance2d _unit <= 200) && (_x call CBA_fnc_canUseWeapon)});

_return;
