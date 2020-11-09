params ["_unit", "_code", ["_duck", false]];

[
  {
    params ["_u", "_d"];
    if !(_d) then {
      [_u, "acts_millerChooper_in", 2] call ace_common_fnc_doAnimation;
    } else {
      [_u, "Acts_CivilHiding_1", 1] call ace_common_fnc_doAnimation;
    };
    _u say3d format ["blow_%1", ceil (random 2)];
  },
  [_unit, _duck],
  2
] call cba_fnc_waitandexecute;
[
  {
    params ["_u", "_c"];
    [_u, _c] call ACE_explosives_fnc_dialPhone;
    _u setCaptive false;
    _u enableAI "AUTOCOMBAT";
    //TODO: Make Combattant
  },
  [_unit, _code],
  3
] call cba_fnc_waitandexecute;
