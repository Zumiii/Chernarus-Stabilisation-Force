private ["_return"];

_return = [];

{
	if (_x select 0 == _this) then {
		_return = _x select 1;
	};
} forEach grp_presets;

_return
