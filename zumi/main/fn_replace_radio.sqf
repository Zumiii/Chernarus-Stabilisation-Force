
params ["_itemarray"];
_itemarray params ["_items", "_amount"];
{
  if (!(_x isEqualType []) && {[_x] call acre_api_fnc_isRadio}) then {
      _items set [_forEachindex, [_x] call acre_api_fnc_getBaseRadio];
  };
} forEach _items;

[_items, _amount];
// Replace only if string (array can be eg. weapon inside container) and an ACRE radio
