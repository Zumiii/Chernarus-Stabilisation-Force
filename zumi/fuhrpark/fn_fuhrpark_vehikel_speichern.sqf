
/*

  Ein Fahrzeug wird hiermit mit allen Details dem Fuhrparkarray hinzugefügt

*/

if !isServer exitWith {};

private ["_zu_parken","_typ","_hitpointsdmg","_dmg","_ammo","_fuel","_san","_rep","_cargo","_weps","_mags","_items","_containers","_containeritems","_refueler","_ammotruck","_id"];

params ["_player"];

garage setVariable ["in_arbeit", true];

private _inidbi = ["new", "us"] call OO_INIDBI;


_zu_parken = (nearestObjects [garage, ["Car","Tank", "Air"], 5, true]);
if (count _zu_parken < 1) exitWith {
  garage setVariable ["in_arbeit", false];
};




_veh = (_zu_parken select 0);


_phase = _veh getVariable ["phase", 1];


private _loaded = _veh getVariable ["ace_cargo_loaded", []];
if (count _loaded > 0) exitWith {
  {
    [_x, _veh] call ace_cargo_fnc_unloadItem;
  } forEach _loaded;
  garage setVariable ["in_arbeit", false];
};

{
	_x action ["Eject",vehicle _x];
} forEach crew _veh;


_id = _veh getVariable ["id", -1];
if (_id < 0) exitWith {
  deleteVehicle _veh;
  garage setVariable ["in_arbeit", false];
};

_typ = typeof _veh;
_hitpointsdmg = getAllHitPointsDamage _veh;
_dmg = [];
for "_i" from 0 to (count (_hitpointsdmg select 0))-1 do {
  _dmg pushBack [(_hitpointsdmg select 0) select _i, (_hitpointsdmg select 1) select _i, (_hitpointsdmg select 2) select _i];
};

_ammo = [_veh] call ace_rearm_fnc_getNeedRearmMagazines;
_fuel = fuel _veh;
_san = _veh getVariable ["ace_medical_medicClass", 0];
_rep = _veh getVariable ["ace_isRepairVehicle", 0];
_cargo = [];
_weps = weaponsItemsCargo _veh;
_cargo pushBack _weps;
_mags = magazinesAmmoCargo _veh;
_cargo pushBack _mags;
_items = getItemCargo _veh;
if !(_items isEqualTo [[],[]]) then {
  _items = [_items] call zumi_fnc_replace_radio;
};
_cargo pushBack _items;
_containers = [];
{
  _containeritems = [];
  _containeritems pushBack (typeOf _x);
  _containeritems pushback (weaponsItemsCargo _x);
  _containeritems pushback (magazinesAmmoCargo _x);
  _items = getItemCargo _x;
  if !(_items isEqualTo [[],[]]) then {
    _items = [_items] call zumi_fnc_replace_radio;
  };
  _containeritems pushBack _items;
  _containers pushBack _containeritems;
} forEach (everyBackpack _veh);
_cargo pushBack _containers;
_refueler = [_veh] call ace_refuel_fnc_getFuel;
_ammotruck = [_veh] call ace_rearm_fnc_getSupplyCount;
_locked = locked _veh;





(Fahrzeuge select (_id - 1)) set [2, "p"];
(Fahrzeuge select (_id - 1)) set [4, name _player];
(Fahrzeuge select (_id - 1)) set [5, ("getTimeStamp" call _inidbi)];

(Fahrzeuge_Temp select (_id - 1)) set [2, "p"];
(Fahrzeuge_Temp select (_id - 1)) set [5, name _player];
(Fahrzeuge_Temp select (_id - 1)) set [6, ("getTimeStamp" call _inidbi)];


["write", ["Fuhrpark", format ["fzg_%1", _id], [_id, (Fahrzeuge select (_id - 1)) select 1, "p", _typ, "obj", _dmg, _ammo, _fuel, _san, _rep, _cargo, _refueler, _ammotruck, [0,0,0], _locked]]] call _inidbi;
["write", ["Fuhrpark", "Fahrzeuge", Fahrzeuge]] call _inidbi;
publicvariable "Fahrzeuge_Temp";



deleteVehicle _veh;

garage setVariable ["in_arbeit", false];
