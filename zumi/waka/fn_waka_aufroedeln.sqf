/*

  Roedelt den Spieler auf

*/

disableSerialization;

//Finde GUI
_display = findDisplay 1130;

//Access Control
_kategorie = _display displayCtrl 1136;
_liste = _display displayCtrl 1137;

_val = _kategorie lbvalue (lbcursel _kategorie);
_auswahl = _liste lbvalue (lbcursel _liste);

_insignia = (player getVariable ["BIS_fnc_setUnitInsignia_class", ""]);

if ((player getVariable ["323_waka", 0]) < 1) exitWith {
  hint "You are not allowed to do that. Ask the admin!";
};

switch _val do {
  case 0 : {
    removeAllWeapons player;
    removeAllItems player;
    removeAllAssignedItems player;
    removeUniform player;
    removeVest player;
    removeBackpack player;
    removeHeadgear player;
    removeGoggles player;
    (((Armory select _val) select 1) select _auswahl) params ["_text_etc", "_loadout", ["_medic", 0], ["_pio", 0], ["_eod", false],["_instruktor", false]];
    player setUnitLoadout [_loadout, false];
  };
  case 1 : {
    removeBackpack player;
    _loadout = (((Armory select _val) select 1) select _auswahl) select 1;
    if (_loadout isEqualTo []) exitWith {};
    _loadout params ["_backpack", "_backpackitems"];
    player addBackpack _backpack;
    _bp = unitBackpack player;
    {
      _x params ["_item", "_count", "_rounds"];
      _bp addItemCargoGlobal [_item, _count];
    } forEach _backpackitems;
  };
  default {};
};


[
  {
    params ["_p", "_ins"];
    [_p, _ins] call BIS_fnc_setUnitInsignia;
  },
  [player, _insignia],
  1
] call CBA_fnc_waitAndExecute;
