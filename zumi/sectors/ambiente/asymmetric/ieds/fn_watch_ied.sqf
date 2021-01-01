

params ["_unit","_position","_bomb"];

if !(local _unit) exitWith {};

_view = [_unit, _bomb, 200] call zumi_fnc_sneaky;
if (count _view >= 2) then {
	for "_i" from 0 to (((count _view)-1) min 1) do {
		[_unit, _view select _i, 0, "MOVE", "SAFE", "GREEN", "Limited", "COLUMN","", [14,22,32]] call CBA_fnc_addWaypoint;
	};
	[_unit, _view select 0, 0, "CYCLE", "SAFE", "GREEN", "Limited", "COLUMN","", [4,8,12]] call CBA_fnc_addWaypoint;
} else {
	[group _unit, _position, 150, 4, "MOVE", "SAFE", "GREEN", "LIMITED", "STAG COLUMN", ""] call CBA_fnc_taskPatrol;
};
