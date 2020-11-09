if !isServer exitWith {};


params ["_posarray", "_mode"];

private ["_pos","_obj","_roadConnectedTo","_nearroad","_refroad","_connectedRoad","_dir"];

_objects = [];
{
	_rnd = floor random 14;
	if (isOnRoad _x) then {
		_nearroad = _x nearRoads 25;
		if(count _nearroad > 0) then {
			_refroad = _nearroad select 0;
			private _roadinfo = getRoadInfo _refroad;
			_roadinfo params ["_mapType", "_width", "_isPedestrian", "_texture", "_textureEnd", "_material", "_begPos", "_endPos", "_isBridge"];
			_dir = [_begPos, _endPos] call BIS_fnc_DirTo;
			_pos = getPosATL _refroad;
			_offSetDirection = if (random 1 > 0.5) then {-1} else {1};
			//_posX = (_pos select 0) + _width * _offSetDirection * sin(_dir);
			_posX = (_pos select 0) + (_width/0.5) * _offSetDirection * cos(_dir);

			_posY = (_pos select 1) + (_width/2) * _offSetDirection * cos(_dir);
			_pos = [_posX, (_pos select 1), 0];
		} else {
			_dir = random 360;
			_pos = _x;
		};
	} else {
		_pos = _x;
		_dir = random 360;
	};
	_obj = switch _rnd do {
		case 0 : {
			"LOP_CHR_Civ_Ural_open"
		};
		case 1 : {
			"LOP_CHR_Civ_Ural"
		};
		case 2 : {
			"LOP_CHR_Civ_Landrover"
		};
		case 3 : {
			"LOP_CHR_Civ_UAZ"
		};
		case 4 : {
			"LOP_CHR_Civ_UAZ_Open"
		};
		case 5 : {
			"Land_WoodenCart_F"
		};
		case 6 : {
			"C_Tractor_01_F"
		};
		case 7 : {
			"Land_GarbageWashingMachine_F"
		};
		case 8 : {
			"C_Van_01_transport_F"
		};
		default {
			"Land_GarbageBags_F"
		};
	};
	_objects pushBack [_pos, _dir, _obj];
} forEach _posarray;


_objects;
