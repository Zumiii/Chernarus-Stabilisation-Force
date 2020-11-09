/*

  Feindliche Batterie führt den Feuerbefehl aus.

*/

if !isServer exitWith {};

params ["_wasys",["_zielkoordinate",[0,0,0]],["_geschosstyp",""],["_menge",1]];

//Wenn das Teil leer ist exit
If (_geschosstyp isEqualTo "") then {
    private _geschosstypen = getArtilleryAmmo [_wasys];
    If (_geschosstypen isEqualTo []) exitWith {};
    _geschosstyp = (_geschosstypen select 0);
};
_spread = linearConversion [300, 1500, (_zielkoordinate distance2d _wasys), 25, 100, true];
_zielkoordinate = _zielkoordinate getPos [_spread * sqrt (1 - abs random [- 1, 0, 1]), random 360];
_wasys commandArtilleryFire [_zielkoordinate, _geschosstyp, _menge];

/*
switch (typeOf _wasys) do {
    default {
        _wasys commandArtilleryFire [_zielkoordinate,_geschosstyp,_menge];
    };
};
*/
if (debug) then {
  systemChat format ["%1 feuert %2 Mal auf %3 mit %4",_wasys,_menge,_zielkoordinate,_geschosstyp];
};
