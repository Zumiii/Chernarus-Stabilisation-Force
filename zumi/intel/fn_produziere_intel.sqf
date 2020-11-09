/*

  Funktion erstellt Intel serverseitig
  Dem Intel wird eine JIP - kompatible Interaktion verliehen

*/

if !isServer exitWith {};

params [["_objekt", "Land_Wallet_01_F"], "_pos", "_intel"];
_intel params ["_typ", "_task", "_genutzt_durch", "_dauer", "_info"];

private _objekt = createVehicle [_objekt, _pos, [], 0.5, "NONE"];

_intel_aktion = ["Intel","Pick up intel","\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa",{
  params ["_t","_p","_actionparams"];
  _actionparams params ["_typ", "_task", "_genutzt_durch", "_dauer", "_info"];
  ["zumi_intel", [_typ, _task, _genutzt_durch, _dauer, _info]] call CBA_fnc_serverEvent;
  [_p, "PutDown", 1] call ace_common_fnc_doGesture;
  deleteVehicle _t;
  ["Intel erhalten", "\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa", [1, 1, 1], _p, 2] call ace_common_fnc_displayTextPicture;
},{true},{},[_typ, _task, _genutzt_durch, _dauer, _info]] call ace_interact_menu_fnc_createAction;

_jip_str = ["zumi_interaction_add_to_object", [_objekt, _intel_aktion, 0, ["ACE_MainActions"]]] call CBA_fnc_globalEventJIP;
[_jip_str, _objekt] call CBA_fnc_removeGlobalEventJIP;
