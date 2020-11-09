/*

  Liest Intel speicherstände aus
  

*/

if !isServer exitWith {};


private _inidbi = ["new", "us"] call OO_INIDBI;


zumi_intels = ["read", ["Missionspersistenz", "Intels", []]] call _inidbi;

if (count zumi_intels < 1) exitWith {
  //Noch kein Intel vorhanden, also muss das erste her

};

//Intels, die älter sind als eine Woche entfallen
{
  _X params [["_task", ""], ["_description", ""], ["_gridreferences", []], ["_date", ""]];

} forEach zumi_intels;
