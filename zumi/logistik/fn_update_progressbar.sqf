/*

  Aktualisiert den Cargoprogressbar

*/

disableSerialization;

params ["_ctrl","_index",["_delete", false]];


_display = findDisplay 2021;
_warenkorb = _display displayCtrl 1618;
_progressbar = _display displayCtrl 1620;
_progressbartext = _display displayCtrl 1631;
_progressbar progressSetPosition 0;
if (_delete) then {
  _ctrl lbDelete _index;
};
_indices = lbSize _warenkorb;
if (_indices < 1) then {
  buttonSetAction [1619, ""];
};


if (_indices >= 1) then {
  //Addiere den Cargowert der Items und update Progressbar
  for "_i" from 0 to (_indices-1) do {
    _val = (_warenkorb lbValue _i);
    _kategorie = parseNumber (_warenkorb lbdata _i);
    _geaddet = false;
    {
      for "_j" from 0 to (count _x) - 1 do {
        if (_geaddet) exitWith {};
        _x params ["_kategoriename","_icon","_liefereinheiten"];
        for "_k" from 0 to (count _liefereinheiten)-1 do {
          if (_geaddet) exitWith {};
          (_liefereinheiten select _k) params ["_id","_classname","_icon","_anzeigename","_platzverbrauch","_cargo"];
          if ((_id isEqualTo _val) && (_kategorie isEqualTo _forEachindex)) then {
            _geaddet = true;
            _progressbar progressSetPosition ((progressPosition _progressbar) + (5*_platzverbrauch/50));
          };
        };
      };
    } forEach Bestellbare;
  };
};
_progressbartext CtrlsetText format ["Used cargo space: %1/%2",(100*(progressPosition _progressbar))/10,10];
