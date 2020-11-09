#include "sectorsConfig.hpp"

if (hasInterface) then {


  zumi_maintasks_lokal = [];
  zumi_sidetasks_lokal = [];
  tasks_zeige_hinweise = true;
  tasks_init = true;
  intelmarker = [];

  ["zumi_maintasks", {
    params ["_tsk"];
    [
      {([player] call CBA_fnc_isAlive)},
      {
        params ["_tsk"];
        _tsk call zumi_fnc_verwalte_maintaskevent;
      },
      [_tsk]
    ] call CBA_fnc_waitUntilAndExecute;
  }] call CBA_fnc_addEventHandler;

  ["zumi_sidetasks", {
    params ["_tsk"];
    [
      {([player] call CBA_fnc_isAlive)},
      {
        params ["_tsk"];
        _tsk call zumi_fnc_sidetask_handler;
      },
      [_tsk]
    ] call CBA_fnc_waitUntilAndExecute;
  }] call CBA_fnc_addEventHandler;

};

// SERVER
if (isServer) then {
    private _sectors = SECTORS;
    // GLOBAL
    private _inidbi = ["new", "us"] call OO_INIDBI;

    commy_westSectorCount = 0;
    publicvariable "commy_westSectorCount";
    commy_eastSectorCount = 0;
    publicvariable "commy_eastSectorCount";
    zumi_SectorControl = ["read", ["Missionspersistenz", "zumi_SectorControl", []]] call _inidbi;

    if (count zumi_SectorControl < 1) then {
      for "_i" from 0 to (count _sectors) - 1 do {
        zumi_SectorControl pushBack [false, -15, "east", [1,1,1,1], _i];
      };
    };
    commy_sectors = [];

    {
        (zumi_SectorControl select _forEachindex) params [["_active", false], ["_punkte", -15], ["_wer", "east"], ["_farbe", [1,1,1,1]], ["_id", _forEachindex]];
        private _polygon = _x;

        // calculate the center
        private _center = [0,0,0];

        {
            _center = _center vectorAdd _x;
        } forEach _polygon;

        _center = _center vectorMultiply (1/count _polygon);

        //Ist das Center weniger wie 1000m vom Respawn weg, ist das das neue Zentrum

        // calculate the distance from the center to the furthest edge
        private _radius = 0;

        {
            _x set [2, 0];
            _radius = _radius max (_center vectorDistance _x);
        } forEach _polygon;

        // create shape for drawTriangle
        private _shape = _polygon call {
            #include "triangulate.sqf"
        };

        // create logic
        private _sector = true call CBA_fnc_createNamespace;
        _sector setVariable ["active", _active, true]; // public
        _sector setVariable ["polygon", _polygon, true]; // public
        _sector setVariable ["shape", _shape, true]; // public
        _sector setVariable ["center", _center];
        _sector setVariable ["radius", _radius];
        _sector setVariable ["score", _punkte, true]; // public
        _sector setVariable ["lastUpdateTime", CBA_missionTime];
        _sector setVariable ["units", []];
        _sector setVariable ["cleanupQuene", []];
        if (_punkte >= 5) then {
          _wer = "west";
        };
        if (_punkte <= -5) then {
          _wer = "east";
        };
        _sector setVariable ["side", _wer];
        private _locations = (nearestLocations [_center, ["Name","NameCity","NameCityCapital","NameVillage","NameLocal","NameMarine"], _radius]);
        private _location = if (_locations isEqualTo []) then {
          (mapGridPosition _center)
        } else {
          _locations select 0;
        };
        private _dorfkern = if (_locations isEqualTo []) then {
          _center
        } else {
          (_locations select 0) call CBA_fnc_getPos
        };
        _sector setVariable ["color", [1,1,1,1], true]; // public
        if (_locations isEqualTo []) then {
          _sector setVariable ["name", (mapGridPosition _center)];
        } else {
          _sector setVariable ["name", text _location];
        };
        _sector setVariable ["dorfkern", _center];
        commy_sectors pushBack _sector;
        if (_punkte >= 5) then {
          missionNamespace setVariable ["commy_westSectorCount", commy_westSectorCount + 1, true];
        };
        if (_punkte <= -5) then {
          missionNamespace setVariable ["commy_eastSectorCount", commy_eastSectorCount + 1, true];
        };
    } forEach _sectors;


    publicVariable "commy_sectors";

    // update
    [{
        (_this select 0) params ["_iterator"];
        // pick one sector to update every frame
        if (_iterator >= count commy_sectors) then {
            _iterator = 0;
        };

        private _sector = commy_sectors select _iterator;
        (_this select 0) set [0, _iterator + 1];

        // update sector

        private _polygon = _sector getVariable "polygon";
        private _center = _sector getVariable "center";
        private _radius = _sector getVariable "radius";
        private _score = _sector getVariable "score";
        private _lastUpdateTime = _sector getVariable "lastUpdateTime";
        private _previousUnitsInSector = _sector getVariable "units";
        private _cleanupQuene = _sector getVariable "cleanupQuene";

        private _deltaT = (CBA_missionTime - _lastUpdateTime)/60; // in minutes
        if (_deltaT == 0) exitWith {};

        private _unitsInSector = allUnits inAreaArray [_center, _radius, _radius, 0, false] select {
            getPosWorld _x inPolygon _polygon
        };

        // handle unit's sector info
        _sector setVariable ["units", _unitsInSector];

        private _arrivedUnits = _unitsInSector - _previousUnitsInSector;
        private _departedUnits = _previousUnitsInSector - _unitsInSector;

        {
            _x setVariable ["commy_sector", _sector, true];
        } forEach _arrivedUnits;

        {
            if (_x getVariable ["commy_sector", objNull] isEqualTo _sector) then {
                _x setVariable ["commy_sector", objNull, true];
            };
        } forEach (_cleanupQuene - _arrivedUnits);

        _sector setVariable ["cleanupQuene", _departedUnits];
        if (_sector getVariable ["active", false]) then {
          // calc new sector score
          {
              private _side = side group _x;

              if (_side isEqualTo west) then {
                  _score = _score + _deltaT;
              } else {
                  if (_side isEqualTo east) then {
                      _score = _score - _deltaT;
                  };
              };
          } forEach _unitsInSector;

          _score = (_score min (MAX_SCORE)) max -(MAX_SCORE);
          _sector setVariable ["score", _score, true];
          _sector setVariable ["lastUpdateTime", cba_missionTime];
        };
        // synchronize changes
        private _side = _sector getVariable "side";
        private _color = [1,1,1,1];

        if (abs _score > (NEUTRAL_SCORE_THRESHOLD)) then {
            if (_score >= 0) then {
                _side = "west";
                _color = if (_sector getVariable ["active", false]) then {
                  [
                    profileNamespace getVariable ["Map_BLUFOR_R", 0],
                    profileNamespace getVariable ["Map_BLUFOR_G", 0],
                    profileNamespace getVariable ["Map_BLUFOR_B", 1],
                    linearConversion [0, 15, abs _score, 0, 1]
                  ];
                } else {
                  [
                    profileNamespace getVariable ["Map_BLUFOR_R", 0],
                    profileNamespace getVariable ["Map_BLUFOR_G", 0],
                    profileNamespace getVariable ["Map_BLUFOR_B", 1],
                    linearConversion [0, 15, abs _score, 0, 0.25]
                  ];
                };
            } else {
                _side = "east";
                _color = if (_sector getVariable ["active", false]) then {
                  [
                      profileNamespace getVariable ["Map_OPFOR_R", 1],
                      profileNamespace getVariable ["Map_OPFOR_G", 0],
                      profileNamespace getVariable ["Map_OPFOR_B", 0],
                      linearConversion [0, 15, abs _score, 0, 1]
                  ];
                } else {
                  [
                      profileNamespace getVariable ["Map_OPFOR_R", 1],
                      profileNamespace getVariable ["Map_OPFOR_G", 0],
                      profileNamespace getVariable ["Map_OPFOR_B", 0],
                      linearConversion [0, 15, abs _score, 0, 0.25]
                  ];
                };
            };
        };

        private _previousSide = _sector getVariable ["side", "east"];

        if (_side != _previousSide) then {
            if (_side IN ["independent","GUER","RESISTANCE","WEST"]) then {
                missionNamespace setVariable ["commy_westSectorCount", commy_westSectorCount + 1, true];
            };

            if (_side == "east") then {
                missionNamespace setVariable ["commy_eastSectorCount", commy_eastSectorCount + 1, true];
            };

            if (_previousSide IN ["independent","GUER","RESISTANCE","west"]) then {
                missionNamespace setVariable ["commy_westSectorCount", commy_westSectorCount - 1, true];
            };

            if (_previousSide == "west") then {
                missionNamespace setVariable ["commy_eastSectorCount", commy_eastSectorCount - 1, true];
            };

            _sector setVariable ["side", _side];
        };
        _sector setVariable ["color", _color, true]; // public

    }, 1/(CHECK_SECTOR_FREQUENCY), [0]] call CBA_fnc_addPerFrameHandler;


    zumi_frequenzen = [
  			[30,90], //VHF SEM 52SL/70/80/90
  			[2400,2402.55], //UHF 343
  			[0,1000] //Frei programmierbare 148/152/117
  		];
  	  publicVariable "zumi_frequenzen";
      zumi_jammers = [];
      publicVariable "zumi_jammers";
};



if (hasInterface) then {

  [{
      (_this select 0) params ["_iterator"];
      if (_iterator >= 5) then {
          _iterator = 0;
      };
      (_this select 0) set [0, _iterator + 1];
      private _unit = [] call CBA_fnc_currentUnit;
      private _sector = _unit getVariable ["commy_sector", objNull];
      private _score = _sector getVariable ["score", 0];
      [_score, isNull _sector] call (uiNamespace getVariable "commy_fnc_updateScoreBar");
      if ((_unit getVariable ["323_logistiker", 0]) < 1) exitWith {};
      if ((_score > 5) || (isNull _sector)) then {
        _unit setVariable ["ACE_canMoveRallypoint", true];
      } else {
        _unit setVariable ["ACE_canMoveRallypoint", false];
      };
  }, 1, [0]] call CBA_fnc_addPerFrameHandler;

	["zumi_interaction_add_to_class", {
		params ["_klasse", "_interaktion", "_typ", "_parentpath", ["_inheritance", false]];
		[_klasse, _typ , _parentpath, _interaktion, _inheritance] call ace_interact_menu_fnc_addActionToClass;
	}] call CBA_fnc_addEventHandler;

	["zumi_interaction_remove_from_class", {
		params ["_klasse","_pfad","_typ"];
		[_klasse, _typ, _pfad] call ace_interact_menu_fnc_removeActionFromClass;
	}] call CBA_fnc_addEventHandler;

	["zumi_interaction_add_to_object", {
		params ["_unit", "_interaktion", "_typ", "_parentpath"];
		[_unit, _typ , _parentpath, _interaktion] call ace_interact_menu_fnc_addActionToObject;
	}] call CBA_fnc_addEventHandler;

	["zumi_interaction_remove_from_object", {
		params ["_unit","_pfad","_typ"];
		[_unit, _typ, _pfad] call ace_interact_menu_fnc_removeActionFromObject;
	}] call CBA_fnc_addEventHandler;

	["zumi_ace_carry", {
		params ["_class","_bool"];
		[_class, _bool] call ace_dragging_fnc_setCarryable;
	}] call CBA_fnc_addEventHandler;

	["zumi_ace_cargo", {
		params ["_class","_size"];
		[_class, _size] call ace_cargo_fnc_setSize;
	}] call CBA_fnc_addEventHandler;

	["zumi_hinweis", {
	  params [["_message", "testmessage"], ["_sound", false], "_dauer", ["_prio", 0]];
		[_message, _sound, _dauer, _prio] call ace_common_fnc_displayText;
	}] call CBA_fnc_addEventHandler;

	["zumi_cba_hinweis", {
	  params ["_message"];
		_message call CBA_fnc_notify;
	}] call CBA_fnc_addEventHandler;


  ["zumi_intel_init", {
		params ["_object"];
		[_object] call BIS_fnc_initIntelObject;
	}] call CBA_fnc_addEventHandler;

	["zumi_intel", {
    //_typ, _task, _genutzt_durch, _dauer, _info
	  params [["_markerdetails", []]];
		if (_markerdetails isEqualTo []) exitWith {};
		_markerdetails params ["_pos", ["_text", "Here"], ["_type", "hd_unknown"], ["_color", "ColorEast"], ["_size", []]];
    if ({(getMarkerPos _x) isEqualTo _pos} count intelmarker > 0) exitWith {};
		_marker = createMarkerLocal [format ["marker_%1", (count intelmarker) + 1], _pos];
		_marker setMarkerTypeLocal _type;
		_marker setMarkerColorLocal _color;
		_marker setMarkerTextLocal _text;
    intelmarker pushBack _marker;
		if (_size isEqualTo []) exitWith {};
		_size params [["_a", 1], ["_b", 1]];
		_marker setMarkerSizeLocal [_a, _b];
	}] call CBA_fnc_addEventHandler;

};


if (isServer) then {

  ["zumi_intel_create", {
		params ["_pos", "_intelparams", ["_hiddenweapons", []], ["_object", selectRandom ["Land_File1_F","Land_FilePhotos_F"]]];
		_intelparams params [["_text", ["Unreadable Intel","Bloody documents",""]], ["_inteldetails", []], ["_eh", true], ["_pic", "a3\structures_f_epc\Items\Documents\Data\document_secret_01_co.paa"], ["_recipients", west], ["_RscAttributeOwners", [west]], ["_id", -1]];
		_intel = if (_hiddenweapons isEqualTo []) then {
      createVehicle [_object, _pos, [], 0, "CAN_COLLIDE"]
    } else {
      //Create Weaponholder
      createVehicle ["GroundWeaponHolder_Scripted", _pos, [], 0, "CAN_COLLIDE"]
    };
    if !(_hiddenweapons isEqualTo []) then {
      _hiddenweapons params [["_wep", []], ["_ammo", []], ["_grenades", []], ["_backpack", ""]];
      if !(_wep isEqualTo []) then {
        _wep params [["_weapon", ""], ["_muzzle", ""], ["_flashlight", ""], ["_optics", ""], ["_primarymag", []], ["_secondarymag", []], ["_bipod", ""]];
        _intel addWeaponWithAttachmentsCargoGlobal [[_weapon, _muzzle, _flashlight, _optics, _primarymag, _secondarymag, _bipod], 1];
      };
      if !(_ammo isEqualTo []) then {
        {
          _x params ["_magclass", "_amount"];
          _intel addMagazineCargoGlobal [_magclass, _amount];
        } forEach _ammo;
      };
      if !(_grenades isEqualTo []) then {
        {
          _x params ["_wepclass", "_amount"];
          _intel addMagazineCargoGlobal [_wepclass, _amount];
        } forEach _grenades;
      };
      if !(_backpack isEqualTo "") then {
        [_intel, _backpack] call CBA_fnc_addBackpackCargo;
      };
    };
		_intel setVariable ["RscAttributeDiaryRecord_texture", _pic, true];
		[_intel, "RscAttributeDiaryRecord",	_text] call BIS_fnc_setServerVariable;
		_intel setVariable ["recipients", _recipients, true];
		_intel setVariable ["RscAttributeOwners", _RscAttributeOwners, true];
		_intel setVariable ["intel", _inteldetails];
    _intel setVariable ["reveal", _id];
		if (_eh) then {
			[
				_intel,
				"IntelObjectFound", {
		  		params ["_intelobj", "_gefunden_durch"];
					_markerinfos = _intelobj getVariable ["intel", []];
          _revealed = _intelobj getVariable ["reveal", -1];
          if (_revealed >= 0) then {
            if (count zumi_stellungen >= (_id + 1)) then {
              (zumi_stellungen select _id) set [6, true];
            };
          };
					private _jip_str = ["zumi_intel", [_markerinfos]] call CBA_fnc_globalEventJIP;
					[_jip_str, _intelobj] call CBA_fnc_removeGlobalEventJIP;
		  	}
		  ] call BIS_fnc_addScriptedEventHandler;
		};
		private _jip_str = ["zumi_intel_init", [_intel]] call CBA_fnc_globalEventJIP;
		[_jip_str, _intel] call CBA_fnc_removeGlobalEventJIP;

	}] call CBA_fnc_addEventHandler;

  ["ace_rallypointMoved", {
    params ["_rp","_side","_pos"];
    _rp setVariable ["ace_respawn_markerDate", "Forward Operating Base", true];
    ["ace_rallypointMoved", [_rallypoint, _side, _position]] call CBA_fnc_remoteEvent;
  }] call CBA_fnc_addEventHandler;

  for "_i" from 1 to 15 do {
    [missionNameSpace, format ["loadout_%1", _i]] call BIS_fnc_addRespawnInventory;
  };

  ["zumi_fliegeralarm", {
    params ["_timestamp"];
    {
      for "_i" from 1 to 7 do {
        [
          {
            params ["_sirene"];
            [_sirene, ["air_raid", 1000]] call CBA_fnc_globalSay3d;
          },
          [_x],
          _i * 8
        ] call CBA_fnc_waitAndExecute;
      };
      _x setVariable ["alarmiert", CBA_missiontime + 900];
		} forEach (zumi_fliegeralarme select {((_x getVariable ["alarmiert", 0]) < cba_missionTime)});
  }] call CBA_fnc_addEventHandler;

  ["zumi_respawn_add", {
	  params ["_respawn", ["_name", "Name leer"]];
		[missionNamespace, _respawn, _name] call BIS_fnc_addRespawnPosition;
	}] call CBA_fnc_addEventHandler;

  ["zumi_respawn_remove", {
    params ["_respawn"];
    [missionNamespace, _respawn] call BIS_fnc_removeRespawnPosition;
  }] call CBA_fnc_addEventHandler;

  [missionNamespace, "respawn_independent", "Hauptquartier"] call BIS_fnc_addRespawnPosition;

	//ACEX Fortification Eventhandler
	 ["acex_fortify_objectPlaced",
	  {
	   params ["_unit", "_side", "_newobject"];
		 [{params ["_unit", "_side", "_newobject"];
		 _pos = getPosATL _newobject;
	   _pby = ([_newobject] call ace_common_fnc_getPitchBankYaw);
	   fortify_objekte_temp pushBack [_newobject, str _pos, str _pby];

		 }, [_unit, _side, _newobject]] call CBA_fnc_execNextFrame;
	 	}
	 ] call CBA_fnc_addEventHandler;

	["acex_fortify_objectDeleted",
		{
			params ["_player", "_side", "_target"];
			if (count fortify_objekte_temp < 1) exitWith {};
			{
				if (((fortify_objekte_temp select _forEachindex) select 0) == _target) then {
					fortify_objekte_temp deleteAt _forEachindex;
				};
			} forEach fortify_objekte_temp;
		}
	] call CBA_fnc_addEventHandler;


  [
	 "Air",
	 "GetIn",
	 {
		params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
		_typeOf = typeOf _vehicle;
    private _id = (_vehicle getVariable ["id", -1]);
    private _index = [_unit] call ace_common_fnc_getTurretIndex;
    _unit setVariable ["vehicle", [_id, _role, _index]];
	 },
	 true,
	 ["ParachuteBase"]
	] call CBA_fnc_addClassEventHandler;

  [
   "Air",
   "GetOut",
   {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
    _typeOf = typeOf _vehicle;
    private _id = (_vehicle getVariable ["id", -1]);
    _unit setVariable ["vehicle", [-1, "", []]];
   },
   true,
   ["ParachuteBase"]
  ] call CBA_fnc_addClassEventHandler;

  [
	 "Car",
	 "GetIn",
	 {
		params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
		_typeOf = typeOf _vehicle;
    private _id = (_vehicle getVariable ["id", -1]);
    private _index = [_unit] call ace_common_fnc_getTurretIndex;
    _unit setVariable ["vehicle", [_id, _role, _index]];
	 },
	 true,
	 []
	] call CBA_fnc_addClassEventHandler;

  [
   "Car",
   "GetOut",
   {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
    _typeOf = typeOf _vehicle;
    private _id = (_vehicle getVariable ["id", -1]);
    _unit setVariable ["vehicle", [-1, "", []]];
   },
   true,
   []
  ] call CBA_fnc_addClassEventHandler;

  [
	 "Tank",
	 "GetIn",
	 {
		params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
		_typeOf = typeOf _vehicle;
    private _id = (_vehicle getVariable ["id", -1]);
    private _index = [_unit] call ace_common_fnc_getTurretIndex;
    _unit setVariable ["vehicle", [_id, _role, _index]];
	 },
	 true,
	 []
	] call CBA_fnc_addClassEventHandler;

  [
   "Tank",
   "GetOut",
   {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
    _typeOf = typeOf _vehicle;
    private _id = (_vehicle getVariable ["id", -1]);
    _unit setVariable ["vehicle", [-1, "", []]];
   },
   true,
   []
  ] call CBA_fnc_addClassEventHandler;

	//Piloten

	[
	 "Air",
	 "GetIn",
	 {
		params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
		_typeOf = typeOf _vehicle;
		_recht = _unit getVariable ["323_pilot", 0];
		if (_role IN ["gunner", "turret"]) exitWith {
			if (count _turret > 0) then {
				_turret params ["_main", ["_second", -1]];
				if ((_main < 1) && (_second < 0)) then {
					if (_recht < 1) exitWith {
		        moveOut _unit;
		        ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit];
		      };
					if (_TypeOf isKindOf "plane") then {
						if (_recht < 2) exitWith {
			        moveOut _unit;
			        ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit];
			      };
					};
				};
			};
		};
		if (_role IN ["driver", "commander"]) exitWith {
			if (_recht < 1) exitWith {
				moveOut _unit;
				["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit];
			};
			if (_TypeOf isKindOf "plane") then {
				if (_recht < 2) exitWith {
					moveOut _unit;
					["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit];
				};
			};
		};
	 },
	 true,
	 ["ParachuteBase"]
	] call CBA_fnc_addClassEventHandler;


	[
	 "Air",
	 "SeatSwitched",
	 {
		 params ["_vehicle", "_unit1", "_unit2"];
     if (!isPlayer _unit1) exitWith {};
		 _role = _unit1 call CBA_fnc_vehicleRole;
		 _typeOf = typeOf _vehicle;
		 _recht = _unit1 getVariable ["323_pilot", 0];
		 if (_role IN ["gunner", "turret"]) exitWith {
			 _fullcrew = (fullCrew _vehicle);
			 _index = (_fullcrew findIf {(_x select 0) isEqualTo _unit1});
			 if (_index >= 0) then {
				 (_fullcrew select _index) params ["_player", "_role", "_cargoIndex", "_turretPath", "isPerson"];
				 _turretPath params ["_main", ["_second", -1]];
				 if ((_main < 1) && (_second < 0)) then {
					 if (_recht < 1) exitWith {
						 moveOut _unit1;
						 _unit1 moveInCargo _vehicle;
						 ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit1];
			 		 };
					 if (_TypeOf isKindOf "plane") then {
 						if (_recht < 2) exitWith {
 			        moveOut _unit1;
 			        ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit1];
 			      };
 					};
				 };
			 };
		 };
		 if (_role IN ["driver", "commander"]) exitWith {
			 if (_recht < 1) exitWith {
			 moveOut _unit1;
			 _unit1 moveInCargo _vehicle;
			 ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit1];
	 		};
			if (_TypeOf isKindOf "plane") then {
				if (_recht < 2) exitWith {
					moveOut _unit1;
					["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit1];
				};
			};
		};
	 },
	 true,
	 ["ParachuteBase"]
	] call CBA_fnc_addClassEventHandler;

	//Panzer
	[
	 "Tank",
	 "GetIn",
	 {
		params ["_vehicle", "_role", "_unit", "_turret"];
    if (!isPlayer _unit) exitWith {};
		_typeOf = typeOf _vehicle;
		_recht = _unit getVariable ["323_panzer", 0];
		if (_role IN ["gunner", "turret"]) exitWith {
			if (count _turret > 0) then {
				_turret params ["_main", ["_second", -1]];
				if ((_main < 1) && (_second < 0)) then {
					if (_recht < 1) exitWith {
						moveOut _unit;
						["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit];
					};
				};
			};
		};
		if (_role IN ["driver", "commander"]) exitWith {
			if (_recht < 1) exitWith {
				moveOut _unit;
				["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit];
			};
		};
	 },
	 true,
	 []
	] call CBA_fnc_addClassEventHandler;

	[
	 "Tank",
	 "SeatSwitched",
	 {
		 params ["_vehicle", "_unit1", "_unit2"];
     if (!isPlayer _unit1) exitWith {};
		 _role = _unit1 call CBA_fnc_vehicleRole;
		 _typeOf = typeOf _vehicle;
		 _recht = _unit1 getVariable ["323_panzer", 0];
		 if (_role IN ["gunner", "turret"]) exitWith {
			 _fullcrew = (fullCrew _vehicle);
			 _index = (_fullcrew findIf {(_x select 0) isEqualTo _unit1});
			 if (_index >= 0) then {
				 (_fullcrew select _index) params ["_player", "_role", "_cargoIndex", "_turretPath", "isPerson"];
				 _turretPath params ["_main", ["_second", -1]];
				 if ((_main < 1) && (_second < 0)) then {
					 if (_recht < 1) exitWith {
						 moveOut _unit1;
						 _unit1 moveInCargo _vehicle;
						 ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit1];
					 };
				 };
			 };
		 };
		 if (_role IN ["driver", "commander"]) exitWith {
			 if (_recht < 1) exitWith {
			 moveOut _unit1;
			 _unit1 moveInCargo _vehicle;
			 ["Sie sind dazu nicht autorisiert!", true, 5, 1] remoteExecCall ["ace_common_fnc_displayText", _unit1];
			};
		};
	 },
	 true,
	 []
	] call CBA_fnc_addClassEventHandler;

  [
   "Car",
   "GetIn",
   {
    params ["_vehicle", "_role", "_unit", "_turret"];
    if ((!isPlayer _unit) || (_vehicle getVariable ["stolen", false])) exitWith {};
    if ((_vehicle getVariable ["id", -2]) > -2) then {
      _vehicle setVariable ["stolen", true];
      ["zumi_sanktion", [-5, (_vehicle getVariable ["id", 0])]] call CBA_fnc_localEvent;
    };
   },
   true,
   []
  ] call CBA_fnc_addClassEventHandler;

};
