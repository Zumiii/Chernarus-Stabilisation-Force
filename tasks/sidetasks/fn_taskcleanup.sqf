if !isServer exitWith {};

params [
  "_zu_cleanen",
  ["_sofort", true],
  ["_pos", 0]
];



if (_sofort) then {
  _zu_cleanen call CBA_fnc_deleteEntity;
} else {
  {
    [
    	{
    		params ["_args","_handle"];
        _args params ["_pos","_trash"];

        if (count ([(_trash call CBA_fnc_getPos), _pos, [west, civilian, resistance, east],["CAManBase","LandVehicle","Air"]] call zumi_fnc_nahe_spieler) <= 0) then {
          _trash call CBA_fnc_deleteEntity;
          [_handle] call CBA_fnc_removePerFrameHandler;
        };
    	},
    	10,
    	[_pos, _x]
    ] call CBA_fnc_addPerFrameHandler;
  } forEach _zu_cleanen;

};
