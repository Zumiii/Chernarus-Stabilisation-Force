/*

  Öffnet den logistik_dialog

*/

disableSerialization;


//Finde GUI
_display = findDisplay 2020;

//Access control
_bestellungen = _display displayCtrl 1608;
_archiv = _display displayCtrl 1609;

_abschr = _display displayCtrl 1610;
_det = _display displayCtrl 1611;
_verz = _display displayCtrl 1612;
_quitt = _display displayCtrl 1613;
_storn = _display displayCtrl 1614;
_pruef = _display displayCtrl 1615;


if (count bestellungen < 1) exitWith {
	{
		_x ctrlEnable false;
	} forEach [_abschr, _det, _verz, _quitt, _storn, _pruef];
};

//Füge Bestellungen der Bestellungsübersicht hinzu.

//Resette Libraries
lbClear _bestellungen;
lbClear _archiv;

for "_i" from 0 to (count bestellungen)-1 do {
  (bestellungen select _i) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
  if !(_bearbeitungsstatus IN ["storno","received","reported lost"]) then {
    _index = _bestellungen lbAdd format ["Order %1 from: %2.%3.%4   /   DoD: %5.%6.%7   /   Sig. %8", _auftragsnummer, str (_bestelldatum select 2), str (_bestelldatum select 1), str (_bestelldatum select 0), str (_liefertermin select 2), str (_liefertermin select 1), str (_liefertermin select 0), _auftraggeber];
    _bestellungen lbSetPictureRight [_index, "\rhsusf\addons\rhsusf_a2port_air\data\mapico\icon_c130j_CA.paa"];
    _bestellungen lbSetValue [_index, _i];
  } else {
    _index = _archiv lbAdd format ["Order: %1", text str _auftragsnummer];
    _archiv lbSetPictureRight [_index, "\rhsusf\addons\rhsusf_a2port_air\data\mapico\icon_c130j_CA.paa"];
    _archiv lbSetValue [_index, _i];
		_archiv lbSetToolTip [_index, format ["Ordered %5 on the %1.%2.%3 by %4", (_bestelldatum select 2), (_bestelldatum select 1), (_bestelldatum select 0), _auftraggeber, _bearbeitungsstatus]];
		lbSort [_archiv,"ASC"];
  };
};

if (lbSize _bestellungen > 0) then {
  {
		_x ctrlEnable true;
	} forEach [_abschr, _det, _verz, _quitt, _storn];
} else {
  {
		_x ctrlEnable false;
	} forEach [_abschr, _det, _verz, _quitt, _storn];
};
if (lbSize _archiv > 0) then {
  _pruef ctrlEnable true;
} else {
  _pruef ctrlEnable false;
};

[zumi_fnc_logistik_gui_updaten, [player]] call CBA_fnc_execNextFrame;
