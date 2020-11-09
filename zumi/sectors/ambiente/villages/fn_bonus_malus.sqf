/*

  Skript, um Stabilitätswert zu modifizieren, entweder von einer Ortschaft oder von der ganzen Map.

*/

if !isServer exitWith {};

params ["_wert", ["_id", -1]];

if (_id < 0) then {
  //Penalty auf alle Orte
  if (_wert > 0) then {
    //Mache sicherer
    {
      private _situation = _x select 3;
      _situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];
      _situation set [0, (_tension - _wert) max 0];
    } forEach villages;
  } else {
    //Mache unsicherer
    {
      private _situation = _x select 3;
      _situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];
      _situation set [0, (_tension - _wert) min 100];
    } forEach villages;
  };
} else {
  //Penalty auf spezifischen Ort
  if (_wert > 0) then {
    private _situation = (villages select _id) select 3;
    _situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];
    _situation set [0, (_tension - _wert) max 0];
  } else {
    private _situation = (villages select _id) select 3;
    _situation params [["_tension", 50],["_humanitarian", 50],["_ied", false]];
    _situation set [0, (_tension - _wert) min 100];
  };
};
