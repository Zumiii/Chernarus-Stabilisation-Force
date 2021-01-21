/*

  Speichert wichtige Variablen in die Datenbank

*/

if !isServer exitWith {};

params [["_incr", 0], ["_cba_missionTime", 0]];

if (missionended) exitWith {};

private _inidbi = ["new", "us"] call OO_INIDBI;

timestamp = ("getTimeStamp" call _inidbi);

if (_incr < 5) then {
    _incr = (_incr + 1);
    spielerfaktor set [_incr, (count ([] call cba_fnc_players))];
} else {
  _incr = 0;
  spielerfaktor set [_incr, (count ([] call cba_fnc_players))];
  spielerstatistik set [(timestamp select 3), (spielerfaktor call BIS_fnc_arithmeticMean)];
  publicVariable "spielerstatistik";
};

private _temp = spielerstatistik select {_x > 0};
if (count _temp < 1) then {
  _temp pushback 1;
};
average_players_when_not_empty = _temp call BIS_fnc_arithmeticMean;

["write", ["Missionspersistenz", "spielerfaktor", spielerfaktor]] call _inidbi;
["write", ["Missionspersistenz", "spielerstatistik", spielerstatistik]] call _inidbi;

//Uhrzeit und Datum
["write", ["Missionspersistenz", "Zeit", date]] call _inidbi;

/*////////////////////////////////////////
/ Missionspersistenz                      /
////////////////////////////////////////*/

//Losses
["write", ["Missionspersistenz", "losses", [east_losses, west_losses, ind_losses, civ_losses]]] call _inidbi;

//Buildings
["write", ["Missionspersistenz", "ruined houses", houses_ruined]] call _inidbi;

["write", ["Missionspersistenz", "damaged houses", houses_damaged]] call _inidbi;

zumi_SectorControl = [];
{
  _active = (_x getVariable ["active", false]); // public
  _score = (_x getVariable ["score", 0]); // public
  zumi_SectorControl pushBack [false, _score, "east", (_x getVariable ["color", [1,1,1,1]]), _forEachindex];
} forEach commy_sectors;
["write", ["Missionspersistenz", "zumi_SectorControl", zumi_SectorControl]] call _inidbi;
//["write", ["Missionspersistenz", "commy_eastSectorCount", (missionNamespace getVariable ["commy_eastSectorCount", 0])]] call _inidbi;
//["write", ["Missionspersistenz", "commy_westSectorCount", (missionNamespace getVariable ["commy_westSectorCount", 0])]] call _inidbi;

/*
//Wetter
["write", ["Missionspersistenz", "Wetter", [ace_weather_currentTemperature, ace_weather_currentHumidity]]] call _inidbi;
*/

//Rallypoint
["write", ["Missionspersistenz", "rp_pos", getPosASL Rallypoint]] call _inidbi;


//Im Einsatz stehende Fahrzeuge abrufen
if ((count Fahrzeuge_Temp) > 0) then {
  private ["_hitpointsdmg","_dmg","_ammo","_fuel","_san","_rep","_cargo","_weps","_mags","_items","_refueler","_ammotruck","_id"];
  for "_i" from 0 to (count Fahrzeuge_Temp) - 1 do {
    (Fahrzeuge_Temp select _i) params ["_id","_aktiv","_status","_typ","_objekt", "_name", "_datum"];
    if ((!isNull ((Fahrzeuge_Temp select _i) select 4)) && !(_status IN ["p","v"]) && (alive ((Fahrzeuge_Temp select _i) select 4))) then {
      _hitpointsdmg = getAllHitPointsDamage _objekt;
      _dmg = [];
      for "_i" from 0 to (count (_hitpointsdmg select 0))-1 do {
        _dmg pushBack [(_hitpointsdmg select 0) select _i, (_hitpointsdmg select 1) select _i, (_hitpointsdmg select 2) select _i];
      };
      _ammo = [_objekt] call ace_rearm_fnc_getNeedRearmMagazines;
      _fuel = fuel _objekt;
      _san = _objekt getVariable ["ace_medical_medicClass",0];
      _rep = _objekt getVariable ["ace_isRepairVehicle",0];
      _cargo = [];
      _weps = weaponsItemsCargo _objekt;
      _cargo pushBack _weps;
      //_mags = getMagazineCargo _objekt;
      _mags = magazinesAmmoCargo _objekt;
      _cargo pushBack _mags;
      _items = getItemCargo _objekt;
      if !(_items isEqualTo [[],[]]) then {
        _items = [_items] call zumi_fnc_replace_radio;
      };
      _cargo pushBack _items;
      _containers = [];

      {
        _containeritems = [];
        _containeritems pushBack (typeOf _x);
        _containeritems pushback (weaponsItemsCargo _x);
        private _weaponsItemsCargo = (weaponsItemsCargo _x);
        _containeritems pushBack (magazinesAmmoCargo _x);
        _items = getItemCargo _x;
        if !(_items isEqualTo [[],[]]) then {
          _items = [_items] call zumi_fnc_replace_radio;
        };
        _containeritems pushBack _items;
        _containers pushBack _containeritems;
      } forEach (everyBackpack _objekt);
      _cargo pushBack _containers;
      _refueler = [_objekt] call ace_refuel_fnc_getFuel;
      _ammotruck = [_objekt] call ace_rearm_fnc_getSupplyCount;
      _locked = locked _objekt;
      ["write", ["Fuhrpark", format ["fzg_%1", (_i + 1)],
        [_id, _aktiv, getPosATL _objekt, _typ, "obj", _dmg, _ammo, _fuel, _san, _rep, _cargo, _refueler, _ammotruck, ([_objekt] call ace_common_fnc_getPitchBankYaw), _locked]
      ]] call _inidbi;
      (Fahrzeuge select _i) set [2, getPosATL _objekt];
      ["write", ["Fuhrpark", "Fahrzeuge", Fahrzeuge]] call _inidbi;
    } else {
      if !(((Fahrzeuge_Temp select _i) select 2) IN ["p","v"]) then {
        (Fahrzeuge select _i) set [2, "v"];
        ["write", ["Fuhrpark", "Fahrzeuge", Fahrzeuge]] call _inidbi;
      };
    };
  };
};

//Platzierte Fortify - Objekte
fortify_objekte = [];
if ((count fortify_objekte_temp) > 0) then {
  {
      _x params ["_obj", "_posATL", "_pby"];
      fortify_objekte pushBack [typeOf _obj, _posATL, _pby, _obj getVariable ["verladen", 0]];
  } forEach fortify_objekte_temp;
};
["write", ["Missionspersistenz", "Fortifyobjekte", fortify_objekte]] call _inidbi;
//Fortify - Budget
["write", ["Missionspersistenz", "Fortifybudget", acex_fortify_budget_west]] call _inidbi;

//Vorhandene Güterpalletten, Kisten etc
if ((count lagerbestand_Temp) > 0) then {
  private ["_veh","_verladen","_san", "_rep", "_cargo","_containers","_weps","_mags","_items","_refueler","_ammotruck","_id"];
  for "_i" from 0 to (count lagerbestand_Temp) - 1 do {
    (lagerbestand_Temp select _i) params ["_id","_veh"];
    if !(isNull _veh) then {
      _verladen = _veh getVariable ["verladen", 0];
      _san = _veh getVariable ["ace_medical_medicClass",0];
      _rep = _veh getVariable ["ace_isRepairVehicle",0];
      _cargo = [];
      _weps = weaponsItemsCargo _veh;
      _cargo pushBack _weps;
      //_mags = getMagazineCargo _veh;
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
        _containeritems pushBack (magazinesAmmoCargo _x);
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
      ["write", ["Lager", format ["ggst_%1", _id],
        [_id, typeOf _veh, getPosATL _veh, ([_veh] call ace_common_fnc_getPitchBankYaw), _san, _rep, _cargo, _refueler, _ammotruck, _verladen]
      ]] call _inidbi;

    } else {
      lagerbestand_Temp deleteAt _i;
      lagerbestand deleteAt (lagerbestand find [_id]);
      ["deleteKey", ["Lager", format ["ggst_%1", _id]]] call _inidbi;
      ["write", ["Lager", "Lagerbestand", lagerbestand]] call _inidbi;
    };
  };
};

["write", ["Lager", "Lagerbestand", lagerbestand]] call _inidbi;

//Bestellungen
if ((count bestellungen) > 0) then {
  _bestellungen = [];
  for "_i" from 0 to (count bestellungen)-1 do {
    (bestellungen select _i) params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];
    ["write", ["Missionspersistenz", format ["bstl_%1", _auftragsnummer], [_auftragsnummer, _bestelldatum, _liefertermin, _auftraggeber, _waren_ids, _bearbeitungsstatus]]] call _inidbi;
    _bestellungen pushBack _auftragsnummer;
  };
  ["write", ["Missionspersistenz", "bestellungen", _bestellungen]] call _inidbi;
};




//Loop
[
  zumi_fnc_speichern,
  [_incr, cba_missiontime],
  60
] call CBA_fnc_waitAndExecute;
