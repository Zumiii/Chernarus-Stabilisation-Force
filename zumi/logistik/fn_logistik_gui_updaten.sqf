/*

  Aktualisiert den logistik_dialog

*/
if (!hasInterface) exitWith {};

disableSerialization;


private ["_display","_bestellungen","_archiv","_index","_value"];


//Finde GUI
_display = findDisplay 2020;

//Access control
_bestellungen = _display displayCtrl 1608;
_archiv = _display displayCtrl 1609;

_abschr = _display displayCtrl 1610;
_details = _display displayCtrl 1611;
_verz = _display displayCtrl 1612;
_quitt = _display displayCtrl 1613;
_storn = _display displayCtrl 1614;

{
  _x ctrlEnable false;
} forEach [_abschr, _details, _verz, _quitt, _storn];

//Erfasse ausgewähltes Bestellungsübersichtselement
if (lbSize _bestellungen > 0) then {
  _index = lbCurSel _bestellungen;
  _value = (_bestellungen lbValue _index);
  (bestellungen select _value) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];

  //Wenn die Lieferung im neuen Jahr ist, ist ein Verzögern möglich
  _jahr = date select 0;

  //Prüfe, ob Verzögerung möglich. Das geht nur mindestens 24h vorher
  if (((dateToNumber date) < ((dateToNumber _liefertermin) -  (1 / 365))) && (_jahr <= (_liefertermin select 0))) then {
    _verz ctrlEnable true;
    buttonSetAction [1612, format ["closeDialog 0; [player, %1, %2, %3] call zumi_fnc_lieferung_bearbeiten;", str "verzoegern", _value, str (name player)]];
  } else {
    buttonSetAction [1612, ""];
  };

  //Prüfen aktivieren
  buttonSetAction [1611, format ["[player, %1, %2, %3] call zumi_fnc_lieferung_bearbeiten;", str "details", _value, str (name player)]];
  _details ctrlEnable true;

  //Prüfe, ob Storno möglich
  if !(_bearbeitungsstatus IN ["verladen","versendet","geliefert"]) then {
    _storn ctrlEnable true;
    buttonSetAction [1614, format ["closeDialog 0; [player, %1, %2, %3] call zumi_fnc_lieferung_bearbeiten;", str "stornieren", _value, str (name player)]];
  } else {
    _storn ctrlEnable false;
  };
  //Prüfe, ob Abschreiben möglich
  if (_bearbeitungsstatus isEqualTo "geliefert") then {
    _abschr ctrlEnable true;
    buttonSetAction [1610, format ["closeDialog 0; [player, %1, %2, %3] call zumi_fnc_lieferung_bearbeiten;", str "abschreiben", _value, str (name player)]];
  } else {
    _abschr ctrlEnable false;
  };
  //Prüfe, ob Quittieren möglich
  if (_bearbeitungsstatus isEqualTo "geliefert") then {
    _quitt ctrlEnable true;
    buttonSetAction [1613, format ["closeDialog 0; [player, %1, %2, %3] call zumi_fnc_lieferung_bearbeiten;", str "quittieren", _value, str (name player)]];
  } else {
    _quitt ctrlEnable false;
  };

};
