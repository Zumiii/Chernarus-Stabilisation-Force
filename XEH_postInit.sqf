
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

	player addEventHandler ["TaskSetAsCurrent", {
    params ["_unit", "_task"];
		if (_task isEqualTo "") exitWith {};
		_task = (_unit call BIS_fnc_taskCurrent);
		/*
		if !(([_task] call BIS_fnc_taskType) isEqualTo "default") exitWith {
			hint "Das ist noch nicht implementiert!";
		};
		*/
    if ((_unit != (leader group _unit)) || ((_unit getVariable ["entscheidungsbefugnis", 0]) < 1)) exitWith {
      hint "Nur befähigte Gruppenführer dürfen Einsatzziele festlegen";
      //Todo: Resette den Currenttask

    };
    private _parentTask = _task call BIS_fnc_taskParent;
    if (task_running) exitWith {
        hint "Ein Angriffsziel wurde bereits ausgesucht";
    };
    private _taskpos = _task call BIS_fnc_taskDestination;
    private _description = _task call BIS_fnc_taskDescription;
    //Feuere ServerEvent ab
    ["zumi_task_assigned", [_task, _taskParent, _taskpos, _description, _unit]] call cba_fnc_serverEvent;
  }];

  ["zumi_task_intel",{
    params ["_task", "_intelparams"];
    _intelparams params ["_subject", "_text", ["_taskstate", ""]];
    _taskState = if (_taskState isEqualTo "") then {_task call BIS_fnc_taskState} else {_taskState};
    player createDiaryRecord [_subject, _text, _task, _taskState];
  }] call CBA_fnc_addEventHandler;

	["zeus", {
	    ["commy_registerCurator", player] call CBA_fnc_serverEvent;
	}, "adminLogged"] call CBA_fnc_registerChatCommand;

	["ace_arsenal_displayOpened",{
 		params ["_display"];
		if ((player getVariable ["323_logistiker", 0]) > 0) exitWith {};
		[
			{
				params ["_display"];
				ctrlActivate  (_display displayCtrl 2018);
				[_display, (_display displayCtrl 2018)] call ace_arsenal_fnc_fillLeftPanel;
			},
			[_display]
		] call CBA_fnc_execNextFrame;

		{
 			private _button = _display displayCtrl _x;
 			_button ctrlSetText "\A3\Ui_f\data\IGUI\Cfg\Actions\ico_OFF_ca.paa";
 			_button ctrlEnable false;
 			_button ctrlSetTooltip "Disabled by mission maker";
		} forEach [1003, 1004, 1005, 2002, 2003, 2004, 2006, 2010, 2012, 2014, 2037, 3002, 3004];
	}] call CBA_fnc_addEventHandler;

	["ace_explosives_defuse", {
    params ["_ied","_pio"];
    [_ied, _pio] remoteExecCall ["zumi_fnc_handle_ied_defused", 2];
  }] call CBA_fnc_addEventHandler;

	["ace_common_playActionNow", {
	  params ["_player","_anim"];
		if !(_player call CBA_fnc_canUseWeapon) exitwith {};
		if (_anim isEqualTo "gestureAdvance") exitwith {
			private _getdoor = ([3] call ace_interaction_fnc_getDoor);
			_getdoor params [["_house", objNull],["_door", ""]];
			if (_door != "") then {
					[_house, "knock", 25] call CBA_fnc_globalSay3d;
					_array = [_house, _door] call ace_interaction_fnc_getDoorAnimations;
					_array params [["_animations", []], ["_lockedVariable", []]];
			};
		};
		private _entities = (_player nearEntities [["CAManBase", "LandVehicle"], 25]) select {
			(!isNull _x) && !([_x] call ace_common_fnc_isPlayer)  && (alive _x) && (!isNull driver _x) && !(driver _x getVariable ["ace_captives_isHandcuffed", false]) && ((side _x) IN [civilian, west]) && ([position _player, getDir _player, 30, position _x] call BIS_fnc_inAngleSector)
		};
		{
		  switch _anim do {
		    case "ace_gestures_Hold" : {
					["zumi_anim", [_player, _x, 0], _x] call CBA_fnc_targetEvent;
		    };
		    case "ace_gestures_HoldStandLowered" : {
					["zumi_anim", [_player, _x, 1], _x] call CBA_fnc_targetEvent;
		    };
		    case "ace_gestures_ForwardStandLowered" ;
		    case "ace_gestures_Forward" : {
					["zumi_anim", [_player, _x, 2], _x] call CBA_fnc_targetEvent;
		    };
				default {};
			};
		} forEach _entities;
	}] call CBA_fnc_addEventHandler;

	["ace_common_playActionNow", {
	  params ["_player","_anim"];
		switch _anim do {
			case "gestureAdvance" : {
   			private _getdoor = ([2] call ace_interaction_fnc_getDoor);
   			_getdoor params [["_house", objNull],["_door", ""]];
   			if (_door != "") then {
  				[_player, "knock", 25] call CBA_fnc_globalSay3d;
  				_array = [_house, _door] call ace_interaction_fnc_getDoorAnimations;
  				_array params [["_animations", []], ["_lockedVariable", []]];
					private _owner = _house getVariable ["owner", objNull];
					if ((isNull _owner) || (!(alive _owner)) || (_owner distance2d _player > 15)) exitWith {
						["zumi_cba_hinweis", [["There is no one home"]]] call CBA_fnc_localEvent;
					};
					if ((_owner getVariable ["door_to_answer", ""]) != "") exitWith {
						["zumi_cba_hinweis", [["There is already someone answering the door"]]] call CBA_fnc_localEvent;
					};
					_player reVeal [_owner, 4];
					if ((_owner getVariable ["renitenz", 0]) >= 3) exitWith {
						["zumi_cba_hinweis", [["The house owner does not want you to enter"]]] call CBA_fnc_localEvent;
					};
					_owner setVariable ["door_to_answer", format ["%1_rot", _door], true];
					[_owner] call CBA_fnc_clearWaypoints;
					[[_owner]] call ace_ai_fnc_unGarrison;
					[[[_owner, (_player call cba_fnc_getPos) getPos [0.5, (getDir _player)]]]] call ace_ai_fnc_garrisonMove;
					["zumi_cba_hinweis", [["Someone heard you and seems to be answering the door"]]] call CBA_fnc_localEvent;
					[{
      			params ["_args", "_pfhID"];
						_args params ["_u", "_h","_p","_anim","_d"];
						if ((isNull _u) || (!(alive _u)) || (!(alive _h))) exitWith {
							_pfhID call CBA_fnc_removePerFrameHandler;
						};
						//if (_u getVariable ["ace_ai_garrisonned", false]) exitWith {
						if (isNil {_u getVariable ["ace_ai_garrisonMove_failSafe", nil]}) exitWith {
							_pfhID call CBA_fnc_removePerFrameHandler;
							_u setVariable ["door_to_answer", "", true];
							if ((_h getVariable [format ["bis_disabled_%1", _d], 0]) > 0) then {
								[_h, "unlock", 25] call CBA_fnc_globalSay3d;
								_h setVariable [format ["bis_disabled_%1", _d], 0, true];
								["zumi_cba_hinweis", [["The door unlocks, you may enter"]]] call CBA_fnc_localEvent;
							} else {
								["zumi_cba_hinweis", [["You may enter"]]] call CBA_fnc_localEvent;
							};

						};
  				}, 0.5, [_owner, _house, _player, format ["%1_rot", _door], _door]] call CBA_fnc_addPerFrameHandler;
   			};
   		};
			default {};
		};
}] call CBA_fnc_addEventHandler;

[player, "fired", {
    params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if !(_weapon IN ["rhs_weap_M590_8RD","rhs_weap_M590_5RD"]) exitWith {};
    private _return1 = ([4] call ace_interaction_fnc_getDoor);
    _return1 params [["_house", objNull], ["_door",""]];
    if ((_door isEqualTo "") || (isNull _house)) exitWith {};
    private _return = [_house, _door] call ace_interaction_fnc_getDoorAnimations;
    _return params [["_animations", []], ["_lockedVariable", []]];
    if (_animations isEqualTo []) exitWith {};
   _house setVariable [format ["bis_disabled_%1", _door], 0, true];
   _house animate [_animations select 0, 1];
  }, currentWeapon player] call CBA_fnc_addBISEventHandler;

	[willkommensschild, "Lesen: Erstinformationen", "\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa", "\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa", "true", "true", {},{},{_txt = composeText [parsetext "<t align='left' font='PuristaBold'>Regel Nummer 1:", parseText "<br /><br />", parseText "Der Fussbuss fährt <t underline='1'>immer</t>!", parseText "<br /><br />", image "\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa", parseText "<br /><br /><br />",parsetext "<t align='left' font='PuristaBold'>Regel Nummer 2:", parseText "<br /><br />", "Geduld ist eine Tugend!", parseText "<br /><br />", image "\A3\ui_f\data\igui\cfg\simpleTasks\types\wait_ca.paa", parseText "<br /><br /><br />",parsetext "<t align='left' font='PuristaBold'>Regel Nummer 3:", parseText "<br /><br />", " Füge dich ein!", parseText "<br /><br />", image "\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa", parseText "<br /><br /><br />",parsetext "<t align='left' font='PuristaBold'>Regel Nummer 4:", parseText "<br /><br />", "Um CoD zu spielen drücke jetzt Alt + F4!", parseText "<br /><br />", image "\A3\ui_f\data\igui\cfg\simpleTasks\types\exit_ca.paa", parseText "<br /><br /><br /><br />", parsetext "<t align='center' font='PuristaBold'> Prüfe dein Briefing für mehr Infos!"]; hint _txt;},{}, [], 1, 0, false, false, true] call BIS_fnc_holdActionAdd;


};

if (isServer) then {

	private _inidbi = ["new", "us"] call OO_INIDBI;


	["zumi_task_assigned",{
    params ["_task", "_taskParent", "_taskpos", "_description", "_unit"];
    _description params ["_desc", "_title", ["_marker", ""]];
		//Update den Tasktype und löse ggf. Task aus
		private _sector = (commy_sectors select {(_x getVariable ["center", [0,0,0]]) isEqualTo _taskpos}) select 0;
		private _score = _sector getVariable ["score", 0];
		switch (true) do {

	    case (_score >= 5) : {
				[_task, "defend"] call BIS_fnc_taskSetType;
				//TODO Defend Task
				"Das wurde noch nicht implementiert..." remoteExecCall ["hint", _unit];
	    };
	    case ((_score < 5) && (_score > -5)) : {
				[_task, "walk"] call BIS_fnc_taskSetType;
				[_task, _taskParent, _taskpos, _description, _sector] call zumi_fnc_patrol;
				task_running = true;
				publicVariable "task_running";
				running_tasks pushbackUnique [_taskParent, _task, _taskpos, _unit, timestamp, restart_nummer];
	    };
	    case (_score <= -5) : {
				if (count ([_taskpos, 1500, [west,civilian,east,resistance], ["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) > 0) exitWith {"Im gewünschten Gebiet dürfen aus Gründen der Immersion keine Spieler im Umkreis von 1500 Metern präsent sein..." remoteExecCall ["hint", _unit];};
				[_task, "attack"] call BIS_fnc_taskSetType;
				task_running = true;
				publicVariable "task_running";
				running_tasks pushbackUnique [_taskParent, _task, _taskpos, _unit, timestamp, restart_nummer];
				//TODO: Call Missionscript
				[_task, _taskParent, _taskpos, _description] call zumi_fnc_attack;
	    };
	    default {

			};

	  };

  }] call CBA_fnc_addEventHandler;

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
    ["ace_rallypointMoved", [_rp, _side, _pos]] call CBA_fnc_remoteEvent;
  }] call CBA_fnc_addEventHandler;

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


	//FOB Position
	rp_pos = ["read", ["Missionspersistenz", "rp_pos", [15100.4,7509.18,0]]] call _inidbi;
	rallypoint setPosASL rp_pos;
	["ace_rallypointMoved", [rallypoint, west, rp_pos]] call CBA_fnc_globalEventJIP;

	//ACE Cargo Eventhandler
	["ace_cargoLoaded", {
			params ["_item", "_vehicle"];
			_cargo = _vehicle getVariable ["id", 0];
			_item setVariable ["verladen", _cargo];
	}] call CBA_fnc_addEventHandler;

	//ACE Cargo Eventhandler
	["ace_cargoUnloaded", {
			params ["_item", "_vehicle"];
			_item setVariable ["verladen", 0];
	}] call CBA_fnc_addEventHandler;

	Zumi_ieds = [];
	Zumi_carbombs = [];


  ["Loudspeakers_EP1", "InitPost", {
   	params ["_entity"];
  	zumi_fliegeralarme pushBack _entity;
  }, true, [], true] call CBA_fnc_addClassEventHandler;

	//Handle Disconnect
	addMissionEventHandler ["HandleDisconnect", {
		params ["_p", "_id", "_uid", "_name"];
		private _inidbi = ["new", "us"] call OO_INIDBI;
    private _unitLoadout = getUnitLoadout [_p, false];
    ["write", ["Spielerliste",
      //Eintragsname
      _uid,
      [
        //LOADOUT
        [_unitLoadout] call acre_api_fnc_filterUnitLoadout,
        //MEDIZINISCHES
        [
          _p getVariable ["isDeadPlayer", false],
          _p getVariable ["ACE_isUnconscious", false],
          parseNumber ([(_p getVariable ["acex_field_rations_thirst", 0]), 1, 4] call CBA_fnc_formatNumber),
          parseNumber ([(_p getVariable ["acex_field_rations_hunger", 0]), 1, 4] call CBA_fnc_formatNumber)
        ],
        [
          _p getVariable ["ace_medical_medicClass", 0],
          _p getVariable ["ACE_IsEngineer", 0],
          _p getVariable ["ACE_isEOD", false],
          _p getVariable ["323_pilot", 0],
          _p getVariable ["323_panzer", 0],
          _p getVariable ["323_logistiker", 0],
          _p getVariable ["323_keys", []],
          _p getVariable ["323_waka", 1]
        ],
        getPosATL _p,
        [restart_nummer, cba_missiontime],
        _name,
        (_p getVariable ["BIS_fnc_setUnitInsignia_class", ""]),
				(_p getVariable ["vehicle", [-1, ""]])
      ]
    ]] call _inidbi;
		false;
}];


	//Zündungen über ACE werden registriert, wenn sie vom Gegner stammen.
	[{
			params ["_unit", "_range", "_explosive", "_fuzeTime", "_triggerItem"];
			if (side _unit == east || _explosive in zumi_ieds) then {
				ieds_gesprengt = ieds_gesprengt + 1;
				//TODO: Nächste Ortschaft destabilisieren?
				["zumi_sanktion", [-5, _explosive getVariable ["id", -1]]] call CBA_fnc_serverEvent;
			};
			true
	}] call ace_explosives_fnc_addDetonateHandler;

	//Gezündete IEDs erzeugen Angst
	["ace_explosives_detonate", {

		params ["_unit", "_explosive", "_delay"];
		_scared = allUnits select {(_x distance2d _explosive <= 100) && !(isPlayer _x) && (side _x) == CIVILIAN && (alive _x)};
		{
			[
				{
					params ["_unit"];
					if (isNull _unit || (!alive _unit) || ((_unit getVariable ["in_deckung", 0]) > 0)) exitWith {};
					[_unit, "ApanPercMstpSnonWnonDnon_ApanPpneMstpSnonWnonDnon" , 2] call ace_common_fnc_doAnimation;
					_unit setVariable ["hat_angst", true];
					_unit setVariable ["in_deckung", 1, true];
				},
				[_x],
				1 + round random 2
			] call cba_fnc_waitandexecute;
		} forEach _scared;

		{
			[
				{
					params ["_unit"];
					if (isNull _unit || (!alive _unit)) exitWith {};
					[_unit, "ApanPpneMstpSnonWnonDnon_ApanPercMstpSnonWnonDnon" , 2] call ace_common_fnc_doAnimation;
					_unit setVariable ["hat_angst", false];
					_unit setVariable ["in_deckung", 0, true];
				},
				[_x],
				15 + round random 16
			] call cba_fnc_waitandexecute;
		} forEach _scared;

	}] call CBA_fnc_addEventHandler;

	["commy_registerCurator", {
	    params ["_unit"];

	    private _curator = createGroup sideLogic createUnit ["ModuleCurator_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
	    _curator setVariable ["addons", 3, true];
	    _curator addCuratorEditableObjects [allMissionObjects "", true];
	    _unit assignCurator _curator;

	    "Registered as Curator." remoteExec ["systemChat", _unit];
	}] call CBA_fnc_addEventHandler;



	["zumi_ai_loss", {
		params ["_unit", "_side"];
		_unit setVariable ["tod", cba_missiontime];
		switch _side do {
			case east : {
				east_losses = east_losses + 1;
			};
			case west : {
				west_losses = west_losses + 1;
			};
			case resistance : {
				ind_losses = ind_losses + 1;
			};
			default {
				civ_losses = civ_losses + 1;
				["zumi_sanktion", [-5, (_unit getVariable ["id", -1])]] call CBA_fnc_localEvent;
			};
		};
	}] call CBA_fnc_addEventHandler;

	/*

		Das schwarze Brett

	*/


	_waka = ["Waka", "Access the Armory",["\A3\ui_f\data\igui\cfg\simpleTasks\types\armor_ca.paa", "#003311"],{
		params ["_t","_p","_actionparams"];
		createDialog "waka_dialog";
	},{((_player getVariable ["323_waka", 0]) > 0)}, {}, [], [0,0,0], 5] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [waka, _waka, 0, []]] call CBA_fnc_globalEventJIP;

	_arsenal = ["Arsenal", "Ace Arsenal",[""],{
		params ["_t","_p","_actionparams"];
		[_p, _p, true] call ace_arsenal_fnc_openBox;
	},{true}, {}, [], [0,0,0], 0] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [waka, _arsenal, 0, ["Waka"]]] call CBA_fnc_globalEventJIP;


	//Fullheal

	_insertChildren = {
	  params ["_target", "_player", "_params"];
	  _params params ["_mash"];
	  // Add children to this action
	  private _actions = [];
	  {
	      private _childStatement = {
	        params ["_target", "_player", "_params"];
	        _params params ["_playertoheal"];
	        ["ace_medical_treatment_fullHealLocal", [_playertoheal], _playertoheal] call CBA_fnc_targetEvent;
	      };
	      private _action = [format ["%1", name _x], _x, "", _childStatement, {true}, {}, [_x],"",4,[false, false, false, false, false], {
	        params ["_target", "_player", "_params", "_actionData"];
	        _params params ["_playertoheal"];
	        // Modify the action - index 1 is the display name, 2 is the icon...
	        _actionData set [1, format ["%1", [_playertoheal] call ace_common_fnc_getName]];
	      }
	    ] call zumi_fnc_interaction_create;
	      _actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
	  } forEach (
	    ([] call cba_fnc_players) select {_x distance2d _mash <= 20}
	  );
	  _actions
	};
	_fullheal = ["Fullheal", "Cure",["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa", "#FF69B4"],{
		params ["_t","_p","_actionparams"];

	},{true},_insertChildren,[mash]] call zumi_fnc_interaction_create;

	_jip_str = ["zumi_interaction_add_to_object", [mash, _fullheal, 0, []]] call CBA_fnc_globalEventJIP;
	[_jip_str, mash] call CBA_fnc_removeGlobalEventJIP;


	//Teleports

	_tp_airfield = ["tp_airfield", "Teleport to airfield",["\A3\ui_f\data\igui\cfg\simpleTasks\types\plane_ca.paa"],{
		params ["_t","_p","_actionparams"];
		_p setPosASL (getPosASL airfield);
	},{true}, {}, [], [0,0,-3], 4] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [HQ, _tp_airfield, 0, []]] call CBA_fnc_globalEventJIP;


	_tp_briefing = ["tp_briefing", "Teleport to briefing area",["\A3\ui_f\data\igui\cfg\simpleTasks\types\whiteboard_ca.paa"],{
		params ["_t","_p","_actionparams"];
		_p setPosASL (getPosASL HQ);
	},{true}, {}, [], [0,0,1], 4] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [airfield, _tp_briefing, 0, []]] call CBA_fnc_globalEventJIP;

	//Powerswitches
	_powerswitch = ["Powerswitch","Hit the power switch","\A3\ui_f\data\igui\cfg\simpleTasks\types\use_ca.paa",{
	 params ["_t","_p","_actionparams"];
	 switch (_t animationSourcePhase "SwitchPosition") do {
		case 0 : {
		 {
			private _jip_str = ["ace_interaction_setLight", [_x, true]] call cba_fnc_GlobalEventJIP;
			[_jip_str, _x ] call CBA_fnc_removeGlobalEventJIP;
		 } forEach (_t nearObjects ["Lamps_base_F", 600]);
		 _t animate ["SwitchPosition", 1];
		};
		case 1 : {
		 {
			 private _jip_str = ["ace_interaction_setLight", [_x, false]] call cba_fnc_GlobalEventJIP;
	 		[_jip_str, _x ] call CBA_fnc_removeGlobalEventJIP;
		 } forEach (_t nearObjects ["Lamps_base_F", 600]);
		 _t animate ["SwitchPosition", 0];
		};
		default {
		 hint "Switch is currently being operated";
		};
	 };

	},{true},{},[],[0.25,-0.1,0.4], 1] call zumi_fnc_interaction_create;


 	["zumi_interaction_add_to_object", [powerswitch, _powerswitch, 0, []]] call CBA_fnc_globalEventJIP;
	/*

		Fahrzeugdepot und Spieler- bzw. Lagerverwaltung

	*/



	_lagerverwaltung = ["Lagerverwaltung","Logistics Management","\A3\ui_f\data\igui\cfg\simpleTasks\types\documents_ca.paa",{
		params ["_t","_p","_actionparams"];
	},{true},{},[],[0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [lagerlappy, _lagerverwaltung, 0, []]] call CBA_fnc_globalEventJIP;

	_bestellungen = ["Bestellungsuebersicht","Delivery overview","\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa",{
	  params ["_t","_p","_actionparams"];
	  createDialog "lagerverwaltung_dialog";
	},{true},{},[],[0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [lagerlappy, _bestellungen, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;

	_whitelist = ["Spielerverwaltung", "Player administration","\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa",{
		params ["_t","_p","_actionparams"];
		createDialog "whitelist_dialog";
	},{true}, {}, [], [0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [lagerlappy, _whitelist, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;

	_depot = ["Fahrzeugdepot", "Vehicle administration","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{
		params ["_t","_p","_actionparams"];
		createDialog "fuhrpark_dialog";
	},{true}, {}, [], [0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [laptop, _depot, 0, []]] call CBA_fnc_globalEventJIP;
/*
	_statistik = ["Statistik", "Besucherzahlen","\A3\ui_f\data\igui\cfg\simpleTasks\types\walk_ca.paa",{
		params ["_t","_p","_actionparams"];
		[] call zumi_fnc_show_statistic;
	},{true}, {}, [], [0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [lagerlappy, _statistik, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;
*/
/* MISC */

	//TOWING
	_insertChildren = {
		params ["_target", "_player", "_params"];
		_params params ["_id"];
		// Add children to this action
		private _actions = [];
		{
				private _childStatement = {
					params ["_target", "_player", "_params"];
					_params params ["_towed"];
					if (([configFile >> "cfgVehicles" >> (typeOf _target)  >> "Enginepower", "SCALAR", 50] call CBA_fnc_getConfigEntry) < ([configFile >> "cfgVehicles" >> (typeOf _towed)  >> "Enginepower", "SCALAR", 49] call CBA_fnc_getConfigEntry))  exitWith {
						["Failed! The towing vehicle must have a stronger engine than the towed...", "\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
					};
					if ("ACE_rope12" IN (itemCargo _target)) then {
						["zumi_tow", [_target, _towed, _target getVariable ["towingcable", objNull], true], _target] call cba_fnc_targetEvent;
						["zumi_hinweis", [format ["The %1 is now attached to the %2", [configFile >> "cfgVehicles" >> (typeOf _towed)  >> "displayName", "String", "towing Tractor"] call CBA_fnc_getConfigEntry, [configFile >> "cfgVehicles" >> (typeOf _target)  >> "displayName", "String", "towed vehicle"] call CBA_fnc_getConfigEntry], false, 8, 1], _player] call CBA_fnc_targetEvent;
					} else {
						["Failed! The towing vehicle must have a 12m rope in its inventory...", [configFile >> "cfgWeapons" >> "ACE_rope12"  >> "Picture", "String", ""] call CBA_fnc_getConfigEntry, [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
					};
				};
				private _action = [format ["%1", [configFile >> "cfgVehicles" >> (typeOf _x)  >> "displayName", "String", "Vehicle"] call CBA_fnc_getConfigEntry], _x, "", _childStatement, {true}, {}, [_x],"",4,[false, false, false, false, false], {
					params ["_target", "_player", "_params", "_actionData"];
					_params params ["_towed"];
					// Modify the action - index 1 is the display name, 2 is the icon...
					_actionData set [1, format ["%1", [configFile >> "cfgVehicles" >> (typeOf _towed)  >> "displayName", "String", "Vehicle"] call CBA_fnc_getConfigEntry]];
				}
			] call zumi_fnc_interaction_create;
				_actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
		} forEach ((
			nearestObjects [_target, ["car"], 12, false]) select {
				(!(_X == _target) &&
				(isNull (_x getVariable ["towingcable", objNull]) &&
				([position _target, ((direction _x)) - 180, 30, position _x] call BIS_fnc_inAngleSector)) &&
				(locked _x < 1))
			}
		);
		_actions
	};
	private _aktion = ["Hook","Hook",["\z\ace\addons\fastroping\UI\Icon_Module_FRIES_ca.paa",""],{
		params ["_t","_p","_actionparams"];
	},{(alive _target) && (isNull (_target getVariable ["towingcable", objNull])) && (locked _target < 1)}, _insertChildren, []] call zumi_fnc_interaction_create;
	["zumi_interaction_add_to_class", ["Car", _aktion, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;
	["zumi_interaction_add_to_class", ["Tank", _aktion, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

	_insertChildren = {
		params ["_target", "_player", "_params"];
		_params params ["_id"];
		// Add children to this action
		private _actions = [];
		{
				private _childStatement = {
					params ["_target", "_player", "_params"];
					_params params ["_towed"];
					["zumi_tow", [_target, _towed, _target getVariable ["towingcable", objNull], false], _target] call cba_fnc_targetEvent;
				};
				private _action = [format ["%1", [configFile >> "cfgVehicles" >> (typeOf _x)  >> "displayName", "String", "Vehicle"] call CBA_fnc_getConfigEntry], _x, "", _childStatement, {true}, {}, [_x],"",4,[false, false, false, false, false], {
					params ["_target", "_player", "_params", "_actionData"];
					_params params ["_towed"];
					// Modify the action - index 1 is the display name, 2 is the icon...
					_actionData set [1, format ["%1", [configFile >> "cfgVehicles" >> (typeOf _towed)  >> "displayName", "String", "Vehicle"] call CBA_fnc_getConfigEntry]];
				}
			] call zumi_fnc_interaction_create;
				_actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
		} forEach (
			ropeAttachedObjects _target
		);
		_actions
	};
	private _aktion = ["Unhook","Unhook",["\z\ace\addons\fastroping\UI\Icon_Module_FRIES_ca.paa",""],{
		params ["_t","_p","_actionparams"];
	},{(alive _target) && (!isNull (_target getVariable ["towingcable", objNull]))  && (locked _target < 1)}, _insertChildren, []] call zumi_fnc_interaction_create;
	["zumi_interaction_add_to_class", ["Car", _aktion, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;
	["zumi_interaction_add_to_class", ["Tank", _aktion, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

	["LOP_CHR_Civ_Random", "FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		if (side _unit != civilian) exitWith {};
		if (_unit distance2d _firer <= 50 && !(_unit getVariable ["hat_angst", false])) then {
			_unit setVariable ["hat_angst", true];
			_unit playMove "Acts_CivilHiding_1";
		};
	}] call CBA_fnc_addClassEventHandler;

	["LOP_CHR_Civ_Random", "AnimDone", {
		params ["_unit", "_anim"];
		if (_anim == "Acts_CivilHiding_1") then {
			_unit setVariable ["hat_angst", false];
			_unit setVariable ["in_deckung", 0, true];
			_unit playAction "up";
		};
	}] call CBA_fnc_addClassEventHandler;


	//Lage wird beeinflusst durch Handlungen
	["zumi_sanktion", {
		params ["_wert", ["_id", -1]];
		[_wert, _id] call zumi_fnc_bonus_malus;

	}] call CBA_fnc_addEventHandler;

	_armory_stage_one = ["waka_stage_one","Grant armory authorisation","\A3\ui_f\data\igui\cfg\simpleTasks\types\armor_ca.paa",
	  {
	   params ["_t","_p","_actionparams"];
		 _t setVariable ["323_waka", 1, true];
	  },
	  {((_player getVariable ["323_logistiker", 0]) > 0) && ((_target getVariable ["323_waka", 0]) < 1)},
	  {},
	  []
	 ] call zumi_fnc_interaction_create;

	 ["zumi_interaction_add_to_class", ["B_Soldier_base_F", _armory_stage_one, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

	 _armory_forbid = ["waka_entzug","Revoke armory authorisation","\A3\ui_f\data\igui\cfg\simpleTasks\types\armor_ca.paa",
	 	{
	 	 params ["_t","_p","_actionparams"];
	  _t setVariable ["323_waka", 0, true];
	 	},
	 	{((_player getVariable ["323_logistiker", 0]) > 0) && ((_target getVariable ["323_waka", 0]) > 0)},
	 	{},
	 	[]
	  ] call zumi_fnc_interaction_create;

	  ["zumi_interaction_add_to_class", ["B_Soldier_base_F", _armory_forbid, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

	_sweep = ["sweep","Search house","\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa",{
		  params ["_t","_p","_actionparams"];
			_houses = nearestTerrainObjects [_p, ["House"], 10, true, true];
			if (_houses isEqualTo []) exitWith {
				["No searchable house closeby", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _p, 2] call ace_common_fnc_displayTextPicture;
			};
			_house = _houses select 0;
			if (_house getVariable ["durchsucht", false]) exitWith {
				["This house has already been searched", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _p, 2] call ace_common_fnc_displayTextPicture;
			};
		  [_p, _house] call ace_common_fnc_claim;
			[
			  "Searching the building...",
			  floor linearConversion [2,20, sizeOf (typeOf _house), 10,20, true],
			  {
			    params ["_args","_success", "_time_elapsed", "_time_total"];
			    _args params ["_house", "_p"];
			    !(_house getVariable ["durchsucht", false]) && ([_p] call ace_common_fnc_isInBuilding)
			  },
			  {
			    params ["_args","_success", "_time_elapsed", "_time_total"];
			    _args params ["_house", "_p"];
					_intel = (_house getVariable ["intel", []]);
					_hiddenweapons = (_house getVariable ["hiddenweapons", []]);
					if !(_intel isEqualTo []) then {
			    	["zumi_intel_create", [_p modelToWorldVisual [0,0.5, 0.1], _intel, _hiddenweapons]] call CBA_fnc_serverEvent;
			    	["You have found something!", "\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa", [1, 1, 1], _p, 2] call ace_common_fnc_displayTextPicture;
						//House has no longer hidden items
						_house setVariable ["intel", [], true];
						_house setVariable ["hiddenweapons", [], true];
					};
			    [objNull, _house] call ace_common_fnc_claim;
			    _house setVariable ["durchsucht", true, true];
			  },
			  {
			    params ["_args","_success", "_time_elapsed", "_time_total"];
			    _args params ["_house", "_p"];
			    [objNull, _house] call ace_common_fnc_claim;
			  },
			  [_house, _p],
			  false,
			  false
			] call CBA_fnc_progressBar;

		  },
		  {([_player] call ace_common_fnc_isInBuilding) && ((vehicle _player) == _player)},
		  {},
		  []
		] call zumi_fnc_interaction_create;

		["zumi_interaction_add_to_class", ["CAManBase", _sweep, 1, ["ACE_SelfActions"], true]] call CBA_fnc_globalEventJIP;

		_lockpick = ["Lockpick","Pick the Lock","\z\ace\addons\vehiclelock\ui\lockpick.paa",
   {
     params ["_t","_p","_actionparams"];
    private _getdoor = ([2] call ace_interaction_fnc_getDoor);
    _getdoor params [["_house", objNull], ["_door", ""]];
    if (_door == "") exitWith {};
    [_p, _house] call ace_common_fnc_claim;
    //[_p, "Acts_carFixingWheel", 1] call ace_common_fnc_doAnimation;
    [
     "Picking the lock...",
     5,
     {
      params ["_args","_success", "_time_elapsed", "_time_total"];
      _args params ["_house", "_p", "_door"];
      ((([_p, "ACE_key_lockpick"] call ace_common_fnc_hasItem)) && ((_house getVariable [format ["bis_disabled_%1", _door], 0]) > 0))
     },
     {
      params ["_args","_success", "_time_elapsed", "_time_total"];
      _args params ["_house", "_p", "_door"];
      [objNull, _house] call ace_common_fnc_claim;
      _house setVariable [format ["bis_disabled_%1", _door], 0, true];
      [_house, "unlock", 25] call CBA_fnc_globalSay3d;
			["Door unlocked", "\A3\Ui_f\data\IGUI\Cfg\Actions\open_door_ca.paa", [0, 0.8, 0], _p, 2] call ace_common_fnc_displayTextPicture;
     },
     {
      params ["_args","_success", "_time_elapsed", "_time_total"];
      _args params ["_house", "_p", "_door"];
      [objNull, _house] call ace_common_fnc_claim;
      [_p, "", 2] call ace_common_fnc_doAnimation;
     },
     [_house, _p, _door],
     false,
     false
    ] call CBA_fnc_progressBar;
   },
   {(([_player, "ACE_key_lockpick"] call ace_common_fnc_hasItem) && ((([4] call ace_interaction_fnc_getDoor) select 1) != ""))},
    {},
   []
  ] call zumi_fnc_interaction_create;

  ["zumi_interaction_add_to_class", ["CAManBase", _lockpick, 1, ["ACE_SelfActions","ACE_Equipment"], true]] call CBA_fnc_globalEventJIP;

 _c4 = ["c4","Plant a C4 on the door","\A3\Weapons_F\Data\UI\gear_mine_AP_miniclaymore_CA.paa",
{
	params ["_t","_p","_actionparams"];
 private _getdoor = ([2] call ace_interaction_fnc_getDoor);
 _getdoor params [["_house", objNull], ["_door", ""]];
 if (_door == "") exitWith {};
 [_p, _house] call ace_common_fnc_claim;
 [_p, "Acts_carFixingWheel", 1] call ace_common_fnc_doAnimation;
 private _position0 = positionCameraToWorld [0, 0, 0];
 private _position1 = positionCameraToWorld [0, 0, 3];
 private _intersections = lineIntersectsSurfaces [AGLToASL _position0, AGLToASL _position1, cameraOn, objNull, true, 1, "GEOM"];
 //According to Ace - Shithouse is bugged
 if (typeOf _house == "") exitWith {};
 _intersections = [_house, "GEOM"] intersect [_position0, _position1];
 if (_intersections isEqualTo []) exitWith {};
 _ding = _intersections select 0;
 _ding params ["_selection", "_distance"];
 _offset = positionCameraToWorld [0, 0, _distance];
 [
	"Attaching the C4...",
	14,
	{
	 params ["_args","_success", "_time_elapsed", "_time_total"];
	 _args params ["_house", "_p", "_door", "_offset"];
	 ((([_p, "ClaymoreDirectionalMine_Remote_Mag"] call ace_common_fnc_hasMagazine)) && ((_house getVariable [format ["bis_disabled_%1", _door], 0]) > 0) && ((_house getVariable ["ace_common_owner", objNull]) == _player) && !(_door IN (_house getVariable ["doors_rigged", []])))
	},
	{
	 params ["_args","_success", "_time_elapsed", "_time_total"];
	 _args params ["_house", "_p", "_door", "_offset"];
	 private _explosive = createVehicle ["ACE_Explosives_Place_Claymore", [0,0,0], [], 0, "CAN_COLLIDE"];
	 _explosive setPosATL _offset;
	 _explosive setVariable ["ace_explosives_class", "ClaymoreDirectionalMine_Remote_Mag", true];
	 _p removeMagazine "ClaymoreDirectionalMine_Remote_Mag";
	 ["ace_explosives_place", [_explosive, (getDir _p) - 180, 0, _p]] call CBA_fnc_globalEvent;
   _explosive setVariable ["ace_explosives_Direction", getDir _p, true];
	 _explosive setVariable ["door", _door, true];
	 _explosive setVariable ["house", _house, true];
	 _explosive enableSimulation false;
	 private _rigged = _house getVariable ["doors_rigged", []];
	 _rigged pushBackUnique _door;
	 _house setVariable ["doors_rigged", _rigged, true];
	 [objNull, _house] call ace_common_fnc_claim;
	 _explosive addEventhandler ["Deleted",
		 {
		 	params ["_e"];
			private _h = _e getVariable ["house", objNull];
			private _d = _e getVariable ["door", ""];
			private _dr = _h getVariable ["doors_rigged", []];
			_dr deleteAt (_dr find _d);
			_h setVariable ["doors_rigged", _dr, true];
		 }
		];
	},
	{
	 params ["_args","_success", "_time_elapsed", "_time_total"];
	 _args params ["_house", "_p", "_door", "_offset"];
	 [objNull, _house] call ace_common_fnc_claim;
	 [_p, "", 2] call ace_common_fnc_doAnimation;
	},
	[_house, _p, _door, _offset],
	false,
	false
 ] call CBA_fnc_progressBar;
},
{(([_player, "ClaymoreDirectionalMine_Remote_Mag"] call ace_common_fnc_hasMagazine) && ((([2] call ace_interaction_fnc_getDoor) select 1) != ""))},
 {},
[]
] call zumi_fnc_interaction_create;

["zumi_interaction_add_to_class", ["CAManBase", _c4, 1, ["ACE_SelfActions","ACE_Equipment"], true]] call CBA_fnc_globalEventJIP;



	["ace_explosives_detonate", {
		params ["_unit", "_explosive", "_delay"];
		private _array = _explosive call CBA_fnc_getNearestBuilding;
		_array params ["_building", "_buildingPositions"];
		_bounding_rotated =  [(boundingCenter _building), vectorUp _building,  -(getDir _building)] call CBA_fnc_vectRotate3D;
  	_hpos = (_building call cba_fnc_getPos) vectorAdd _bounding_rotated;
		_bpos = (getPosATL _explosive);
		for "_i" from 1 to 20 do {
			private _offset = _building selectionPosition format ["door_%1", _i];
			if !(_offset isEqualTo [0,0,0]) then {
				private _offset = [_offset, vectorUp _building,  -(getDir _building)] call CBA_fnc_vectRotate3D;
				private _newpos = _hpos vectorAdd _offset;
				if (_bpos distance _newpos <= 2) then {
					_building setVariable [format ["bis_disabled_door_%1", _i], 0, true];
					private _return = [_building, format ["door_%1", _i]] call ace_interaction_fnc_getDoorAnimations;
					_return params [["_animations", []], ["_lockedVariable", []]];
					if !(_animations isEqualTo []) then {
						_building animate [_animations select 0, 1];
					};
				};
			};
		};
	}] call CBA_fnc_addEventHandler;


	_durchsuchen = ["Durchsuchen","Search dead Body","\A3\ui_f\data\igui\cfg\simpleTasks\types\search_ca.paa",{
		params ["_t","_p","_actionparams"];
	  [_p, _t] call ace_common_fnc_claim;
	  [_p, "Acts_TreatingWounded03", 1] call ace_common_fnc_doAnimation;
	  [
	    10,
	    [_p, _t],
	    {
	      params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
	      _args params ["_p", "_t"];
				_intel = (_t getVariable ["intel", []]);
				if !(_intel isEqualTo []) then {
					["zumi_intel_create", [_p modelToWorldVisual [0,0.5, 0.1], _intel]] call CBA_fnc_serverEvent;
					["Found suspicious item", "\A3\ui_f\data\igui\cfg\simpleTasks\types\intel_ca.paa", [1, 1, 1], _p, 2] call ace_common_fnc_displayTextPicture;
	      } else {
	        ["Nothing suspicious found", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _p, 2] call ace_common_fnc_displayTextPicture;
	      };
	      [objNull, _t] call ace_common_fnc_claim;
	      _t setVariable ["durchsucht", true, true];
	      [_p, "Acts_TreatingWounded_Out", 1] call ace_common_fnc_doAnimation;
	    },
	    {
				params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
	      _args params ["_p", "_t"];
	      [objNull, _t] call ace_common_fnc_claim;
				[_p, "Acts_TreatingWounded_Out", 1] call ace_common_fnc_doAnimation;
	    },
	    "Searching the dead body for clues...",
	    {
	      params ["_args", "_elapsedTime", "_totalTime", "_errorCode"];
	      _args params ["_p", "_t"];
	      [_p, _t] call ace_common_fnc_canInteractWith;
	    }
	  ] call ace_common_fnc_progressBar;
	  },
	  {!(alive _target) && ([_player, _target] call ace_common_fnc_canInteractWith) && !(_target getVariable ["durchsucht", false]) && !([_target] call ace_common_fnc_isPlayer)},
	  {},
	  [],
	  "Body",
	  1.5
	] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_class", ["CAManBase", _durchsuchen, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;


	_detain = ["Detain","Detain person","\z\ace\addons\vehiclelock\ui\key_menuIcon_ca.paa",
	  {
	   params ["_t","_p","_actionparams"];
		 _t setVariable ["detained", true, true];
		 [_t] call CBA_fnc_clearWaypoints;
	  },
	  {(side _target IN [civilian, east, resistance]) && !(_target getVariable ["detained", false]) && (_target inArea "Prison") && !(isPlayer _target)},
	  {},
	  []
	 ] call zumi_fnc_interaction_create;

	 ["zumi_interaction_add_to_class", ["B_Soldier_base_F", _detain, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

	 _detain = ["Question","Question person","\z\ace\addons\zeus\ui\Icon_Module_Zeus_Flashlight_ca.paa",
 	  {
 	   params ["_t","_p","_actionparams"];
 		 _t setVariable ["questionned", true, true];

 	  },
 	  {(side _target IN [civilian, east, resistance]) && !(_target getVariable ["questionned", false]) && (_target inArea "Prison") && !(isPlayer _target)},
 	  {},
 	  []
 	 ] call zumi_fnc_interaction_create;

 	 ["zumi_interaction_add_to_class", ["B_Soldier_base_F", _detain, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

	 _release = ["Release","Release detainee","\A3\ui_f\data\igui\cfg\simpleTasks\types\run_ca.paa",
	  {
	 		params ["_t","_p","_actionparams"];
	 		deleteVehicle _t;
	  },
	  {(side _target IN [civilian, east, resistance]) && (_target getVariable ["detained", false]) && (_target inArea "Prison") && !(isPlayer _target)},
	  {},
	  []
	 ] call zumi_fnc_interaction_create;

	 ["zumi_interaction_add_to_class", ["B_Soldier_base_F", _detain, 0, ["ACE_MainActions"], true]] call CBA_fnc_globalEventJIP;

};



//Server, Clients und HLCs
/*

	JIP Kompatible Events für das Missionsframework

*/


/*

Acre Jammer


*/


[
	{
		params ["_unit","_object", "_cost"];
			//Nur ausgewiesene Pioniere dürfen bauen
		if ((_unit getVariable ["ACE_IsEngineer", 0]) < 2) exitWith {
			"You are not allowed..." remoteExecCall ["hint", _unit];
			false;
		};
		if (count fortify_objekte_temp >= 100) exitWith {
			"Mind the Performance, there has already a 100 objects been put down!" remoteExecCall ["hint", _unit];
			false;
		};
		if (((typeOf _object) IN ["ACE_Wheel", "ACE_Track"]) && (_unit distance2d (getMarkerPos "Inst") > 50)) exitWith {
			"You have to be within 50m of the repair area in order to spawn that!" remoteExecCall ["hint", _unit];
			false;
		};
		true;
	}
] call acex_fortify_fnc_addDeployHandler;
/*

	Handhabe Fesselung

*/

["ace_captives_setHandcuffed", {
	params ["_unit", "_bool"];
	if ([_unit] call ace_common_fnc_isPlayer) exitWith {};
	if !(local _unit) exitWith {};
	_id = _unit getVariable ["id", -1];
	_renitenz = _unit getVariable ["renitenz", 0];
	_sanktion = linearConversion [0, 3, _renitenz, 1, 3, true];
	//Fall 1: Person wird gefesselt
	if (_bool) then {
		switch (side _unit) do {
			case civilian : {
				//Es schädigt den Ruf im Dorf bzw. auf der Karte im Verhältnis zur Renitenz der festgesetzten Person
				["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
				//Es erhöht die Renitenz
				_renitenz = (_renitenz + 1) min 3;
				_unit setVariable ["renitenz", _renitenz, true];
			};
			case east : {
				//Todo
			};
			case blufor : {
				["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
			};
			case resistance : {
				["zumi_sanktion", [-2 * _sanktion, _id]] call CBA_fnc_serverEvent;
			};
			default {};
		};
	//Fall 2: Person wird freigelassen
	} else {
		switch (side _unit) do {
			case civilian : {
				//Ist die Person sehr renitent, kann sie Feindhandlungen vornehmen TODO

				//Freilassen gibt minimes Plus
				["zumi_sanktion", [0.25 * _sanktion, _id]] call CBA_fnc_serverEvent;


			};
			case east : {
				//Ist die Person sehr renitent, kann sie Feindhandlungen vornehmen TODO
			};
			case blufor : {

			};
			case resistance : {

			};
			default {};
		};
	};
}] call CBA_fnc_addEventHandler;

	/*

		Intel

	*/

	//Frage nach Aufständischen
	["zumi_befrage_informant", {
	  params ["_unit", "_player", "_id", "_frage"];
		if !(local _unit) exitWith {};
		[_unit, _player, _id, _frage] call zumi_fnc_informant;
	}] call CBA_fnc_addEventHandler;

	/*

		Humanitär

	*/

	//Humanitäres Item gegeben
	["zumi_item_erhalten", {
	  params ["_unit", "_player", "_id", "_item"];
		if !(local _unit) exitWith {};
		[_unit, _player, _id, _item] call zumi_fnc_gebe_item;
	}] call CBA_fnc_addEventHandler;

	/*

		Anweisungen

	*/

	//Weise Zivilist an
	["zumi_anweisen", {
		params ["_unit", "_player", "_id", "_anweisung"];
		[_unit, _player, _id, _anweisung] call zumi_fnc_anweisen;
	}] call CBA_fnc_addEventHandler;

	["zumi_anim", {
		params ["_player", "_unit", "_fnc"];
		switch _fnc do {
			case 0 : {
				[_player, _unit] call zumi_fnc_handsup;
			};
			case 1 : {
				[_player, _unit] call zumi_fnc_freeze;
			};
			case 2 : {
				[_player, _unit] call zumi_fnc_moveon;
			};
		};
	}] call CBA_fnc_addEventHandler;

	/*

		Kontrolle

	*/

	//Weise Zivilist an
	["zumi_kontrollhandlung", {
		params ["_unit", "_player", "_id", "_kontrollhandlung"];
		if !(local _unit) exitWith {};
		[_unit, _player, _id, _kontrollhandlung] call zumi_fnc_kontrollieren;
	}] call CBA_fnc_addEventHandler;


	//Civilians do not like when they are being searched like this
	["ace_disarming_dropItems",{
		params ["_p", "_t", "_item"];
		if (!(local _t) || ([_t] call ace_common_fnc_isPlayer)) exitWith {};
		private _renitenz = _t getVariable ["renitenz", 0];
		_t setVariable ["renitenz", (_renitenz + 1) min 3, true];
	}] call CBA_fnc_addEventHandler;

	["ace_killed", {
	    params ["_unit", "_causeOfDeath", "_killer", "_instigator"];
	    if (!local _unit) exitWith {};

	    private _killInfo = [];

	    if (!isNull _killer) then {
				if (!(_killer isKindof "CAManBase")) then { // If killer is a vehicle log the vehicle type
            _killInfo pushBack format ["Vehicle: %1", getText (configfile >> "CfgVehicles" >> (typeOf _killer) >> "displayName")];
        };
        if (isNull _instigator) then {
            _instigator = effectiveCommander _killer;
        };
	    };
	    private _unitIsPlayer = hasInterface && {_unit in [player, ace_player]}; // isPlayer check will fail at this point
	    private _killerIsPlayer = (!isNull _instigator) && {_unit != _instigator} && {[_instigator] call ace_common_fnc_isPlayer};
			// Goats are tracked!
			if ((_unit isKindOf "Goat_random_F") && (_killerIsPlayer)) exitWith {
			   ["zumi_sanktion", [-1, (_unit getVariable ["id", -1])]] call CBA_fnc_ServerEvent;
			 };
	    // Log firendly fire
	    private _fnc_getSideFromConfig = {
	        params ["_object"];
	        switch (getNumber (configFile >> "CfgVehicles" >> (typeOf _object) >> "side")) do {
	            case (0): {east};
	            case (1): {west};
	            case (2): {resistance};
	            default {civilian};
	        };
	    };
	    if ((!isNull _instigator) && {_unit != _instigator} && {_instigator isKindOf "CAManBase"}) then {
	        // Because of unconscious group switching/captives it's probably best to just use unit's config side
	        private _unitSide = [_unit] call _fnc_getSideFromConfig;
	        private _killerSide = [_instigator] call _fnc_getSideFromConfig;
	        if ([_unitSide, _killerSide] call BIS_fnc_areFriendly) then {
	            _killInfo pushBack format["<t color='#ff0000'>%1</t>", "FriendlyFire"];
	        };

	    };

	    // Rough cause of death from statemachine (e.g. "CardiacArrest:Timeout"), could parse this to be more human readable
	    _killInfo pushBack _causeOfDeath;

	    // Parse info into text
	    _killInfo = if (_killInfo isEqualTo []) then {
	        ""
	    } else {
	        format [" - [%1]", (_killInfo joinString ", ")];
	    };

	    // If unit was player then send event to self
	    if (_unitIsPlayer) then {
	        private _killerName = "Self?";
	        if ((!isNull _killer) && {_unit != _killer}) then {
	            if (_killerIsPlayer) then {
	                _killerName = [_killer, true, false] call ace_common_fnc_getName;
	            } else {
	                _killerName = _killer getVariable ["acex_killtracker_aiName", ""]; // allow setting a custom AI name (e.g. VIP Target)
	                if (_killerName == "") then {
	                    _killerName = format ["*AI* - %1", getText (configfile >> "CfgVehicles" >> (typeOf _killer) >> "displayName")];
	                };
	            };
	        };
	        ["acex_killtracker_death", [_killerName, _killInfo]] call CBA_fnc_localEvent;
	    };

	    // If killer was player then send event to killer
	    if (_killerIsPlayer) then {
					["zumi_ai_loss", [_unit, ([_unit] call _fnc_getSideFromConfig)]] call CBA_fnc_serverEvent;
	        private _unitName = "";
	        if (_unitIsPlayer) then {
	            _unitName = [_unit, true, false] call ace_common_fnc_getName; // should be same as profileName
							["acex_killtracker_kill", [_unitName, _killInfo], _killer] call CBA_fnc_targetEvent;
					};
	    };
	}] call CBA_fnc_addEventHandler;


/*

	//Towing

	//For planes later use
	Land_TowBar_01_F
	//["zumi_tow", [v1, _tower, v1 getVariable ["towingcable", objNull], true], v1] call cba_fnc_targetEvent;
*/

["Car", "Killed",
	{
		params ["_vehicle"];
		if (!local _vehicle) exitWith {};
		private _rope = _vehicle getVariable ["towingcable", objNull];
		if (!isNull _rope) then {
			ropeDestroy _rope;
			_tower setVariable ["towingcable", objNull, true];
			{
  			detach _x;
				_x setVariable ["towingcable", objNull, true];
			} forEach attachedObjects _vehicle;
		};
	}
] call CBA_fnc_addClassEventHandler;


["Tank", "Killed",
	{
		params ["_vehicle"];
		if (!local _vehicle) exitWith {};
		private _rope = _vehicle getVariable ["towingcable", objNull];
		if (!isNull _rope) then {
			ropeDestroy _rope;
			_tower setVariable ["towingcable", objNull, true];
			{
  			detach _x;
				_x setVariable ["towingcable", objNull, true];
			} forEach attachedObjects _vehicle;
		};
	}
] call CBA_fnc_addClassEventHandler;


["zumi_tow", {
	params [["_tower", objNull], ["_towed", objNull], ["_towingcable", objNull], ["_hook", false], ["_caller", ace_player]];
	if (!local _tower) exitWith {};
	if (_hook) then {
		 //Hook up, attach cable
	  _bbr = boundingBoxReal _tower;
		_p1 = _bbr select 0;
		_p2 = _bbr select 1;
		_p3 = boundingcenter _tower;
		_maxWidth = abs ((_p2 select 0) - (_p1 select 0));
		_maxLength = abs ((_p2 select 1) - (_p1 select 1));
		_maxHeight = abs ((_p2 select 2) - (_p1 select 2));
		_towed attachTo [_tower, [0, - _maxLength/1.25, (((boundingcenter _towed) vectorDiff (getPosATL _towed)) select 2) - ((_maxHeight/2) max (((boundingBoxReal _towed) select 1) select 1)/2)], ""];
		_rope = ropeCreate [_tower, [0,-_maxLength/2.5,-(((boundingcenter _tower) vectorDiff (getPosATL _tower)) select 2)], _towed, [0,_maxLength/5,-(((boundingcenter _towed) vectorDiff (getPosATL _towed)) select 2) + _maxHeight/4], (_towed distance2d _tower), [], ["RopeEnd", [0,-1,-1]]];
		ropeUnwind [_rope, 1, -1, true];
		_tower setVariable ["towingcable", _rope, true];
		_towed setVariable ["towingcable", _rope, true];
		[_tower, "ACE_rope12"] call CBA_fnc_removeItemCargo;
		_towed attachTo [_tower, [0, 0.25 -((_towed distance2d _tower) + _maxLength/2), 0.05], ""];
	} else {
	 //Unhook, delete the rope and give it to the caller as item / drop it by his feet
	 private _rope = _tower getVariable ["towingcable", objNull];
	 if (!isNull _rope) then {
		ropeDestroy _rope;
		_tower setVariable ["towingcable", objNull, true];
		_towed setVariable ["towingcable", objNull, true];
		[_tower, "ACE_rope12", 1, true] call CBA_fnc_addItemCargo;
		detach _towed;
		private _pos = getPosATL _towed;
		_towed setPosATL [_pos select 0, _pos select 1, 0];
		_towed setVectorUp (SurfaceNormal (position _towed));
	 } else {
		_tower setVariable ["towingcable", objNull, true];
		_towed setVariable ["towingcable", objNull, true];
		detach _towed;
		private _pos = getPosATL _towed;
		_towed setPosATL [_pos select 0, _pos select 1, 0];
		_towed setVectorUp (SurfaceNormal (position _towed));
	 };
	};
}] call CBA_fnc_addEventHandler;
