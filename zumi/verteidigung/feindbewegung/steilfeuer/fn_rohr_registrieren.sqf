
/*

  Mörser/Stalinorgel/Haubitze/SCUD wird den Kommandeuren unterstellt.

*/

if !isServer exitWith {};

params ["_unit"];

if (isNull _unit || !alive _unit) exitWith {};

If (_unit isKindOf "StaticMortar") exitWith {
    zumi_moerser pushBack _unit;
};

/*
private _typ = "";
private _bewaffnung = weapons (vehicle _unit);
{
    private _index = _x;
    ([_index] call BIS_fnc_itemType) params ["_itemclass","_itemtype"];
    If ((_itemtype in ["RocketLauncher"]) || (_index in ["rhs_weap_grad"])) then {
        _typ = "rakete";
    };
    If (_itemtype in ["Mortar"]) then {
        _typ = "haubitze";
    };
} forEach _bewaffnung;

switch (_typ) do {
    case "haubitze" : {
        zumi_haubitzen pushBack _unit;
    };
    case "rakete" : {
        zumi_raketen pushBack _unit;
    };
    default {
        zumi_haubitzen pushBack _unit;
    };
};
*/

If ((typeOf _unit) isEqualTo "LOP_TKA_BM21") exitWith {
    zumi_raketen pushBack _unit;
};

zumi_haubitzen pushBack _unit;
