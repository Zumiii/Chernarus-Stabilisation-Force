
private ["_unit","_trap","_bpos","_pos","_view","_asl_unit","_asl_unit_z","_hideouts","_unitpos"];

_unit = _this select 0; // Einheit, deren Sicht auf Objekt gepr�ft werden soll
_trap = _this select 1; // Objekt, das in Beobacht-Reichweite liegen soll
_pos = getPos _trap; // Objektposition
_rad = _this select 2; // Radius von Geb�udepositionen

_bpos = [];
{
	private ["_i","_p"];
	for [{_i = 0;_p = _x buildingpos _i},{str _p != "[0,0,0]"},{_i = _i + 1;_p = _x buildingpos _i}] do {
		_bpos set [count _bpos,_p];
	};
} foreach (nearestObjects [_pos, ["Building"], _rad]);

_hideouts = [];
for "_j" from 0 to ((count _bpos)-1) do {
//_view = [_unit,"GEOM",_trap] checkvisibility [eyepos _unit, getPosASL _trap];
_asl_unit = AGLtoASL (_bpos select _j);
_asl_unit_z = _asl_unit select 2;
_unitpos = [];
_unitpos set [0, (_asl_unit select 0)];
_unitpos set [1, (_asl_unit select 1)];
_asl_unit_z = _asl_unit_z + 1;
_unitpos set [2, _asl_unit_z];
_view = [_unit,"GEOM",_trap] checkvisibility [_unitpos, getPosASL _trap];
if ((_view >= 0.45) && (_unitpos distance2d getPosASL _trap >= 15)) then {_hideouts pushBack (_bpos select _j)};
};

_hideouts;
