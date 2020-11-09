/*

  Spieler befrägt einen potenziellen Informanten nach dem Feind

*/


params ["_unit", "_player", "_id", "_frage"];


//_unit setVariable ["informant", 0, true];
if (_unit getVariable ["combattant", false]) exitWith {
  [_unit, "gestureHib" ,1] call ace_common_fnc_doGesture;
};

switch _frage do {
  case "taskhint" : {
    _unit setVariable ["befragt", true, true];
    [format ["The chieftain of %1 tells you what he knows...", (villages select _id) select 8], "\A3\ui_f\data\igui\cfg\simpleTasks\types\map_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
    switch (_unit getVariable ["renitenz", 0]) do {
      case 0 : {
        _dirto = [getPos _unit getDir zumi_taskpos, 45] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 45 : {"northeast"};
          case 90 : {"east"};
          case 135 : {"southeast"};
          case 180 : {"south"};
          case 225 : {"southwest"};
          case 270 : {"west"};
          case 315 : {"northwest"};
          default {"north"};
        };
        _dist = _unit distance2d _pos;
        _entfernung = switch (true) do {
          case (_dist <= 1000) : {"within 1 kilometer"};
          case (_dist > 1000 && _dist <= 2000) : {"one, maybe two  kilometer from here (<150m)"};
          case (_dist > 2000 && _dist <= 3000) : {"about two to three  kilometer away from here"};
          case (_dist > 3000 && _dist <= 5000) : {"about three to five  kilometer away from here"};
          default {"far away"};
        };
        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir", "_entfernung"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He points towards %1, the enemy was seen %2", _dir, _entfernung], false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir, _entfernung],
          5
        ] call cba_fnc_waitandexecute;
      };
      case 1 : {
        _dirto = [getPos _unit getDir zumi_taskpos, 45] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 45 : {"northeast"};
          case 90 : {"east"};
          case 135 : {"southeast"};
          case 180 : {"south"};
          case 225 : {"southwest"};
          case 270 : {"west"};
          case 315 : {"northwest"};
          default {"north"};
        };
        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He points roughly towards %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir],
          5
        ] call cba_fnc_waitandexecute;
      };
      case 2 : {
        _dirto = [getPos _unit getDir zumi_taskpos, 90] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 90 : {"east"};
          case 180 : {"south"};
          case 270 : {"west"};
          default {"north"};
        };
        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He points roughly towards %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir],
          5
        ] call cba_fnc_waitandexecute;
      };
      case 3 : {
        _dirto = [random 360, 45] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 45 : {"northeast"};
          case 90 : {"east"};
          case 135 : {"southeast"};
          case 180 : {"south"};
          case 225 : {"southwest"};
          case 270 : {"west"};
          case 315 : {"northwest"};
          default {"north"};
        };
        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He points roughly towards %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir],
          5
        ] call cba_fnc_waitandexecute;
      };
      default {
        _dirto = [random 360, 45] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 45 : {"northeast"};
          case 90 : {"east"};
          case 135 : {"southeast"};
          case 180 : {"south"};
          case 225 : {"southwest"};
          case 270 : {"west"};
          case 315 : {"northwest"};
          default {"north"};
        };
        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He points roughly towards %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir],
          5
        ] call cba_fnc_waitandexecute;
      };
    };
  };
  case "chef_wo" : {
    //Einheit wird nach der Position des Dorfältesten gefragt
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    switch _renitenz do {
      case 0 : {
        //Fall 1 : Person reagiert freundlich und helfend
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        private _pos = ((villages select _id) select 12);
        private _building = (((villages select _id) select 12) call CBA_fnc_getNearestBuilding) select 0;
        private _description = [configFile >> "CfgVehicles" >> (typeOf _building) >> "Editorpreview", "STRING", ""] call CBA_fnc_getConfigEntry;
        _dirto = [getPos _unit getDir _pos, 45] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 45 : {"northeast"};
          case 90 : {"east"};
          case 135 : {"southeast"};
          case 180 : {"south"};
          case 225 : {"southwest"};
          case 270 : {"west"};
          case 315 : {"northwest"};
          default {"north"};
        };
        _dist = _unit distance2d _pos;
        _entfernung = switch (true) do {
          case (_dist <= 25) : {"within 25m"};
          case (_dist > 25 && _dist <= 150) : {"not far from here (<150m)"};
          case (_dist > 150 && _dist <= 300) : {"about 150-300m away from here"};
          case (_dist > 300 && _dist <= 500) : {"about 300-500m away from here"};
          default {"hier im Dorf"};
        };

        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir", "_entfernung", "_dsc"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He points towards %1, he is %2", _dir, _entfernung], false, 8, 1], _p] call CBA_fnc_targetEvent;
              ["The building:", _dsc, [1, 1, 1], _p, 4] remoteExecCall ["ace_common_fnc_displayTextPicture", _p];
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir, _entfernung, _description],
          5
        ] call cba_fnc_waitandexecute;
      };
      case 1 : {
        //Fall 2 : Person gibt ne grobe Himmelsrichtung an
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        private _pos = ((villages select _id) select 12);
        _dirto = [getPos _unit getDir _pos, 45] call BIS_fnc_roundDir;
        _dir = switch _dirto do {
          case 0 : {"north"};
          case 45 : {"northeast"};
          case 90 : {"east"};
          case 135 : {"southeast"};
          case 180 : {"south"};
          case 225 : {"southwest"};
          case 270 : {"west"};
          case 315 : {"northwest"};
          default {"north"};
        };
        _unit setRandomLip true;
        [
          {
            params ["_p", "_u", "_id", "_dir"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", [format ["He tells you to head %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id, _dir],
          5
        ] call cba_fnc_waitandexecute;
      };
      case 2 : {
        //Fall 3 : Person will nicht helfen
        //["Person is not cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [_unit, "gestureHib" , 1] call ace_common_fnc_doGesture;
      };
      case 3 : {
        //Fall 4 : Person schickt die Spieler eventuell in eine Gefahrensituation
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        private _ieds = zumi_ieds select {(alive _x) &&  (_x distance2d _unit <= 1000)};
        if (count zumi_ieds >= 1) then {
          _ied = [_ieds, 1] call CBA_fnc_selectRandomArray;
          private _pos = _ied select 0;
          _dirto = [getPos _unit getDir _pos, 45] call BIS_fnc_roundDir;
          _dir = switch _dirto do {
            case 0 : {"north"};
            case 45 : {"northeast"};
            case 90 : {"east"};
            case 135 : {"southeast"};
            case 180 : {"south"};
            case 225 : {"southwest"};
            case 270 : {"west"};
            case 315 : {"northwest"};
            default {"north"};
          };
          _unit setRandomLip true;
          [
            {
              params ["_p", "_u", "_id", "_dir"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", [format ["He tells you to head %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id, _dir],
            5
          ] call cba_fnc_waitandexecute;
        } else {
          _dirto = [random 360, 45] call BIS_fnc_roundDir;
          _dir = switch _dirto do {
            case 0 : {"north"};
            case 45 : {"northeast"};
            case 90 : {"east"};
            case 135 : {"southeast"};
            case 180 : {"south"};
            case 225 : {"southwest"};
            case 270 : {"west"};
            case 315 : {"northwest"};
            default {"north"};
          };
          [
            {
              params ["_p", "_u", "_id", "_dir"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", [format ["He tells you to head %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
            },
            [_player, _unit, _id, _dir],
            3
          ] call cba_fnc_waitandexecute;
        };
      };
    };
  };
  case "bewaffnete_wo" : {
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    switch _renitenz do {
      case 0 : {
        //Gibt detaillierte Auskunft über bewaffnete Nichtregierungskräfte im Ort, die den Zivilisten bekannt sind
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        //Alle dynamischen tak / milizen innerhalb 2 kilometer
        private _bewaffnete = ([_unit call cba_fnc_getPos, 2000, [EAST, RESISTANCE]] call zumi_fnc_nahe_ki) select {(side _unit) Knowsabout (vehicle _x) >= 1};
        private _dynamische = dyn_array select {((_x select 1) && (((_x select 4) select 5) IN ["miliz","tak"])  && ((_x select 2) distance2d (_unit call cba_fnc_getPos) <= 2000))};
        {
          _bewaffnete pushBackUnique (leader (_x select 5));
        } forEach _dynamische;
        if (count _bewaffnete > 0) then {
          {
            _bewaffnete set [_forEachIndex, [_x, (_x distance2d _unit)]];
          } forEach _bewaffnete;
          //Sortiere
          _bewaffnete = [_bewaffnete, 1] call CBA_fnc_sortNestedArray;
          //Zeige Position des Nächstgelegenen Schützen
          private _pos = ((_bewaffnete select 0) select 0) call cba_fnc_getPos;
          _dirto = [getPos _unit getDir _pos, 45] call BIS_fnc_roundDir;
          _dir = switch _dirto do {
            case 0 : {"north"};
            case 45 : {"northeast"};
            case 90 : {"east"};
            case 135 : {"southeast"};
            case 180 : {"south"};
            case 225 : {"southwest"};
            case 270 : {"west"};
            case 315 : {"northwest"};
            default {"north"};
          };
          _dist = _unit distance2d _pos;
          _entfernung = switch (true) do {
            case (_dist <= 1000) : {"within 1 kilometer"};
            case (_dist > 1000 && _dist <= 2000) : {"one, maybe two  kilometer from here"};
            default {"two or even more kilometer away from here"};
          };
          _unit setRandomLip true;
          [
            {
              params ["_p", "_u", "_id", "_dir", "_entfernung"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", [format ["There is armed men %1, %2", _dir, _entfernung], false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id, _dir, _entfernung],
            5
          ] call cba_fnc_waitandexecute;
        } else {
          //Keine gesehen
          _unit setRandomLip true;
          [
            {
              params ["_p", "_u"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", ["No armed men were seen by this guy", false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit],
            5
          ] call cba_fnc_waitandexecute;
        };
      };
      case 1 : {
        //Gibt ängstlich Auskunft, oder keine, wenn Feind nah
        //["Person cooperates anxiously", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        private _bewaffnete = ([_unit call cba_fnc_getPos, 2000, [EAST, RESISTANCE]] call zumi_fnc_nahe_ki) select {(side _unit) Knowsabout (vehicle _x) >= 1};
        private _dynamische = dyn_array select {((_x select 1) && (((_x select 4) select 5) IN ["miliz","tak"])  && ((_x select 2) distance2d (_unit call cba_fnc_getPos) <= 2000))};
        {
          _bewaffnete pushBackUnique (leader (_x select 5));
        } forEach _dynamische;
        if (count _bewaffnete > 0) then {
          {
            _bewaffnete set [_forEachIndex, [_x, (_x distance2d _unit)]];
          } forEach _bewaffnete;
          //Sortiere
          _bewaffnete = [_bewaffnete, 1] call CBA_fnc_sortNestedArray;
          //Zeige Position des Nächstgelegenen Schützen
          private _pos = ((_bewaffnete select 0) select 0) call cba_fnc_getPos;
          _dirto = [getPos _unit getDir _pos, 45] call BIS_fnc_roundDir;
          _dir = switch _dirto do {
            case 0 : {"north"};
            case 45 : {"northeast"};
            case 90 : {"east"};
            case 135 : {"southeast"};
            case 180 : {"south"};
            case 225 : {"southwest"};
            case 270 : {"west"};
            case 315 : {"northwest"};
            default {"north"};
          };
          _unit setRandomLip true;
          [
            {
              params ["_p", "_u", "_id", "_dir"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", [format ["There is armed men %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id, _dir],
            5
          ] call cba_fnc_waitandexecute;
        } else {
          //Keine gesehen
          [
            {
              params ["_p", "_u"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", ["No armed men were seen by this guy", false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit],
            5
          ] call cba_fnc_waitandexecute;
        };
      };
      case 2 : {
        //Ungenaue Angabe
        //["Person cooperates anxiously", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        private _bewaffnete = ([_unit call cba_fnc_getPos, 2000, [EAST, RESISTANCE]] call zumi_fnc_nahe_ki) select {(side _unit) Knowsabout (vehicle _x) >= 1};
        private _dynamische = dyn_array select {((_x select 1) && (((_x select 4) select 5) IN ["miliz","tak"])  && ((_x select 2) distance2d (_unit call cba_fnc_getPos) <= 2000))};
        {
          _bewaffnete pushBackUnique (leader (_x select 5));
        } forEach _dynamische;
        if (count _bewaffnete > 0) then {
          {
            _bewaffnete set [_forEachIndex, [_x, (_x distance2d _unit)]];
          } forEach _bewaffnete;
          //Sortiere
          _bewaffnete = [_bewaffnete, 1] call CBA_fnc_sortNestedArray;
          //Zeige Position des Nächstgelegenen Schützen
          private _pos = ((_bewaffnete select 0) select 0) call cba_fnc_getPos;
          _dirto = [getPos _unit getDir _pos, 90] call BIS_fnc_roundDir;
          _dir = switch _dirto do {
            case 0 : {"north"};
            case 90 : {"east"};
            case 180 : {"south"};
            case 270 : {"west"};
            default {"north"};
          };
          _unit setRandomLip true;
          [
            {
              params ["_p", "_u", "_id", "_dir"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", [format ["There is armed men %1", _dir], false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id, _dir],
            5
          ] call cba_fnc_waitandexecute;
        } else {
          //Keine gesehen
          _unit setRandomLip true;
          [
            {
              params ["_p", "_u"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", ["No armed men were seen by this guy", false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit],
            5
          ] call cba_fnc_waitandexecute;
        };
      };
      case 3 : {
        //Ruft ev. vorhandene Einheiten an oder macht eine Falschangabe
        //["Person seems angry", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\combat_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        ["zumi_hinweis", ["No armed men were seen by this guy", false, 8, 1], _p] call CBA_fnc_targetEvent;
      };
    };
  };
  case "bomben_wo" : {
    _renitenz = _unit getVariable ["renitenz", 0];
    _helme_auf = _unit call zumi_fnc_helmcheck;
    if (_helme_auf < 1) then {
      if (_renitenz < 3) then {
        _renitenz = (_renitenz - 1) max 0;
      };
    };
    _unit setRandomLip true;
    switch _renitenz do {
      case 0 : {
        //["Person is cooperative", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\safe_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        //Person klärt Spieler genau auf über eine Sprengfalle, falls vorhanden, oder sagt, dass sie über keine Bescheid weiss.
        _ieds = zumi_ieds select {_x mineDetectedBy (side _unit)};
        if (count _ieds > 0) then {
          _ied = [_ieds, 1] call CBA_fnc_selectRandomArray;
          private _pos = _ied select 0;
          _dirto = [getPos _unit getDir _pos, 45] call BIS_fnc_roundDir;
          _dir = switch _dirto do {
            case 0 : {"north"};
            case 45 : {"northeast"};
            case 90 : {"east"};
            case 135 : {"southeast"};
            case 180 : {"south"};
            case 225 : {"southwest"};
            case 270 : {"west"};
            case 315 : {"northwest"};
            default {"north"};
          };
          _dist = _unit distance2d _pos;
          _entfernung = switch (true) do {
            case (_dist <= 25) : {"within 25m"};
            case (_dist > 25 && _dist <= 150) : {"not far from here (<150m)"};
            case (_dist > 150 && _dist <= 300) : {"about 150-300m away from here"};
            case (_dist > 300 && _dist <= 500) : {"about 300-500m away from here"};
            default {"here in this village"};
          };
          [
            {
              params ["_p", "_u", "_id", "_dir", "_entfernung"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", [format ["There is a possible ied, %2, %1", _dir, _entfernung], false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id, _dir, _entfernung],
            5
          ] call cba_fnc_waitandexecute;
        } else {
          [
            {
              params ["_p", "_u", "_id"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", ["None have been seen recently", false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id],
            5
          ] call cba_fnc_waitandexecute;
        };
      };
      case 1 : {
        //Person schweigt aus Angst oder sagt, dass sie über keine Bescheid weiss.
        _ieds = zumi_ieds select {_x mineDetectedBy (side _unit)};
        //["Person seems nervous", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        if (count _ieds > 0) then {
          [
            {
              params ["_p", "_u", "_id"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", ["Person nods anxiously", false, 8, 1], _p] call CBA_fnc_targetEvent;
                [_u, "gestureNod", 1] call ace_common_fnc_doGesture;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id],
            5
          ] call cba_fnc_waitandexecute;
        } else {
          [
            {
              params ["_p", "_u", "_id"];
              if (_p distance2d _u <= 3 && (alive _u)) then {
                ["zumi_hinweis", ["None have been seen recently", false, 8, 1], _p] call CBA_fnc_targetEvent;
              };
              _u setRandomLip false;
            },
            [_player, _unit, _id],
            5
          ] call cba_fnc_waitandexecute;
        };
      };
      case 2 : {
        //Person ist macht eine Falschangabe
        _ieds = zumi_ieds select {_x mineDetectedBy (side _unit)};
        //["Person seems nervous", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [
          {
            params ["_p", "_u", "_id"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", ["None have been seen recently", false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id],
          5
        ] call cba_fnc_waitandexecute;
      };
      case 3 : {
        //Person lügt
        _ieds = zumi_ieds select {_x mineDetectedBy (side _unit)};
        //["Person seems nervous", "\A3\UI_F_Curator\Data\RscCommon\RscAttributeBehaviour\aware_ca.paa", [1, 1, 1], _player, 2] remoteExecCall ["ace_common_fnc_displayTextPicture", _player];
        [
          {
            params ["_p", "_u", "_id"];
            if (_p distance2d _u <= 3 && (alive _u)) then {
              ["zumi_hinweis", ["None have been seen recently", false, 8, 1], _p] call CBA_fnc_targetEvent;
            };
            _u setRandomLip false;
          },
          [_player, _unit, _id],
          5
        ] call cba_fnc_waitandexecute;
        if (count _ieds > 0) then {
          //Wenn es ein Kombattant ist, gibt er eine Warnung raus

        } else {
          //Wenn es ein Kombattant ist, gibt er ev. eine IED Aktion in Auftrag

        };
      };
    };
  };
};
