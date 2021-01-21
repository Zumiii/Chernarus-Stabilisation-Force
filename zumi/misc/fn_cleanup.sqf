/*

  Cleanupscript

*/

if !isServer exitWith {};


If (count allDeadMen > 0) then {
  private _tote = allDeadMen;
  private _reduktion = floor(((count allDeadMen)/3)*2);
  _tote resize _reduktion;
  {
    deleteVehicle _x;
  } forEach (_tote select {((_x getVariable ["tod", cba_missiontime]) + 600) <= cba_missiontime});
};
private _schrott = (
  allMissionObjects "WeaponHolder" +
  allMissionObjects "GroundWeaponHolder" +
  allMissionObjects "WeaponHolderSimulated"
);
{
  private _spieler	= [];
  private _entities	= _x nearEntities [["CAManBase","LandVehicle","Air"], 150];
  {
   if (isPlayer _x && (side _x IN [west,civilian,resistance]) && (alive _x)) then {
     _spieler pushBack _x;
   };
 } forEach _entities;
  if ((count _spieler == 0) && (_x getVariable ["kann_weg", true])) then {
    deleteVehicle _x;
  };
} forEach _schrott;
{
	if (damage _x > 0.8 && ({alive _x} count crew _x == 0) && (_x getVariable ["kann_weg", true])) then {
		deleteVehicle _x;
	};
} forEach (vehicles select {((_x getVariable ["tod", cba_missiontime]) + 600) <= cba_missiontime});;
{
  if (count (units _x) == 0) then {
    deleteGroup _x;
    _x = grpNull;
    _x = nil;
  };
} foreach allGroups;

[
	{
		[] call zumi_fnc_cleanup;
	},
	[],
	600
] call cba_fnc_waitandexecute;
