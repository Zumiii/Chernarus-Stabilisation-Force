/*

  Diese Funktion retourniert Spieler im Umkreis von X Metern (Nach Typ)

*/

private ["_position","_radius","_side","_types","_nearEntities","_validEntities"];

params [["_position",[0,0,0]],["_radius",50],["_sides",[EAST,WEST,RESISTANCE]],["_types",["CAManBase","LandVehicle"]],["_exponiert",false]];

if (typeName _sides != typeName []) then {_sides = [_sides]};
if (typeName _types != typeName []) then {_types = [_types]};

_vehicles = [];

_validEntities	= [];
_nearEntities	= (_position nearEntities [_types, _radius]) select {((getPosATL _x) select 2) <= 250};

_vehicles = [];

{
 if ((isPlayer _x) && (side _x) IN _sides && (alive _x)) then {_validEntities pushBack _x;};
} forEach _nearEntities;

{
 if ((isPlayer _x) && (side _x) IN _sides && (alive _x)) then {_vehicles pushBack _x;};
} forEach _nearEntities;

{
	if ((_x isKindOf "Landvehicle") || (_x isKindOf "Helicopter")) then {
	 	_crew = fullCrew [_x,"cargo",false];
	 	{_validEntities pushBack _x;} forEach _crew;
	};
} forEach _vehicles;

if (_exponiert) then {
  if ({!(primaryWeaponMagazine _x isEqualTo []) || !(secondaryWeaponMagazine _x isEqualTo []) || !(weaponLowered _x)} count _validEntities > 0) then {
    _validEntities = 0;
  };
};

_validEntities
