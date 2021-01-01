#include "sectorsConfig.hpp"

task_running = false;

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

  order_in_progress = false;
  publicVariable "order_in_progress";

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
        _sector setVariable ["color", [0,1,0,1], true]; // public
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
        private _color = [0,1,0,1];

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

};




if (isServer) then {

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
