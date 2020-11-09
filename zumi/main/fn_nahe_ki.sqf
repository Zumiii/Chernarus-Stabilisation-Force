/*

  Diese Funktion retourniert KI im Umkreis von X Metern (Nach Typ)

*/

private ["_position","_radius","_side","_types","_nearEntities","_validEntities"];

params [["_position", [0,0,0]], ["_radius",50], ["_sides", [EAST,WEST,RESISTANCE]], ["_types", ["CAManBase","LandVehicle"]]];

if (typeName _sides != typeName []) then {_sides = [_sides]};
if (typeName _types != typeName []) then {_types = [_types]};

_vehicles = [];

_validEntities	= [];
_nearEntities	= (_position nearEntities [_types, _radius]) select {!isPlayer _x};

_vehicles = [];

{
 if ((side _x) IN _sides && (alive _x)) then {_validEntities pushBackUnique _x;};
} forEach _nearEntities;

{
 if ((side _x) IN _sides && (alive _x)) then {_vehicles pushBackUnique _x;};
} forEach _nearEntities;

{
	if ((_x isKindOf "Landvehicle") || (_x isKindOf "Helicopter")) then {
	 	_crew = fullCrew [_x,"cargo",false];
	 	{_validEntities pushBackUnique _x;} forEach _crew;
	};
} forEach _vehicles;

_validEntities
