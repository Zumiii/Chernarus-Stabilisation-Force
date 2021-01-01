params ["_unit"];

if !(local _unit) exitWith {};

private _target = [_unit] call zumi_fnc_hit_and_run;

if ((count _target) > 0) then {
  [_unit] call CBA_fnc_clearWaypoints;
  [_unit, (_target select 0), 2, "MOVE", "CARELESS", "BLUE", "LIMITED", "STAG COLUMN", "[this, [this] call cba_fnc_getPos, 'SatchelCharge_Remote_Mag', 'Cellphone', ('ACE_Cellphone' in (items this + assignedItems this)), true] call zumi_fnc_place_ied"] call zumi_fnc_addWaypoint;

};
