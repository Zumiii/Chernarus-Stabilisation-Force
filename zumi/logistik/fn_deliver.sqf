/*

  Kurzbeschrieb:
  Task, womit die Ankunft einer Lieferung angezeigt wird.
  Der Lieferungsinhalt wird einem vorplatzierten Container hinzugefügt

*/

if !isServer exitWith {};

params ["_auftrag"];
_auftrag params ["_auftragsnummer","_bestelldatum","_liefertermin","_auftraggeber","_waren_ids","_bearbeitungsstatus"];



/*
  Variablen definieren
*/

_tsk_obj = [];


private _inidbi = ["new", "us"] call OO_INIDBI;
lagerbestand = ["read", ["Lager", "Lagerbestand", []]] call _inidbi;

/*
  Spawns und Objektmanipulationen
*/

private _lieferungscontainer = createVehicle ["RHS_C130J_Cargo", [0,0,200], [], 0, "FLY"];
_lieferungscontainer setVariable ["kann_weg", false];
_grp = createGroup west;
private _unit = _grp createUnit ["rhsusf_airforce_jetpilot", [0,0,0], [], 0, "CAN_COLLIDE"];
_unit setSkill 1;
_unit allowFleeing 0;
_unit moveInDriver _lieferungscontainer;
_unit assignAsDriver _lieferungscontainer;
_lieferungscontainer allowCrewInImmobile true;
_lieferungscontainer setUnloadInCombat [false, false];
_lieferungscontainer setDir ([getPos _lieferungscontainer, (getMarkerpos "respawn_west")] call bis_fnc_dirTo);
_lieferungscontainer setVelocity [70*(sin (getDir _lieferungscontainer)), 70*(cos (getDir _lieferungscontainer)), 0];
[_lieferungscontainer, 10] call ace_cargo_fnc_setSpace;
_lieferungscontainer setVariable ["id", -1];
clearBackpackCargoGlobal _lieferungscontainer;
clearMagazineCargoGlobal _lieferungscontainer;
clearWeaponCargoGlobal _lieferungscontainer;
clearItemCargoGlobal _lieferungscontainer;
_lieferungscontainer landAt 0;

_lieferungscontainer addEventHandler ["Landing", {
	params ["_plane", "_airportID", "_isCarrier"];
  _plane AllowDamage false;
}];

_lieferungscontainer addEventHandler ["LandedStopped", {
	params ["_plane", "_airportID"];
  _plane AllowDamage true;
  _plane engineOn false;
  _plane setFuel 0;
}];

for "_i" from 1 to (count _waren_ids) do {
  (_waren_ids select (_i-1)) params ["_kategorie","_element"];
  private _liefereinheit = ((Bestellbare select _kategorie) select 2) select (_element - 1);
  _liefereinheit params ["_nr","_classname","_icon","_was","_size","_cargo"];
  private _behaelter = createVehicle [_classname, [0,0,0], [], 0, "CAN_COLLIDE"];
  _behaelter setVariable ["kann_weg", false];

  //Verladbar machen
  _jip_str = ["zumi_ace_cargo", [_behaelter, _size]] call CBA_fnc_globalEventJIP;
  [_jip_str, _behaelter] call CBA_fnc_removeGlobalEventJIP;

  //Tragbar machen
  _jip_str = ["zumi_ace_carry", [_behaelter, true]] call CBA_fnc_globalEventJIP;
  [_jip_str, _behaelter] call CBA_fnc_removeGlobalEventJIP;

  //Entleere Objektinventar
	if !(_cargo isEqualto []) then {
  	clearBackpackCargoGlobal _behaelter;
  	clearMagazineCargoGlobal _behaelter;
  	clearWeaponCargoGlobal _behaelter;
  	clearItemCargoGlobal _behaelter;
	};
  {
    _behaelter addItemCargoGlobal [_x select 0, _x select 1];
  } forEach _cargo;
  if (([_behaelter] call ace_cargo_fnc_getSizeItem) < 0) then {
    [_behaelter, _size] call ace_cargo_fnc_setSize;
  };
  [_behaelter, _lieferungscontainer, true] call ace_cargo_fnc_loadItem;
  _tsk_obj pushBack _behaelter;

  //Mache den Gegenstand persistent
  lagerbestand_Temp pushBack [(count lagerbestand) + 1, _behaelter];
  lagerbestand pushBack [(count lagerbestand) + 1];
  _behaelter setVariable ["nr", (count lagerbestand) + 1];
};



(bestellungen select (_auftragsnummer - 1)) set [5, "delivered"];
publicVariable "bestellungen";
_auftrag set [5, "delivered"];

//The plane will be deleted, once a foreman confirms the payload
[
	{
		params ["_args","_handle"];
    _args params ["_plane","_pilot", "_order"];
    if (!alive _plane) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
			order_in_progress = false;
	    publicVariable "order_in_progress";
			[_pilot] call cba_fnc_deleteEntity;
    };
    if ((_order IN bestellungen) || (fuel _plane > 0)) exitWith {};
    [_handle] call CBA_fnc_removePerFrameHandler;
    [_plane, _pilot] call cba_fnc_deleteEntity;
    order_in_progress = false;
    publicVariable "order_in_progress";

	},
	15,
	[_lieferungscontainer, _unit, _auftrag]
] call CBA_fnc_addPerFrameHandler;



if(true) exitWith {};
