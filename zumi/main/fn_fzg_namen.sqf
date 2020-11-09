private ["_classnames","_return"];

_classnames = _this;
_return = [];
{_return = _return + (fzg_presets select _x);} forEach _classnames;

_return
