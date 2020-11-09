/*

  Funktion erstellt einen Feuerbefehl für ein Steilfeuer.
  Shelltypen:
  "Smoke_120mm_AMOS_White"
  "Sh_120mm_HE"
  "Flare_82mm_AMOS_White"
  "Sh_82mm_AMOS"
  "Smoke_82mm_AMOS_White"
  "Flare_82mm_AMOS_White"
  Beispiel: [[0,0,0],"moerser","Sh_82mm_AMOS",3] call zumi_fnc_steilfeuerbefehl;
*/

if !isServer exitWith {};

params [["_zielkoordinate",[0,0,0]],["_art","moerser"],["_geschosstyp",""],["_menge",1]];


private _befehl_nicht_ausfuehrbar = false;

//_zielkoordinate = _zielkoordinate call cba_fnc_getPos;

//Falls nur X und Y angegeben werden, wird als Z der Wert 0 gesetzt.
If ((count _zielkoordinate) < 2) then {
    _zielkoordinate pushBack 0;
};

private ["_wasys","_geschosstyp"];

switch (_art) do {
    case "moerser" : {
                If (zumi_moerser isEqualTo []) exitWith {_befehl_nicht_ausfuehrbar = true;};
                _wasys = (zumi_moerser call bis_fnc_selectRandom);
                private _geschosstypen = getArtilleryAmmo [_wasys];
                If (_geschosstypen isEqualTo []) exitWith {
                  _befehl_nicht_ausfuehrbar = true;
                };
                If (_geschosstyp isEqualTo "") then {
                  _geschosstyp = (_geschosstypen select 0);
                };
                _befehl_nicht_ausfuehrbar = false;
            };
    case "haubitze" : {
                If (zumi_haubitzen isEqualTo []) exitWith {_befehl_nicht_ausfuehrbar = true;};
                _wasys = (zumi_haubitzen call bis_fnc_selectRandom);
                private _geschosstypen = getArtilleryAmmo [_wasys];
                If (_geschosstypen isEqualTo []) exitWith {
                  _befehl_nicht_ausfuehrbar = true;
                };
                If (_geschosstyp isEqualTo "") then {
                  _geschosstyp = (_geschosstypen select 0);
                };
                _befehl_nicht_ausfuehrbar = false;
            };
    case "rakete" : {
                If (zumi_raketen isEqualTo []) exitWith {_befehl_nicht_ausfuehrbar = true;};
                _wasys = (zumi_raketen call bis_fnc_selectRandom);
                private _geschosstypen = getArtilleryAmmo [_wasys];
                If (_geschosstypen isEqualTo []) exitWith {
                  _befehl_nicht_ausfuehrbar = true;
                };
                If (_geschosstyp isEqualTo "") then {
                  _geschosstyp = (_geschosstypen select 0);
                };
                _befehl_nicht_ausfuehrbar = false;
            };
    default {
      If ((zumi_haubitzen + zumi_raketen + zumi_moerser) isEqualTo []) exitWith {_befehl_nicht_ausfuehrbar = true;};
      _wasys = ((zumi_haubitzen + zumi_raketen + zumi_moerser) call bis_fnc_selectRandom);
      private _geschosstypen = getArtilleryAmmo [_wasys];
      If (_geschosstypen isEqualTo []) exitWith {
        _befehl_nicht_ausfuehrbar = true;
      };
      If (_geschosstyp isEqualTo "") then {
        _geschosstyp = (_geschosstypen select 0);
      };
      _befehl_nicht_ausfuehrbar = false;
    };
};


if (_befehl_nicht_ausfuehrbar) exitWith {false};

//Befehl platzieren
zumi_steilfeuerbefehle pushBack [_zielkoordinate,_art,_geschosstyp,_menge];

//Retournieren, dass der Feuerbefehl erfolgreich platziert wurde
true;
