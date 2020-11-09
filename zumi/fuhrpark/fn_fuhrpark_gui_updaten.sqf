/*

  Updatet den fuhrpark_dialog

*/

disableSerialization;

private ["_display","_listBox","_index","_value","_id"];


//Finde GUI
_display = findDisplay 2018;

_listBox = _display displayCtrl 447;


//Erfasse ausgewähltes Item
_index = lbCurSel _listBox;
_value = (_listBox lbValue _index);
_klasse = (Fahrzeuge_Temp select (_value - 1)) select 3;
_id = (Fahrzeuge_Temp select (_value - 1)) select 0;

//Zeige Fahrzeugnummer
_listBox = _display displayCtrl 785;
_nr = format ["Vehicle No: %1", _id];
_listbox ctrlSetText _nr;

_preview = _display displayCtrl 1605;
_preview ctrlSetText ([configFile >> "CfgVehicles" >> _klasse >> "editorPreview", "STRING", ""] call CBA_fnc_getConfigEntry);

//Wer hat es zuletzt ausgeparkt bzw. eingeparkt?
_wer = _display displayCtrl 786;
private _txt = format ["Signed: %1", ((Fahrzeuge_Temp select (_value - 1)) select 5)];
_wer ctrlSetText _txt;

//Wann?
_wann = _display displayCtrl 787;
((Fahrzeuge_Temp select (_value - 1)) select 6) params ["_jahr","_monat","_tag","_stunde","_minute"];
private _txt = format ["%1.%2.%3 around %4h%5", _tag, _monat, _jahr, _stunde, _minute];
_wann ctrlSetText _txt;

_info = _display displayCtrl 1601;
buttonSetAction [1601, format ["[%1] call zumi_fnc_fuhrpark_info", (_value - 1)]];

if !((((fahrzeuge_temp) select (_value - 1)) select 2) IN ["p","v"]) then {
  ctrlEnable [1602, false];
  ctrlEnable [1604, true];
} else {
  ctrlEnable [1602, true];
  ctrlEnable [1604, false];
};
buttonSetAction [1602, format ["closeDialog 0; [%1, %2, %3] remoteExecCall ['zumi_fnc_fuhrpark_spawn', 2]", _id, str (getPlayerUID player), str (name player)]];
