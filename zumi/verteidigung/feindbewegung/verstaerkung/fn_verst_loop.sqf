/*

  Kurzbeschrieb:
  Loop für die Feindverstärkung.
	Das Skript regelt die mögliche Feindverstärkung in Bezug auf Stärke, Menge und Zeitraum

*/

if !isServer exitWith {};

params [
	"_taskpos", //Wohin soll die Verstärkung entsendet werden
	["_fraktion", "axis"], //Welche Fraktion?
	["_zeitrahmen", [cba_missiontime, cba_missiontime + 18000]], //Zeitrahmen der Spawns [Beginn, Ende]
	["_guthaben", 50], //Wieviele Angriffspunkte hat er
	["_kampfkraft", 3], //Wie stark ist der Feind momentan (Stufen 1 - 5)?
	["_mannstaerke", 100], //Mannstärke der Kampftruppen des Feindes
  ["_threshold", 0.5], //Was ist die Schmerzgrenze kämpffähiger Teile fürs einschreiten? 0 = 0%, 1 = 100%
	"_task", //taskname, der gefunden werden soll.
	["_wait", 120], //Wie lange bis zur nächsten Abfrage
	["_cooldowns", []] //Können bestimmte Verstärkungen nicht ausgelöst werden? Vor Allem für Flügler und Artillerie gebraucht
];

_zeitrahmen params ["_beginn", "_ende"];


//Aktualisiere Kampfkraft
_kampfkraft = ceil linearConversion [0, 22, (spielerfaktor call BIS_fnc_arithmeticMean), 1, 5];

_barracks = zumi_stellungen select {((alive (_x select 0)) && ((_x select 3) isEqualTo "some barracks"))};
_tank_depots = zumi_stellungen select {((alive (_x select 0)) && ((_x select 3) isEqualTo "a tank service depot"))};
_air_depots = zumi_stellungen select {((alive (_x select 0)) && ((_x select 3) isEqualTo "an air service depot"))};
_mot_depots = zumi_stellungen select {((alive (_x select 0)) && ((_x select 3) isEqualTo "a vehicle supply depot"))};


/*

	Ist die Aufgabe vorbei, braucht der Feind nicht weiter anzusetzen

*/

if (_task call BIS_fnc_taskCompleted) exitwith {};


/*

	Prüfe, ob noch innerhalb des Zeitrahmens

*/

//Wenn Verstärkungszeitrahmen überschritten, verlasse Skriptloop
if (cba_missiontime >= (_zeitrahmen select 1)) exitWith {};

/*

	Ist zuviel KI insgesamt unterwegs (>= 250), warte 30s und probiere erneut, um Überlastung zu vermeiden.

*/


if (({alive _x} count (allUnits select {!isplayer _x})) >= 250) exitWith {
	//Starte Loop erneut in n Sekunden
	[
	  {
	    params ["_taskpos","_fraktion","_zeitrahmen","_guthaben","_kampfkraft","_mannstaerke","_threshold","_task","_wait", "_cooldowns"];
			[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns] call zumi_fnc_verst_loop;
	  },
		[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns],
	  30
	] call CBA_fnc_waitAndExecute;
};

//Aktualisiere lebende Teile des Feindes
for "_i" from 0 to (count zumi_truppenteile) - 1 do {
	if (count (zumi_truppenteile select _i) > 0) then {
		_grps = [];
		{
			if (count (_x call CBA_fnc_getAlive) > 0) then {
				_grps pushBack _x;
			};
		} forEach (zumi_truppenteile select _i);
  	zumi_truppenteile set [_i, _grps];

	};
};

//Elemente (Arrays) in dem Array enthalten:
zumi_truppenteile params ["_spaeher","_stiefel","_motorisierte","_mechanisierte","_befestigte","_panzer","_luftabwehr","_bomber","_starrfluegler","_funker"];

/*

  Der Feind kann ohne lebendigen Funker in der Nähe keine Verstärkung rufen.
	Führe daher erneut den Loop aus nach n Sekunden.

*/

if ({alive _x} count zumi_kommandeure < 1) exitWith {
	//Starte Loop erneut in 30 Sekunden
	[
	  {
	    params ["_taskpos","_fraktion","_zeitrahmen","_guthaben","_kampfkraft","_mannstaerke","_threshold","_task","_wait", "_cooldowns"];
			[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns] call zumi_fnc_verst_loop;
	  },
		[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns],
	  30
	] call CBA_fnc_waitAndExecute;
};

/*

  Wird überhaupt schon Verstärkung benötigt?
	Hat der Feind überhaupt noch Reserven?

*/

//Dazu prüfe Grenze fürs Einschreiten: Wenn nicht genügend Verluste erlitten, versuche erneut in 30s
_mannstaerke_temp = 0;

//Aktualisiere lebende Teile des Feindes
{
	if (count (_x call CBA_fnc_getAlive) > 0) then {
		_mannstaerke_temp = _mannstaerke_temp + (count (_x call CBA_fnc_getAlive));
	};
} forEach zumi_soldaten;



if (_mannstaerke_temp > (_threshold * _mannstaerke)) exitWith {
	//Starte Loop erneut in 30 Sekunden
	[
	  {
	    params ["_taskpos","_fraktion","_zeitrahmen","_guthaben","_kampfkraft","_mannstaerke","_threshold","_task","_wait", "_cooldowns"];
			[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns] call zumi_fnc_verst_loop;
	  },
		[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns],
	  30
	] call CBA_fnc_waitAndExecute;
};

/*

	Errechne Durchschnittsbedrohung aller gesichteten Ziele gegenüber Infanterie, Fahrzeugen und Flugobjekten

*/

//Dazu schaue wieviele und vor allem was davon aufgeklärt innerhalb von 3.5 KM
//Erfasse spieler
_spieler = count ([] call cba_fnc_players);
_spieler_gesichtet = [_taskpos, 3500] call zumi_fnc_meldungen;
_spieler_gesichtet params ["_zufuss","_cars","_apcs","_tanks","_helis","_flugzeuge"];

//Durchschnittswertearry erstellen
_durchschnittswerte = [];
//Erzeuge 6x einen Durchschnittswert an Bedrohung für alle drei Kategorien
{
	//Bedrohung durch Inf, Fahrzeuge, Luft
	_inf = 0;
	_veh = 0;
	_luft = 0;
	if (count _x > 0) then {
	  for "_i" from 0 to (count _x) - 1 do {
			//Nicht alle Bedrohungen wiegen gleich schwer. Ein Panzer ist immer noch gefährlicher als ein AT Soldat. Die KI schaut hier nicht auf den Threat.
			_koeffizienten = switch _i do {
				case 0 : {[1, 0.75, 0.75]};
				case 1 : {[1, 1, 0.75]};
				case 2 : {[1, 1, 1]};
				case 3 : {[1, 1, 1]};
				case 4 : {[0.75, 1, 1]};
				case 5 : {[0.75, 1, 1]};
			};
			//lese Bedrohungswert aus der Config aus
	    _threat =  [configFile >> "CfgVehicles" >> (TypeOf (_x select _i)) >> "threat", "ARRAY", [0.5,0,0]] call CBA_fnc_getConfigEntry;
			_threat params ["_threat_inf","_threat_fzg","_threat_luft"];
			_inf = _inf + (_koeffizienten select 0) * _threat_inf;
			_veh = _veh + (_koeffizienten select 1) * _threat_fzg;
			_luft = _luft + (_koeffizienten select 2) * _threat_luft;
	  };
		_bedrohungslevels = [_inf/6, _veh/6, _luft/6];
	} else {
		_bedrohungslevels = [0, 0, 0];
	};
	_durchschnittswerte set [_forEachIndex, _bedrohungslevels];
} forEach [_zufuss, _cars, _apcs, _tanks, _helis, _flugzeuge];
//Diese Durchschnittswerte werden nun addiert und ergeben einen Gesamtschnitt
_gefahr_fuer_inf = 0;
_gefahr_fuer_fzg = 0;
_gefahr_fuer_flgzg = 0;
{
	_x params ["_threat_inf","_threat_fzg","_threat_luft"];
	_gefahr_fuer_inf = _gefahr_fuer_inf + _threat_inf;
	_gefahr_fuer_fzg = _gefahr_fuer_fzg + _threat_fzg;
	_gefahr_fuer_flgzg = _gefahr_fuer_flgzg + _threat_luft;
} forEach _durchschnittswerte;
//Der dadurch errechnete Durchschnitt ist dann der definitive Wert zwischen 0 und 1 und dient als weitere Berechnungsgrundlage
_bedrohungswerte = [_gefahr_fuer_inf / 6, _gefahr_fuer_fzg / 6, _gefahr_fuer_flgzg / 6];

/*

	Einige Dinge sind aus Gründen der Logik und des Balancings zu beachten:

*/

/*

	Prozessiere Cooldowns: Aktualisiere

*/

if ((count _cooldowns) > 0) then {
	_tempcooldowns = [];
	for "_i" from 0 to (count _cooldowns) - 1 do {
		if (cba_missiontime < ((_cooldowns select _i) select 1)) then {
			_tempcooldowns pushBack (_cooldowns select _i);
		};
	};
	_cooldowns = _tempcooldowns;
};

/*

	Definiere Basischancen (Abhängig von der Kampfkraft des Feindes --> Faktor 1 - 5)

*/

_basischancen = switch _kampfkraft do {
	case 1 : {
		[
			0.25,//Späher (0)
			1,//Trupp zu Fuss (1)
			0.2,//AT - Trupp motorisiert (2)
			0,//AA - Trupp (3)
			1,//Motorisierter Trupp (4)
			0.1,//Mechanisierter Trupp (5)
			0.05,//Panzer (6)
			0.1,//Fallschirmjäger (7)
			0,//ZSU 23 / ZU 23 (8)
			0,//Drehflügler (9)
			0,//Starrflügler (10)
			0,//Artillerie (mobil) (11)
			0//Funkwagen (mobil) (12)
		]
	};
	case 2 : {
		[
			0.25,
			1,
			0.25,
			0,
			0.75,
			0.15,
			0.1,
			0.15,
			0,
			0,
			0,
			0,
			0
		]
	};
	case 3 : {
		[
			0.25,
			1,
			0.3,
			0.1,
			0.75,
			0.25,
			0.2,
			0,
			0.15,
			0,
			0,
			0.05,
			0.15
		]
	};
	case 4 : {
		[
			0.25,
			0.75,
			0.3,
			0.2,
			0.75,
			0.3,
			0.3,
			0.1,
			0.2,
			0.1,
			0,
			0.15,
			0.2
		]
	};
	case 5 : {
		[
			0.25,
			0.75,
			0.4,
			0.3,
			1,
			0.5,
			0.3,
			0.2,
			0.25,
			0.2,
			0.1,
			0.2,
			0.3
		]
	};
};

/*

		Rechenbeispiel als Versuch / Test:

		25 Spieler sind am Spielen
		20 davon sind augeklärt im Zielgebiet
		5 davon sitzen in einem Wiesel [1,1,0.8] / Spz [1,1,0.8]
		2 in einem Auto [1,0.4,0.1]
		13 abgesessen [1,0.5,0.1]

		Das ergäbe eine mit den koeffizientenverrechnete Durchschnittsbedrohung von:
		[1, 0.7775, 0.27875]
		Es geht also zwar mittlere Gefahr für Lufteinheiten von Blufor aus, aber hohe Gefahr für Fahrzeuge
		--> Weitere Modifikatoren unten
*/

_bedrohungswerte params ["_inf_gefahr", "_fzg_gefahr", "_lfzg_gefahr"];
//Vordefinierte Encounter in der hpp
_encounter = verstaerkungsarten;
for "_i" from 0 to (count _basischancen) - 1 do {
	(_basischancen select _i) params ["_basischance"];
	//Modifiziere Basischancen
	private _koeff_start = 1;
	//(1) Spielerzahlfaktor, der Wahrscheinlichkeiten erhöht

	_spielerzahlfaktor = switch (true) do {
		case (_spieler <= 6) : {1};
		case (_spieler <= 12) : {1.1};
		case (_spieler <= 18) : {1.2};
		case (_spieler <= 24) : {1.3};
		case (_spieler <= 30) : {1.4};
		case (_spieler > 30) : {1.5};
	};
	//Koeffizient für den Encounter modifizieren wegen Spielerzahl
	_koeff = switch _i do {
		case 0 : {
			_koeff_start;
		};
		case 1 : {
			_koeff_start;
		};
		case 2 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 3 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 4 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 5 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 6 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 7 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 8 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 9 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 10 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 11 : {
			_koeff_start * _spielerzahlfaktor;
		};
		case 12 : {
			_koeff_start;
		};
	};
	_chance_temp = _koeff * _basischance;

	//(2) Wenn Bedrohung für Fahrzeuge bzw. Luft besonders hoch ist und die Chance auf SPz und Pz klein, erhöhe diese
	switch _i do {
		case 5 : {
			//Wenn die Luftbedrohung hoch ist und Chance niedrig, erhöhe Chance auf SPz
			//ev. linearConversion nutzen
			if (_lfzg_gefahr >= 0.25 && _chance_temp < 0.3) then {
				_chance_temp = (_chance_temp * 1.1);
			};
		};
		case 6 : {
			//Wenn Fahrzeugbedrohung hoch ist und Chance niedrig, erhöhe Chance auf Pz, vorausgesetzt die Luftbedrohung ist nicht zu hoch
			if (_fzg_gefahr >= 0.5 && _chance_temp < 0.25 && _lfzg_gefahr < 0.25) then {
				_chance_temp = (_chance_temp * 1.1);
			};
		};
		case 8 : {
			//Wenn die Luftbedrohung und Fahrzeugbedrohung hoch sind, aber die Chance niedrig ist, erhöhe Chance auf mobile Luftabwehr
			if (_fzg_gefahr >= 0.4 && _chance_temp < 0.25 && _lfzg_gefahr >= 0.3) then {
				_chance_temp = (_chance_temp * 1.1);
			};
		};
		case 9 : {
			//Wenn die Luftbedrohung hoch ist und Chance niedrig, erhöhe Chance auf Drehflügler
			if (_lfzg_gefahr >= 0.35 && _chance_temp < 0.25) then {
				_chance_temp = (_chance_temp * 1.1);
			};
		};
		case 10 : {
			//Wenn die Luftbedrohung hoch ist und Chance niedrig, erhöhe Chance auf Starrflügler
			if (_lfzg_gefahr >= 0.35 && _chance_temp < 0.25) then {
				_chance_temp = (_chance_temp * 1.1);
			};
		};
		default {};
	};

	//(3) Funkmobile können nicht spawnen, wenn noch > 1 Funkgerät heile || Restart 45 min bevorsteht
	if (_i == 12) then {
		if (({alive _x} count zumi_funknetz > 1) || (cba_missiontime >= 18900)) then {
			_chance_temp = 0;
		};
	};

	//(4) Fusstruppen (1 und 3) spawnen nicht, wenn Restart bevorsteht (cirka 45 min)
	switch _i do {
		case 1 : {
			if (cba_missiontime >= 18900) then {
				_chance_temp = 0;
			};
		};
		case 3 : {
			if (cba_missiontime >= 18900) then {
				_chance_temp = 0;
			};
		};
		default {};
	};
	//(5) Schwere Kräfte werden nicht entsendet, wenn schon genügend davon vorhanden
	//(6) Luftabwehr limitieren auf 2
	switch _i do {
		case 6 : {
			if ((count _mechanisierte) >= 3) then {
				_chance_temp = 0;
			};
		};
		case 6 : {
			if ((count _panzer) >= 3) then {
				_chance_temp = 0;
			};
		};
		case 8 : {
			if ((count _luftabwehr) >= 2) then {
				_chance_temp = 0;
			};
		};
		case 9 : {
			if ((count _bomber) >= 1) then {
				_chance_temp = 0;
			};
		};
		case 10 : {
			if ((count _starrfluegler) >= 1) then {
				_chance_temp = 0;
			};
		};
		default {};
	};

	//(7) Gibt es einen Cooldown auf diesen Encounter?
	for "_j" from 0 to (count _cooldowns) - 1 do {
		if (((_cooldowns select _j) select 0) isEqualTo (((_encounter) select _i) select 0)) then {
			_chance_temp = 0;
		};
	};

	//(8) Prüfe, wie es um die Kampfkraft des Feindes steht. Was kann er überhaupt noch einsetzen?
	for "_j" from 0 to (count _encounter) - 1 do {
		if (_guthaben - ((_encounter select _j) select 3) < 0) then {
			_chance_temp = 0;
		};
	};
	//Aktualisiere nun die neuen Spawnchancen zischen 0 und 1
	(_encounter select _i) set [1, (_chance_temp min 1)];
};

/*

  Ist kein Spawn mehr möglich, weil alle zu teuer, verlasse den Loop

*/

if (({(_x select 3) > 0} count _encounter) < 1) exitWith {};


/*

  Wähle die Verstärkungsart gewichtet zufällig aus

*/

_wahl_array = [];
for "_i" from 0 to count (_encounter) - 1 do {
	if (((_encounter select _i) select 1) > 0) then {
		_wahl_array pushBack (_encounter select _i);
		_wahl_array pushBack ((_encounter select _i) select 1);
	};
};

private _wahl = selectRandomWeighted _wahl_array;
_wahl_array deleteat (_wahl_array find _wahl);
_Wahl params ["_art", "_prob", "_cd", "_pkt"];

//Ziehe Guthaben ab
_guthaben = _guthaben - _pkt;

//Füge Cooldown hinzu, falls vorhanden
if (_cd > 0) then {
	_cooldowns pushBack [_art, cba_missiontime + _cd];
};

/*

  Ändere die Eingriffsschwelle:
	Der Feind setzt gegen Ende der Phase tendenziell früher an. Je länger das Gefecht, umso besser will er also mobilisieren

*/

_threshold = linearConversion [_beginn, _ende, cba_missiontime - (cba_missiontime - _beginn), 0.5, 0.75, true];

/*

  Spawne die Verstärkung

*/

//return der spawns: Zur _mannstaerke_temp zu addierende Einheiten
_return = [_taskpos, _fraktion, _art] call zumi_fnc_verst_spawn;
_mannstaerke_temp = _mannstaerke_temp + _return;

/*

  Führe Loop erneut aus in n Sekunden (Abhängig davon, was gespawnt wurde)

*/

_wait = (linearConversion [1, 10, _pkt, 1, 5, true]) * 60;

/*

  Prüfe random Chance für einen zweiten Spawn (Chance steigend bei stärkerem Feind)
	Wenn vh, warte ein wenig länger für nächsten Loop und verlasse Skript vorzeitig

*/

if ((floor random 5) <= (linearConversion [1,4,_kampfkraft,1,5, true])) exitWith {
	private _wahl = selectRandomWeighted _wahl_array;
	_Wahl params ["_art", "_prob", "_cd", "_pkt"];
	if (_guthaben - _pkt >= 0) then {
		_return = [_taskpos, _fraktion, _art] call zumi_fnc_verst_spawn;
		if (_cd > 0) then {
			_cooldowns pushBack [_art, cba_missiontime + _cd];
		};
		_guthaben = _guthaben - _pkt;
		_mannstaerke_temp = _mannstaerke_temp + _return;
	};
	//Setze Mannsträrke neu
	_mannstaerke = _mannstaerke_temp;
	 //Führe Loop erneut aus in n Sekunden
	[
		{
			params ["_taskpos","_fraktion","_zeitrahmen","_guthaben","_kampfkraft","_mannstaerke","_threshold","_task","_wait", "_cooldowns", "_pkt"];
			[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns] call zumi_fnc_verst_loop;
		},
		[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns, _pkt],
		(_wait + ceil (linearConversion [1,10,_pkt,0,5, true]) * 60)
	] call CBA_fnc_waitAndExecute;
};

//Setze Mannsträrke neu
_mannstaerke = _mannstaerke_temp;

[
	{
		params ["_taskpos","_fraktion","_zeitrahmen","_guthaben","_kampfkraft","_mannstaerke","_threshold","_task","_wait", "_cooldowns"];
		[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns] call zumi_fnc_verst_loop;
	},
	[_taskpos, _fraktion, _zeitrahmen, _guthaben, _kampfkraft, _mannstaerke, _threshold, _task, _wait, _cooldowns],
	_wait
] call CBA_fnc_waitAndExecute;
