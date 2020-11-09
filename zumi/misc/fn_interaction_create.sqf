
/*

  Ace kann nur lokal Interaktionen generieren...

*/

params [
    "_actionName",
    "_displayName",
    "_icon",
    "_statement",
    "_condition",
    ["_insertChildren", {}],
    ["_customParams", []],
    ["_position", {[0, 0, 0]}],
    ["_distance", 2],
    ["_params", [false, false, false, false, false]],
    ["_modifierFunction", {}]
];

_position = if (_position isEqualType "") then {
    // If the action is set to a selection, create the suitable code - IGNORE_PRIVATE_WARNING(_target);
    compile format ["_target selectionPosition '%1'", _position];
} else {
    if (_position isEqualType []) then {
        // If the action is set to a array position, create the suitable code
        compile format ["%1", _position];
    } else {
        _position;
    };
};

[
    _actionName,
    _displayName,
    _icon,
    _statement,
    _condition,
    _insertChildren,
    _customParams,
    _position,
    _distance,
    _params,
    _modifierFunction
]
