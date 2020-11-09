params ["_objects", "_type", ["_carbomb", false], "_id"];

private ["_ied","_grp","_array","_car","_type","_z","_min","_max","_minmax","_unit"];

_array = [];
_grps = [];

//Objekte auf Fahrzeug prüfen
for "_i" from 0 to (count _objects)-1 do {
	if ((_objects select _i) isKindof "Landvehicle") then {
		_array pushBack (_objects select _i);
	};
};

if (count _array > 0 && _carbomb) then {
	//IED spawnen
	_ied = createVehicle [_type, [0,0,0], [], 0, "CAN_COLLIDE"];
	_ied setVariable ["id", _id];
	east revealmine _ied;
	zumi_ieds pushBack _ied;
	//Fahrzeug aussuchen und Klasse feststellen
	_car = (_array call BIS_fnc_SelectRandom);
	_type = typeOf _car;
	//IED attachen
	for "_i" from 0 to (count zumi_carbombs)-1 do {
		if (((zumi_carbombs select _i) select 0) == _type) exitWith {
			_car setVectorUp [0, 0, 1];
			_ied attachTo [_car, ((zumi_carbombs select _i) select 1), ""];
			_ied setVectorUp [0, 0, -1];
			_car setVectorUp surfaceNormal position _car;
			_grp = createGroup east;
			_unit = _grp createUnit ["LOP_CHR_Civ_Random", getPos _car, [], 15, "NONE"];
			_grps pushBack _grp;
			removeAllWeapons _unit;
	    _unit setCaptive true;
	    _unit disableAI "AUTOCOMBAT";
	    _unit allowfleeing 0;
	    {_unit removeWeapon _x} forEach (weapons _unit);
	    {_unit removeMagazine _x} forEach (magazines _unit);
	    removeVest _unit;
	    removeHeadgear _unit;
	    removeGoggles _unit;
	    _unit addItemToUniform "ACE_Cellphone";
			_code = [_unit, _ied, _type] call zumi_fnc_assign_cellphone_to_ied;
			_unit setVariable ["Ied_code", _code];

	    [_unit, _position, _ied] call zumi_fnc_watch_ied;

	    //Triggerman handle
	    [
	     {
	       params ["_args","_handle"];
	       _args params ["_unit","_ied","_id"];
	       if !((villages select _id) select 1) exitWith {
	         [_handle] call CBA_fnc_removePerFrameHandler;
	         [_unit, _ied] call CBA_fnc_deleteEntity;
	       };
	       if (!alive _ied || !("ACE_Cellphone" IN ((items _unit) + (assignedItems _unit)))) exitWith {
	         [_unit] call CBA_fnc_clearWaypoints;
	         //[getPos _unit, _unit] call zumi_fnc_kombattant;
	         [_handle] call CBA_fnc_removePerFrameHandler;
	      };
	      private _ziele = ([getPos _ied, 15, [west, civilian, resistance], ["CAManBase", "LandVehicle"]] call zumi_fnc_nahe_spieler) + ([getPos _ied, 15, [west,resistance], ["CAManBase","LandVehicle"]] call zumi_fnc_nahe_ki);
	  		if ({_unit knowsAbout _x >= 3.5} count _ziele > 0) then {
	        [_unit, (_unit getVariable ["ied_code", 0000])] call zumi_fnc_call_ied;
	        [_handle] call CBA_fnc_removePerFrameHandler;
	        ((villages select _id) select 3) set [2, false];
	      };
	     },
	     2,
	     [_unit, _ied, _id]
	    ] call CBA_fnc_addPerFrameHandler;
		};
	};
} else {
	private _position = getPosATL (_objects call BIS_fnc_SelectRandom);
	_ied = createVehicle [_type, _position, [], 2, "CAN_COLLIDE"];
	_ied setVariable ["id", _id];
	_ied setDir random 360;
	east revealmine _ied;
	zumi_ieds pushBack _ied;
	_grp = createGroup east;
	_unit = _grp createUnit ["LOP_CHR_Civ_Random", [0,0,0], [], 0, "CAN_COLLIDE"];
	_grps pushBack _grp;
	_unit setPosATL [(_position select 0),(_position select 1)+10,0];
	removeAllWeapons _unit;
	_unit setCaptive true;
	_unit disableAI "AUTOCOMBAT";
	_unit allowfleeing 0;
	{_unit removeWeapon _x} forEach (weapons _unit);
	{_unit removeMagazine _x} forEach (magazines _unit);
	removeVest _unit;
	removeHeadgear _unit;
	removeGoggles _unit;
	_unit addItemToUniform "ACE_Cellphone";
	_code = [_unit, _ied, _type] call zumi_fnc_assign_cellphone_to_ied;
	_unit setVariable ["Ied_code", _code];
	[_unit, _position, _ied] call zumi_fnc_watch_ied;

	//Triggerman handle
	[
	 {
		 params ["_args","_handle"];
		 _args params ["_unit","_ied","_id"];
		 if !((villages select _id) select 1) exitWith {
			 [_handle] call CBA_fnc_removePerFrameHandler;
			 [_unit, _ied] call CBA_fnc_deleteEntity;
		 };
		 if (!alive _ied || !("ACE_Cellphone" IN ((items _unit) + (assignedItems _unit)))) exitWith {
			 [_unit] call CBA_fnc_clearWaypoints;
			 [_handle] call CBA_fnc_removePerFrameHandler;
		};
		private _ziele = ([getPos _ied, 15, [west, civilian, resistance], ["CAManBase", "LandVehicle"]] call zumi_fnc_nahe_spieler) + ([getPos _ied, 15, [west, resistance], ["CAManBase", "LandVehicle"]] call zumi_fnc_nahe_ki);
		if ({_unit knowsAbout _x >= 3.5} count _ziele > 0) then {
			[_unit, (_unit getVariable ["ied_code", 0000])] call zumi_fnc_call_ied;
			[_handle] call CBA_fnc_removePerFrameHandler;
			((villages select _id) select 3) set [2, false];
		};
	 },
	 1,
	 [_unit, _ied, _id]
	] call CBA_fnc_addPerFrameHandler;
};

_grps;
