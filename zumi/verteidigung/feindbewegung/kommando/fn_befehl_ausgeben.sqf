/*

  Ein Kommandeur erlässt einen Befehl.

*/



params [["_ziel", objNull], "_encounter", ["_kommandeur", objNull]];
//_encountervarianten params ["_array","_prob"];
_encounter params ["_truppengattung", ["_dauer",600], ["_menge",3]];
//Bekämpfe ein Ziel durch den Kommandanten.

//Wenn es ein Luftschlag ist, verlasse Skript
if (_truppengattung isEqualTo "bomber") exitWith {
  zumi_befehle pushback [(_ziel call cba_fnc_getPos), "luftschlag", _truppengattung, _dauer, _menge, false, 0, _ziel];
  if (debug) then {
    systemChat format ["Luftschlag bei %1", (_ziel call cba_fnc_getPos)];
  };
  //Merke, wie lange das Ziel bekämpft wird
  [
    {
      params ["_feindziel"];
      If (zumi_feindziele isEqualTo []) exitwith {};
      _index = (zumi_feindziele find _feindziel);
      if (_index < 0) exitWith {};
      zumi_feindziele deleteAt _index;
    },
    [_ziel],
    _dauer
  ] call CBA_fnc_waitAndExecute;
};



if (_truppengattung IN ["moerser","rakete","haubitze","steilfeuer"]) then {

  //Wenn es ein Mörserziel ist, schiesse mit Mörser
  [_ziel call cba_fnc_getPos, _truppengattung, "", _menge] call zumi_fnc_steilfeuerbefehl;
  if (debug) then {
    systemChat format ["Ziel bei %1 beschiessen mit %2 und %3 Sekunden Ruhe", (_ziel call cba_fnc_getPos), _truppengattung, _dauer];
  };
  [
    {
      params ["_feindziel"];
      If (zumi_feindziele isEqualTo []) exitwith {};
      _index = (zumi_feindziele find _feindziel);
      if (_index < 0) exitWith {};
      zumi_feindziele deleteAt _index;
    },
    [_ziel],
    _dauer
  ] call CBA_fnc_waitAndExecute;
} else {
  //Bekämpfe ein Ziel durch den Kommandanten
  zumi_befehle pushback [(_ziel call cba_fnc_getPos), "angreifen", _truppengattung, _dauer, _menge];
  //Merke, wie lange das Ziel bekämpft wird
  [
    {
      params ["_feindziel"];
      If (zumi_feindziele isEqualTo []) exitwith {};
      _index = (zumi_feindziele find _feindziel);
      if (_index < 0) exitWith {};
      zumi_feindziele deleteAt _index;
    },
    [_ziel],
    _dauer
  ] call CBA_fnc_waitAndExecute;
  if (debug) then {
    systemChat format ["Ziel bei %1 %2 mit %3 für %4 Sekunden", (_ziel call cba_fnc_getPos), "angreifen", _truppengattung, _dauer];
  };
};

//Kommandeur kann hiernach 5 Min nicht mehr befehligen
_kommandeur setVariable ["letzte_befehlsausgabe", CBA_missiontime + 300];
