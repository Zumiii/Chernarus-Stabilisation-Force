/*
[zumi_fnc_customSignalFnc] call acre_api_fnc_setCustomSignalFunc;

["remoteStopSpeaking",
	{
    _this call zumi_fnc_remoteStopSpeaking;
    _this call acre_sys_core_fnc_remoteStopSpeaking;
	}
] call acre_sys_rpc_fnc_addProcedure;
*/
if (hasInterface) then {


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
/*
	["ace_arsenal_cargoChanged", {
    params ["_display","_item", "_addOrRemove", "_shiftState"];

		switch ace_arsenal_currentLeftPanel do {
	    case 2010 : {
        if (_addOrRemove < 0) then {
            for "_count" from 1 to ([1, 5] select _shiftState) do {
                ace_arsenal_center addItemToUniform _item;
            };
          } else {
            for "_count" from 1 to ([1, 5] select _shiftState) do {
                ace_arsenal_center removeItemFromUniform _item;
            };
          };
	        _load = loadUniform ace_arsenal_center;
	        _maxLoad = gettext (configfile >> "CfgWeapons" >> uniform ace_arsenal_center >> "ItemInfo" >> "containerClass");
	        _items = uniformItems ace_arsenal_center;
	        ace_arsenal_currentItems set [15 ,_items];
		    };
	    case 2012 : {
        if (_addOrRemove < 0) then {
          for "_count" from 1 to ([1, 5] select _shiftState) do {
              ace_arsenal_center addItemToVest _item;
          };
        } else {
          for "_count" from 1 to ([1, 5] select _shiftState) do {
            ace_arsenal_center removeItemFromVest _item;
          };
        };
        _load = loadVest ace_arsenal_center;
        _maxLoad = gettext (configfile >> "CfgWeapons" >> vest ace_arsenal_center >> "ItemInfo" >> "containerClass");
        _items = vestItems ace_arsenal_center;
        ace_arsenal_currentItems set [16,_items];
	    };

	    case 2014 : {
	    	if (_addOrRemove < 0) then {
        for "_count" from 1 to ([1, 5] select _shiftState) do {
          ace_arsenal_center addItemToBackpack _item;
         };
	      } else {
         for "_count" from 1 to ([1, 5] select _shiftState) do {
           ace_arsenal_center removeItemFromBackpack _item;
         };
	      };
	      _load = loadBackpack ace_arsenal_center;
	      _maxLoad = backpack ace_arsenal_center;
	      _items = backpackItems ace_arsenal_center;
	      ace_arsenal_currentItems set [17,_items];
	    };
		};

		// Update progress bar status, weight info
		private _loadIndicatorBarCtrl = _display displayCtrl 701;
		_loadIndicatorBarCtrl progressSetPosition _load;

		private _value = {_x == _item} count _items;
		_ctrlList lnbSetText [[_lnbCurSel, 2],str _value];

		[_ctrlList, _maxLoad] call ace_arsenal_fnc_updateRightPanel;

		hint "You are not allowed to pull ammo out of the arsenal";

  }] call CBA_fnc_addEventHandler;
*/
/*
	["zumi_jammer", {
	  params [["_jammer", nil], ["_an", false]];
    if (_an) exitWith {
      zumi_jammers pushBackUnique _jammer;
    };
    _index = zumi_jammers find _jammer;
    if (_index >= 0) then {
      zumi_jammers deleteAt _index;
    };
	}] call CBA_fnc_addEventHandler;
*/
//acre_remoteStartedSpeaking
//acre_startedSpeaking
/*
	["acre_startedSpeaking", {
		params [["_player", acre_player], ["_onRadio", false], ["_radioID", ""]];
		if (!_onRadio) exitWith {};
		zumi_jammers = zumi_jammers select {(_x getvariable ["zumi_jamming", false])};
		if ((count zumi_jammers) < 1) then {
			if !(isNull (_player getVariable ["zumi_currentJammer", objNull])) then {
				_player setVariable ["zumi_currentJammer", objNull];
			};
		} else {
			private _closestJammer = [zumi_jammers, {-(_player distance2d _x)}, objNull] call CBA_fnc_selectBest;
			private _currentJammer = _player getVariable ["zumi_currentJammer", objNull];
			if (_currentJammer != _closestJammer) then {
				_player setVariable ["zumi_currentJammer", _closestJammer];
			};
		};
	}] call CBA_fnc_addEventHandler;

	["acre_stoppedSpeaking", {
		params [["_player", acre_player], ["_onRadio", false]];
		if (!_onRadio) exitWith {};

	}] call CBA_fnc_addEventHandler;
*/
	["ace_explosives_defuse", {
    params ["_ied","_pio"];
    [_ied, _pio] remoteExecCall ["zumi_fnc_handle_ied_defused", 2];
  }] call CBA_fnc_addEventHandler;

	["ace_common_playActionNow", {
	  params ["_player","_anim"];
		_ct = cursortarget;
		if (isNull _ct || ([_ct] call ace_common_fnc_isPlayer)) exitWith {};
		if ((_ct isKindoF "CAManBase" || _ct isKindoF "LandVehicle") && (_ct distance2d _player <= 20) && (alive _ct) && (!isNull driver _ct) && !(driver _ct getVariable ["ace_captives_isHandcuffed", false]) && (_player call CBA_fnc_canUseWeapon) && ((side _ct) IN [civilian, west])) then {
		  switch _anim do {
		    case "ace_gestures_Hold" : {
					["zumi_anim", [_player, _ct, 0], _ct] call CBA_fnc_targetEvent;
		    };
		    case "ace_gestures_HoldStandLowered" : {
					["zumi_anim", [_player, _ct, 1], _ct] call CBA_fnc_targetEvent;
		    };
		    case "ace_gestures_ForwardStandLowered" ;
		    case "ace_gestures_Forward" : {
					["zumi_anim", [_player, _ct, 2], _ct] call CBA_fnc_targetEvent;
		    };
				case "gestureAdvance" : {
     			private _getdoor = ([2] call ace_interaction_fnc_getDoor);
     			_getdoor params [["_house", objNull],["_door", ""]];
     			if (_door != "") then {
      				[_house, "knock", 25] call CBA_fnc_globalSay3d;
      				_array = [_house, _door] call ace_interaction_fnc_getDoorAnimations;
      				_array params [["_animations", []], ["_lockedVariable", []]];
     			};
     		};
				default {};
			};
		 };
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



};

if (isServer) then {

	private _inidbi = ["new", "us"] call OO_INIDBI;
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
		if (_p inArea "Safezone") exitWith {};
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
        name _p,
        (_p getVariable ["BIS_fnc_setUnitInsignia_class", ""]),
				(_p getVariable ["vehicle", [-1, ""]])
      ]
    ]] call _inidbi;
}];

/*Jammer */
/*
	[
	    "rhsusf_M1117_D",
	    "engine",
	    {
	        params ["_vehicle", "_state"];
					if (_state) exitWith {};
					if !(_vehicle getVariable ["zumi_jamming", false]) exitWith {};
					_jip_str = ["zumi_jammer", [_vehicle, false]] call CBA_fnc_globalEventJIP;
					[_jip_str, _vehicle] call CBA_fnc_removeGlobalEventJIP;
					playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", _vehicle, false, getPosASL _vehicle, 5, 0.5, 25];
	    }
	] call CBA_fnc_addClassEventHandler;

	_jammer_an = ["Jammer_An", "Activate Jammer",["\idi\acre\addons\sys_oe303\data\ui\icon_antenna_ca.paa","#41FA01"],{
	params ["_t","_p","_actionparams"];
	["Jammer is running...", "\idi\acre\addons\sys_oe303\data\ui\icon_antenna_ca.paa", [0, 1, 0.5], ACE_player, 2] call ace_common_fnc_displayTextPicture;
	(vehicle _t) setVariable ["zumi_jamming", true, true];
	playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", (vehicle _t), false, getPosASL (vehicle _t), 5, 15, 25];
	_jip_str = ["zumi_jammer", [(vehicle _t), true]] call CBA_fnc_globalEventJIP;
	[_jip_str, (vehicle _t)] call CBA_fnc_removeGlobalEventJIP;

	},{(([_player] call cba_fnc_vehicleRole) == "driver") && !(_target getVariable ["zumi_jamming", false]) && (isEngineOn _target)}, {}, [], [0,0,0], 2] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_class", ["rhsusf_M1117_D", _jammer_an, 1, ["ACE_SelfActions"], true]] call CBA_fnc_globalEventJIP;

	_jammer_aus = ["Jammer_Aus", "Deactivate Jammer",["\idi\acre\addons\sys_oe303\data\ui\icon_antenna_ca.paa","#FF2D00"],{
	params ["_t","_p","_actionparams"];
	["Jammer stopped...", "\idi\acre\addons\sys_oe303\data\ui\icon_antenna_ca.paa", [1, 0, 0], ACE_player, 2] call ace_common_fnc_displayTextPicture;
	playSound3D ["A3\Missions_F_Bootcamp\data\sounds\vr_shutdown.wss", (vehicle _t), false, getPosASL (vehicle _t), 5, 0.5, 25];
	(vehicle _t) setVariable ["zumi_jamming", false, true];
	_jip_str = ["zumi_jammer", [(vehicle _t), false]] call CBA_fnc_globalEventJIP;
	[_jip_str, (vehicle _t)] call CBA_fnc_removeGlobalEventJIP;

	},{(([_player] call cba_fnc_vehicleRole) == "driver") && (_target getVariable ["zumi_jamming", false]) && (isEngineOn _target)}, {}, [], [0,0,0], 2] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_class", ["rhsusf_M1117_D", _jammer_aus, 1, ["ACE_SelfActions"], true]] call CBA_fnc_globalEventJIP;
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
			/*
			_can_build = [_unit call cba_fnc_getPos, typeOf _object] call zumi_fnc_can_build;
			if !(_can_build) then {
				_message = [];
		    _message pushBack [format ["Fehlendes Material zum Bau von %1:", getText (configfile >> "CfgVehicles" >> (typeOf _object) >> "displayName")], 1, [1,0.5,0,1]];
				_objectsRequired = ((befestigungsobjekte select {(_x select 0) isEquaLTo (typeOf _object)}) select 0) select 2;
		    for "_i" from 0 to (count _objectsRequired) - 1 do {
		      (_objectsRequired select _i) params ["_obj_class", "_count"];
		      _message pushBack [format ["%2 x %1:", _count, getText (configfile >> "CfgVehicles" >> _obj_class >> "displayName")], 1, [1,1,1,1]];
					_message pushBack [getText (configfile >> "CfgVehicles" >> _obj_class >> "editorPreview"), 1.5, [1,1,1,1]];
		    };
				["zumi_cba_hinweis", [_message], _unit] call CBA_fnc_targetEvent;
			} else {
				[_unit call cba_fnc_getPos, typeOf _object] call zumi_fnc_was_built;
			};

			_can_build;
			*/
			true;
		}
	] call acex_fortify_fnc_addDeployHandler;

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

	["zeus", {
	    ["commy_registerCurator", player] call CBA_fnc_serverEvent;
	}, "adminLogged"] call CBA_fnc_registerChatCommand;


	/*

		Das schwarze Brett

	*/


	_waka = ["Waka", "Access the Armory",["\A3\ui_f\data\igui\cfg\simpleTasks\types\armor_ca.paa", "#003311"],{
		params ["_t","_p","_actionparams"];
		createDialog "waka_dialog";
	},{true}, {}, [], [0,0,0], 5] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [waka, _waka, 0, []]] call CBA_fnc_globalEventJIP;

	_arsenal = ["Arsenal", "Ace Arsenal",[""],{
		params ["_t","_p","_actionparams"];
		[_p, _p, true] call ace_arsenal_fnc_openBox;
	},{true}, {}, [], [0,0,0], 0] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [waka, _arsenal, 0, ["Waka"]]] call CBA_fnc_globalEventJIP;


	//Fullheal

	_fullheal = ["Fullheal", "Cure self",["\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa", "#FF69B4"],{
		params ["_t","_p","_actionparams"];
		[_p] call ace_medical_treatment_fnc_fullHealLocal;
	},{true}, {}, [], [0,0,0], 3] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [mash, _fullheal, 0, []]] call CBA_fnc_globalEventJIP;


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
	},{((player getVariable ["323_logistiker", 0]) > 0)},{},[],[0,0,0.5], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [laptop, _lagerverwaltung, 0, []]] call CBA_fnc_globalEventJIP;

	_bestellungen = ["Bestellungsuebersicht","Delivery overview","\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa",{
	  params ["_t","_p","_actionparams"];
	  createDialog "lagerverwaltung_dialog";
	},{true},{},[],[0,0,0], 1] call zumi_fnc_interaction_create;
	["zumi_interaction_add_to_object", [laptop, _bestellungen, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;

	_depot = ["Fahrzeugdepot", "Vehicle administration","\A3\ui_f\data\igui\cfg\simpleTasks\types\car_ca.paa",{
		params ["_t","_p","_actionparams"];
		createDialog "fuhrpark_dialog";
	},{true}, {}, [], [0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [laptop, _depot, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;

	_whitelist = ["Spielerverwaltung", "Player administration","\A3\ui_f\data\igui\cfg\simpleTasks\types\meet_ca.paa",{
		params ["_t","_p","_actionparams"];
		createDialog "whitelist_dialog";
	},{true}, {}, [], [0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [laptop, _whitelist, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;

/*
	_statistik = ["Statistik", "Besucherzahlen","\A3\ui_f\data\igui\cfg\simpleTasks\types\walk_ca.paa",{
		params ["_t","_p","_actionparams"];
		[] call zumi_fnc_show_statistic;
	},{true}, {}, [], [0,0,0], 1] call zumi_fnc_interaction_create;

	["zumi_interaction_add_to_object", [laptop, _statistik, 0, ["Lagerverwaltung"]]] call CBA_fnc_globalEventJIP;
*/
/* MISC */



	["LOP_CHR_Civ_Random", "Killed", {
		params ["_unit", "_killer", "_instigator", "_useEffects"];
		if ((side _unit == civilian) && (isPlayer _killer)) then {
			["zumi_sanktion", [-1]] call CBA_fnc_localEvent;
		};
	}] call CBA_fnc_addClassEventHandler;

	["LOP_CHR_Civ_Random", "FiredNear", {
		params ["_unit", "_firer", "_distance", "_weapon", "_muzzle", "_mode", "_ammo", "_gunner"];
		if (side _unit != civilian) exitWith {};
		if (_unit distance2d _firer <= 25 && !(_unit getVariable ["hat_angst", false])) then {
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

	_armory_stage_one = ["waka_stage_one","Armory authorisation","\A3\ui_f\data\igui\cfg\simpleTasks\types\armor_ca.paa",
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
    [_p, "Acts_carFixingWheel", 1] call ace_common_fnc_doAnimation;
    [
     "Picking the lock...",
     25,
     {
      params ["_args","_success", "_time_elapsed", "_time_total"];
      _args params ["_house", "_p", "_door"];
      ((([_p, "ACE_key_lockpick"] call ace_common_fnc_hasItem)) && ((_house getVariable [format ["bis_disabled_%1", _door], 0]) > 0)  && (isNull (_house getVariable ["ace_common_owner", objNull])))
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
   {(([_player, "ACE_key_lockpick"] call ace_common_fnc_hasItem) && ((([2] call ace_interaction_fnc_getDoor) select 1) != ""))},
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

[{
		params ["_unit", "_range", "_explosive", "_fuzeTime", "_triggerItem"];
		if !(local _unit) exitWith {};
		zumi_jammers = zumi_jammers select {(_x getvariable ["zumi_jamming", false])};
		if ((count zumi_jammers) < 1) then {
			if !(isNull (_unit getVariable ["zumi_currentJammer", objNull])) then {
				_unit setVariable ["zumi_currentJammer", objNull];
			};
		} else {
			private _closestJammer = [zumi_jammers, {-(_unit distance2d _x)}, objNull] call CBA_fnc_selectBest;
			private _currentJammer = _unit getVariable ["zumi_currentJammer", objNull];
			if (_currentJammer != _closestJammer) then {
				_unit setVariable ["zumi_currentJammer", _closestJammer];
			};
		};
		private _currentJammer = _unit getVariable ["zumi_currentJammer", objNull];
		if (isNull _currentJammer) exitWith {
			true;
		};
		if (((_unit distance2d _explosive) <= 100) && (_triggerItem IN ["ACE_Cellphone", "ACE_M26_Clacker", "ACE_Clacker", "ACE_DeadManSwitch"])) exitWith {
			false;
		};
		true;
}] call ace_explosives_fnc_addDetonateHandler;


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
		if !(local _unit) exitWith {};
		[_unit, _player, _id, _anweisung] call zumi_fnc_anweisen;
	}] call CBA_fnc_addEventHandler;

	["zumi_anim", {
		params ["_player", "_unit", "_fnc"];
		if !(local _unit) exitWith {};
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

	//Nur Headless Client
	if (!hasInterface) then {

	};
