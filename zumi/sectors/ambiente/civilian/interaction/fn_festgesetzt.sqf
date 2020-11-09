params ["_unit","_bool"];

private ["_effekten","_legit"];

if (_unit getVariable ["ace_captives_isHandcuffed",false]) then { //ev erweitern
  _effekten = ["ACE_DeadManSwitch","ACE_Cellphone"];
  _legit = false;
  for "_i" from 0 to (count _effekten)-1 do {
    if ((_effekten select _i) in items _unit) then {
      _legit = true;
    };
  };
  if (!_legit || !(_unit getVariable ["gesucht",false])) then {
    _unit setVariable ["hat_intel",-1];
  } else {
    if (debug) then {systemchat format ["%1 arrested",name _unit];};
    //mach was
  };
} else {
  if (debug) then {systemchat format ["%1 freed",name _unit];};
  //mach was
};
