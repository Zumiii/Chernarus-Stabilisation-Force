
params ["_unit", "_position", ["_mode",0]];

[_unit] call CBA_fnc_clearWaypoints;

[
	{
		params ["_args","_handle"];
		_args params ["_unit","_position","_mode"];
    if (!alive _unit || isNull _unit) exitWith {
      [_handle] call CBA_fnc_removePerFrameHandler;
    };
		private _targets = _unit nearTargets 100;
		_targets = _targets select {
		  (side (_x select 4) IN [west, resistance])
		};
		if (_targets isEqualTo []) exitWith {};
		private _targets = _targets select {((_x select 1) isKindOf "Car") || ((_x select 1) isKindOf "Tank") || ((_x select 1) isKindOf "CAManBase")};
		if (count _targets < 1) exitWith {};
		[_unit, _position, _mode, _targets, ([_targets, {-(_unit distance2d (_x select 4))}, _unit] call CBA_fnc_selectBest) select 4, _handle] call zumi_fnc_trigger_vest;
	},
	5,
	[_unit, _position, _mode]
] call CBA_fnc_addPerFrameHandler;
