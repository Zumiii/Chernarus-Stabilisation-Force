/*

	Dokumentation:
	Dieses Skript erfasst eine vorgefertigte Objektkomposition im Umkreis von X Metern und übersetzt sie in ein verschachteltes Array. Dieses wird in die Zwischenablage gespeichert.
	Das Array kann anschliessend in eine Konfigurationsdatei kopiert und verwendet werden, um die Komposition an gewünschtem Ort zu platzieren.

	Parameter:
	0: Ausgangsposition (MARKER, OBJECT, LOCATION, GROUP, TASK or POSITION)
	1: Radius erfasster Objekte (Default ist ein 15 Meter Radius)

	Ausgabe:
	String: Array (Text in Ablage)
	[
		[], //Objekte
		[], //Fahrzeuge und Geschütze
		[], //Einheiten gewöhnlich
		[], //Objekte Spezial
		[],	//Einheiten Spezial
		[]	//Minen
	]
	[getPos player, 15] execVM "fn_grab_it.sqf";
*/

params ["_position", ["_rad",15]];

private _posi = _position call CBA_fnc_getPos;

private ["_objs","_objs_def", "_mines"];

//Objekte
_objs = nearestObjects [_posi, ["All"], _rad];

//Minen
_mines = _posi nearobjects ["minebase" , _rad];

//Formatierzeug
private ["_br", "_tab"];
_br = toString [13, 10];
_tab = toString [9];


_output = [
	[

	], //Objekte
	[

	], //Fahrzeuge und Geschütze
	[

	], //Einheiten gewöhnlich
	[

	], //Objekte Spezial
	[

	]	//Minen
];

//Sortiere Spieler aus...
_objs_def = [];
{
	if !(isplayer _x) then {
		_objs_def pushBack _x;
	};
} forEach _objs;

//Objekte prozessieren
{
	private ["_center","_type", "_pos", "_dX", "_dY", "_dZ","_unitpos","_outputArray"];
	_type = typeOf _x;
	_pos = getPosATL _x;
	_center = boundingCenter _x;
	_dX = (_pos select 0) - (_posi select 0) - (_center select 0);
	_dY = (_pos select 1) - (_posi select 1) - (_center select 1);
	_dZ = _pos select 2;
	_pitch_bank_yaw = [_x] call ace_common_fnc_getPitchBankYaw;
	_outputArray = [_type, [_dX, _dY, _dZ], _pitch_bank_yaw select 0, _pitch_bank_yaw select 1, _pitch_bank_yaw select 2];
	_added = false;
	if (_type isKindOf "CAManbase") then {
		_outputArray pushBack (unitPos _x);
		(_output select 2) pushBack _outputArray;
		_added = true;
	};
	if (((_type isKindOf "Car") || (_type isKindOf "Tank") || (_type isKindOf "staticWeapon")) && (!_added)) then {
		(_output select 1) pushBack _outputArray;
	} else {
		if (!_added) then {
			(_output select 0) pushBack _outputArray;
		};
	};
} forEach _objs_def;

{
	private ["_center","_type", "_pos", "_dX", "_dY", "_dZ","_unitpos","_outputArray"];
	_type = typeOf _x;
	_pos = getPosATL _x;
	_center = boundingCenter _x;
	_dX = (_pos select 0) - (_posi select 0) - (_center select 0);
	_dY = (_pos select 1) - (_posi select 1) - (_center select 1);
	_dZ = _pos select 2;
	_pitch_bank_yaw = [_x] call ace_common_fnc_getPitchBankYaw;
	_unitpos = if (_x isKindOf "CAManbase") then {unitPos _x} else {""};
	_outputArray = [_type, [_dX, _dY, _dZ], _pitch_bank_yaw select 0, _pitch_bank_yaw select 1, _pitch_bank_yaw select 2, _unitpos];
	(_output select 4) pushBack _outputArray;
} forEach _mines;
//_outputText = _outputText + _tab + "],";

//Text ausspucken

copyToClipboard str _output;

_output
