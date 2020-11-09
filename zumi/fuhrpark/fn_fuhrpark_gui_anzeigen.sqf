/*

  Öffnet den fuhrpark_dialog

*/

disableSerialization;

private ["_index","_anzeigename","_anzeigebild","_tooltipp","_button"];

// Find GUI
_display = findDisplay 2018;
// Access control
_listBox = _display displayCtrl 447;

if (count Fahrzeuge_Temp < 1) exitWith {
  _button = _display displayCtrl 1600;
  _button ctrlSetTextColor	[0.7,0,0,1];
	_button ctrlEnable false;
};

//Füge Fahrzeuge dem Fuhrpark hinzu.
for "_i" from 0 to (count Fahrzeuge_Temp)-1 do {
  //if (((Fahrzeuge_Temp select _i) select 2) IN ["p"] && (((Fahrzeuge_Temp select _i) select 1) <= Phase)) then {
  if (((Fahrzeuge_Temp select _i) select 1) <= Phase) then {
    _anzeigename = getText (configFile >> "CfgVehicles" >> ((Fahrzeuge_Temp select _i) select 3) >> "displayName");
    _index = _listBox lbAdd _anzeigename;
    _anzeigebild = getText (configFile >> "CfgVehicles" >> ((Fahrzeuge_Temp select _i) select 3) >> "Picture");
    _listBox lbSetPictureRight [_index, _anzeigebild];
    _listBox lbSetValue [_index, ((Fahrzeuge_Temp select _i) select 0)];
  };
};

//lbSort _listBox;

// Select default item
_listBox lbSetCurSel 0;

//[] call zumi_fnc_fuhrpark_gui_updaten;
