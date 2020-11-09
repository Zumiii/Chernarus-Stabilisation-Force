/*

  Gruppe versteckt sich an einer Position und wartet auf Feindkontakt.

*/



params ["_grp"];

private ["_position"];

_grp = _grp call CBA_fnc_getGroup;
if !(local _grp) exitWith {};

_position = getPosATL (leader _grp);

[leader _grp, _position, 0, "MOVE", "STEALTH", "GREEN", "NORMAL", "Wedge", "true", "private _befehl = (group this) getVariable ['befehl', []]; if !(_befehl isEqualTo []) then {
		_befehl params ['_zielkoordinate', '_auftrag', '_dauer'];
		[
		  {
		    params ['_grp','_zielkoordinate'];
		    if ({alive _x} count (units _grp) == 0 || (isNull _grp)) exitWith {};
		    _grp setvariable ['befehl', []];
		    [_grp, _zielkoordinate] call zumi_fnc_befehl_erfragen;
		  },
		  [(group this), (this call CBA_fnc_getPos)],
		  _dauer
		] call CBA_fnc_waitAndExecute;
	};"
] call zumi_fnc_addWaypoint;





//Die Gruppe greift erst ins geschehen ein, wenn sie Feinde sichtet.
[
	{
		params ["_args","_handle"];
		_args params ["_grp","_position"];
    if ({alive _x} count (units _grp) || (isNull _grp) || ((_grp getvariable ["befehl",[]]) isEqualTo [])) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
    private _ziele = ([_position,300,[west,resistance,civilian],["CAManBase","LandVehicle"]] call zumi_fnc_nahe_spieler) + ([_position,150,[west,resistance],["CAManBase","LandVehicle"]] call zumi_fnc_nahe_ki);
		if ({(leader _grp) knowsAbout _x >= 3} count _ziele > 0) then {
			[_grp, getPos (_ziele call bis_fnc_selectRandom), "angreifen", 600] call zumi_fnc_befehl_erhalten;
      [_handle] call CBA_fnc_removePerFrameHandler;
		};
	},
	5,
	[_grp,_position]
] call CBA_fnc_addPerFrameHandler;
