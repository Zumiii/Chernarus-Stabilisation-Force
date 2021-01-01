params ["_unit", "_position", "_mode", "_targets", "_target", "_handle"];

if !(local _unit) exitWith {};

[_handle] call CBA_fnc_removePerFrameHandler;
[_unit] call CBA_fnc_clearWaypoints;
_unit setCaptive false;
_unit enableAI "AUTOCOMBAT";

//Einheit rennt auf Ziel zu und triggert ev. Weste.
[
	{
		params ["_args","_handle"];
		_args params ["_unit","_position","_mode","_targets","_target"];
    if (!alive _unit || isNull _unit) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
    _unit doMove (position _target);
		if ({_unit distance2d (_x select 4) <= 5} count _targets > 0 && (alive _unit)) then {
      [_handle] call CBA_fnc_removePerFrameHandler;
      _unit say3d format ["blow_%1", ceil round random 2];
      private _charges = attachedObjects _unit;
      if (!(_charges isequalTo []) && ("ACE_DeadManSwitch" in (items _unit + assignedItems _unit))) then {
        [
          {
            params ["_unit","_charges"];
            for "_i" from 0 to (count _charges)-1 do {
              [_unit, -1, [(_charges select _i), 0], "ACE_DeadManSwitch"] call ACE_Explosives_fnc_detonateExplosive;
            };
          },
          [_unit, _charges],
          1.5
        ] call CBA_fnc_waitAndExecute;
      };
      [
        {
          params ["_unit","_position","_mode","_handle"];
          if (!alive _unit || isNull _unit) exitWith {};
          [_handle] call CBA_fnc_removePerFrameHandler;
          [_unit, _position, _mode] call zumi_fnc_c4_wait;
        },
        [_unit, _position, _mode, _handle],
        30
      ] call CBA_fnc_waitAndExecute;
		};
	},
	2,
	[_unit, _position, _mode, _targets, _target]
] call CBA_fnc_addPerFrameHandler;
