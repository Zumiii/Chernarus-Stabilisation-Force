/*

  Spieler führt eine Kontrolle an einem Zivilisten durch

*/

params ["_unit", "_player", "_id", "_kontrollhandlung"];

if !(local _unit) exitWith {};

if (_unit getVariable ["combattant", false]) exitWith {
  [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
};

switch _kontrollhandlung do {
  case "pass" : {
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    //Einheit wird nach ihren Papieren gefragt
    switch _renitenz do {
      case 0 : {
        //Fall 1 : Person hat keine Papiere dabei
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
        ["Person does not have papers", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
      };
      case 1 : {
        //Fall 2 : Person weist sich aus, ist gleichgültig
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "PutDown", 1] call ace_common_fnc_doGesture;
        [
          {
            params ["_p", "_u", "_id"];
            if (_p distance2d _u <= 2 && (alive _u)) then {
              private _txt = composeText [parseText format ["<t align='left'>Name: <t align='right' >%1</t>", name _u], lineBreak, parseText format ["<t align='left'>Home village: <t align='right' >%1</t>", (villages select _id) select 8]];
              ["zumi_hinweis", [_txt, false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
          },
          [_player, _unit, _id],
          2
        ] call cba_fnc_waitandexecute;
      };
      case 2 : {
        //Fall 3 : Person weist sich aus, ist aber wütend
        _sanktion = linearConversion [0, 3, _renitenz, 0.25, 1, true];
        //Es schädigt den Ruf im Dorf bzw. auf der Karte im Verhältnis zur Renitenz der festgesetzten Person
    		["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
        _renitenz = (_renitenz + 1) min 3;
        _unit setVariable ["renitenz", _renitenz, true];
        //["Person cooperates (angry)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "PutDown", 1] call ace_common_fnc_doGesture;
        [
          {
            params ["_p", "_u", "_id"];
            if (_p distance2d _u <= 2 && (alive _u)) then {
              private _txt = composeText [parseText format ["<t align='left'>Name: <t align='right' >%1</t>", name _u], lineBreak, parseText format ["<t align='left'>Home village: <t align='right' >%1</t>", (villages select _id) select 8]];
              ["zumi_hinweis", [_txt, false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
          },
          [_player, _unit, _id],
          2
        ] call cba_fnc_waitandexecute;
      };
      case 3 : {
        //Fall 4 : Person hat keine Papiere dabei, würde sie aber auch nicht zeigen
        _sanktion = linearConversion [0, 3, _renitenz, 0.5, 1, true];
        //Es schädigt den Ruf im Dorf bzw. auf der Karte im Verhältnis zur Renitenz der festgesetzten Person
    		["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
        //["Person is not cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
        if ((_unit getVariable ["combattant", true]) && ((random 1 > 0.5))) then {
          [_unit] call CBA_fnc_clearWaypoints;
          [_unit, _unit getVariable ["spawn_pos", getPosATL _unit], 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_rearm"] call CBA_fnc_addWaypoint;
        };
      };
    };
  };
  case "effekten" : {
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    switch _renitenz do {
      case 0 : {
        //Person zeigt mitgeführte Gegenstände, ist gleichgültig
        _allItems = [_unit, true] call CBA_fnc_uniqueUnitItems;
        //["Person cooperates", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "AinvPercMstpSnonWnonDnon", 1] call ace_common_fnc_doAnimation;
        {
          _display_text = [configFile >> "cfgWeapons" >> _x >> "displayname", "String", ""] call CBA_fnc_getConfigEntry;
          _display_pic = [configFile >> "cfgWeapons" >> _x  >> "picture", "String", ""] call CBA_fnc_getConfigEntry;
          if !(_display_text isEqualTo "") then {
            [
              {
                params ["_p", "_u", "_txt", "_pic"];
                if (_p distance2d _u <= 2 && ((animationState _u) isEqualTo "ainvpercmstpsnonwnondnon")) then {
                  [_txt, _pic, [1, 1, 1], _p, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _p];
                };
              },
              [_player, _unit , _display_text, _display_pic],
              3 + 3 * _forEachindex
            ] call cba_fnc_waitandexecute;
          };
        } forEach _allItems;
        [
          {
            params ["_t", "_anim"];
            [_t, _anim , 1] call ace_common_fnc_doAnimation;
          },
          [_unit, "AinvPercMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon"],
          (count _allItems) * 3
        ] call cba_fnc_waitandexecute;
      };
      case 1 : {
        //Person zeigt mitgeführte Gegenstände, ist aber wütend
        _sanktion = linearConversion [0, 3, _renitenz, 0.5, 1.5, true];
        ["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
        _renitenz = (_renitenz + 1) min 3;
        _unit setVariable ["renitenz", _renitenz, true];
        _allItems = [_unit, true] call CBA_fnc_uniqueUnitItems;
        //["Person cooperates (angry)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "AinvPercMstpSnonWnonDnon", 1] call ace_common_fnc_doAnimation;
        //Einbusse beim Ruf

        {
          _display_text = [configFile >> "cfgWeapons" >> _x >> "displayname", "String", ""] call CBA_fnc_getConfigEntry;
          _display_pic = [configFile >> "cfgWeapons" >> _x  >> "picture", "String", ""] call CBA_fnc_getConfigEntry;
          if !(_display_text isEqualTo "") then {
            [
              {
                params ["_p", "_u", "_txt", "_pic"];
                if (_p distance2d _u <= 2 && ((animationState _u) isEqualTo "ainvpercmstpsnonwnondnon")) then {
                  [_txt, _pic, [1, 1, 1], _p, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _p];
                };
              },
              [_player, _unit , _display_text, _display_pic],
              3 + 3 * _forEachindex
            ] call cba_fnc_waitandexecute;
          };
        } forEach _allItems;
        [
          {
            params ["_t", "_anim"];
            [_t, _anim , 1] call ace_common_fnc_doAnimation;
          },
          [_unit, "AinvPercMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon"],
          (count _allItems) * 3
        ] call cba_fnc_waitandexecute;
      };
      case 2 : {
        //Person zeigt nicht alle mitgeführten Gegenstände (Handy und Verbotenes wird verschwiegen)
        _allItems = ([_unit, true] call CBA_fnc_uniqueUnitItems) select {!(_x IN ["ACE_Cellphone", "ACE_Clacker", "ACE_M26_Clacker", "ACE_DefusalKit", "ACE_DeadManSwitch"])};
        //["Person cooperates", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "AinvPercMstpSnonWnonDnon", 1] call ace_common_fnc_doAnimation;
        {
          _display_text = [configFile >> "cfgWeapons" >> _x >> "displayname", "String", ""] call CBA_fnc_getConfigEntry;
          _display_pic = [configFile >> "cfgWeapons" >> _x  >> "picture", "String", ""] call CBA_fnc_getConfigEntry;
          if !(_display_text isEqualTo "") then {
            [
              {
                params ["_p", "_u", "_txt", "_pic"];
                if (_p distance2d _u <= 2 && ((animationState _u) isEqualTo "ainvpercmstpsnonwnondnon")) then {
                  [_txt, _pic, [1, 1, 1], _p, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _p];
                };
              },
              [_player, _unit , _display_text, _display_pic],
              3 + 3 * _forEachindex
            ] call cba_fnc_waitandexecute;
          };
        } forEach _allItems;
        [
          {
            params ["_t", "_anim"];
            [_t, _anim , 1] call ace_common_fnc_doAnimation;
          },
          [_unit, "AinvPercMstpSnonWnonDnon_AmovPercMstpSnonWnonDnon"],
          (count _allItems) * 3
        ] call cba_fnc_waitandexecute;
      };
      case 3 : {
        //Person verweigert Kontrolle
        //["Person is uncooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
        if ((_unit getVariable ["combattant", true]) && ((random 1 > 0.5))) then {
          [_unit] call CBA_fnc_clearWaypoints;
          [_unit, _unit getVariable ["spawn_pos", getPosATL _unit], 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_rearm"] call CBA_fnc_addWaypoint;
        };
      };
    };
  };
  case "woduwolle" : {
    _unit setVariable ["absicht_erfragt", 1, true];
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    switch _renitenz do {
      case 0 : {
        //Fall 1 : Person schweigt aus Angst
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "Acts_Kore_Introducing"] call ace_common_fnc_doGesture;
        [
          {
            params ["_p", "_u"];
            ["zumi_hinweis", [localize format ["STR_ZOPS_CIV_STORY_%1", (_u getVariable ["story", 0])], false, 8, 1], _p] call CBA_fnc_targetEvent;
          },
          [_player, _unit],
          4
        ] call cba_fnc_waitandexecute;
      };
      case 1 : {
        //Fall 2 : Person schweigt aus Angst
        //["Person does not answer (frightened)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
      };
      case 2 : {
        //Fall 3 : Person gibt Auskunft, ist aber wütend
        _sanktion = linearConversion [0, 3, _renitenz, 0.25, 1, true];
        _renitenz = (_renitenz + 1) min 3;
        _unit setVariable ["renitenz", _renitenz, true];
        ["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
        //["Person cooperates (angry)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "Acts_Kore_Introducing"] call ace_common_fnc_doGesture;
        [
          {
            params ["_p", "_u"];
            ["zumi_hinweis", [localize format ["STR_ZOPS_CIV_STORY_%1", (_u getVariable ["story", 0])], false, 8, 1], _p] call CBA_fnc_targetEvent;
          },
          [_player, _unit],
          4
        ] call cba_fnc_waitandexecute;
      };
      case 3 : {
        //Fall 4 : Person verschweigt etwas
        //["Person does not answer", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
        if ((_unit getVariable ["combattant", true]) && ((random 1 > 0.5))) then {
          [_unit] call CBA_fnc_clearWaypoints;
          [_unit, _unit getVariable ["spawn_pos", getPosATL _unit], 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_rearm"] call CBA_fnc_addWaypoint;
        };
      };
    };
  };
  case "woduwohne" : {
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    switch _renitenz do {
      case 0 : {
        //Fall 1 : Person gibt Auskunft
        ["Person asks you to follow", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        _unit enableAI "MOVE";
        _unit setVariable ["kooperiert", true, true];
        _unit setVariable ["in_deckung", 0, true];
        _unit setVariable ["hat_angst", 0, true];
        [_unit] call CBA_fnc_clearWaypoints;
        [_unit, _unit getVariable ["spawn_pos", [0,0,0]], 0, "MOVE", "SAFE", "YELLOW", "Limited", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
      };
      case 1 : {
        //Fall 1 : Person schweigt aus Angst
        ["Person says no (gentle)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
      };
      case 2 : {
        //Fall 3 : Person gibt Auskunft, ist aber wütend
        _sanktion = linearConversion [0, 3, _renitenz, 0.25, 1, true];
        _renitenz = (_renitenz + 1) min 3;
        _unit setVariable ["renitenz", _renitenz, true];
        ["zumi_sanktion", [-1 * _sanktion, _id]] call CBA_fnc_serverEvent;
        ["Person asks you to follow (angry)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        _unit enableAI "MOVE";
        _unit setVariable ["kooperiert", true, true];
        _unit setVariable ["in_deckung", 0, true];
        _unit setVariable ["hat_angst", 0, true];
        [_unit] call CBA_fnc_clearWaypoints;
        [_unit, _unit getVariable ["spawn_pos", [0,0,0]], 0, "MOVE", "SAFE", "YELLOW", "Limited", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
      };
      case 3 : {
        //Fall 4 : Person verschweigt etwas
        ["Person says no (angry)", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        _unit enableAI "MOVE";
        _unit setVariable ["kooperiert", false, true];
        _unit setVariable ["in_deckung", 0, true];
        _unit setVariable ["hat_angst", 0, true];
        [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
        [_unit] call CBA_fnc_clearWaypoints;
        if ((_unit getVariable ["combattant", true]) && ((random 1 > 0.5))) then {
          [_unit, _unit getVariable ["spawn_pos", getPosATL _unit], 0, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this call zumi_fnc_rearm"] call CBA_fnc_addWaypoint;
        } else {
          [_unit, _unit getVariable ["spawn_pos", [0,0,0]], 0, "MOVE", "SAFE", "YELLOW", "Limited", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;
        };
      };
    };
  };
};
