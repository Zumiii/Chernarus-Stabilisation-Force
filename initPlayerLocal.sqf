
if (!hasInterface) exitWith {};

waituntil {!isnull player};




player setVariable ["ACE_canMoveRallypoint", false];

[
  {(!isNil "server_init_done") && ([player] call CBA_fnc_isAlive)},
  {
    params ["_player","_clientOwner","_PlayerUID","_name", "_insignia"];
    "ladebildschirm" cutText ["ACRE2 is mandatory!", "BLACK FADED", 0, true, false];
    check_in_db = [_player, _clientOwner, _PlayerUID, _name, _insignia];
    publicVariableServer "check_in_db";
  },
  [player, clientOwner, getPlayerUID player, name player, ""]
] call CBA_fnc_waitUntilAndExecute;


player createDiaryRecord ["Diary", ["Whitelist", "Rechte für das Führen schwerer Fahrzeuge werden zugewiesen von:<br></br><br></br>1.[PzGrenBtl 402] Zumi<br></br>2. Logistiker<br></br><br></br>Folgende Rollen können eingenommen werden:<br></br>- Einsatz-Ersthelfer Bravo / Charlie<br></br>- Pionier 1 und 2<br></br>- EOD<br></br>- Pilot 1 (Helis) und 2 (Jets)<br></br>- Panzerbesatzung<br></br>- Logistiker<br></br><br></br>Logistiker verwalten den Fuhrpark, die Bestellungen und das Arsenal. "]];
player createDiaryRecord ["Diary", ["Willkommen", "Ist dies dein erster Tag hier auf dem Server? Gehe zum <marker name='kpfue'>Rekrutierungszentrum</marker>.<br></br>Ein Verantwortlicher wird dich zeitnahe einweisen."]];
player createDiaryRecord ["Diary", ["Regeln", "Es wird auf Immersion Wert gelegt."]];
player createDiaryRecord ["Diary", ["Gefängnis", "Menschen können gefangen genommen und in die <marker name='Prison'>Gefängniszelle</marker> gebracht werden.<br></br>Dieses Feature ist derzeit noch nicht funktional (work in progress)."]];
player createDiaryRecord ["Diary", ["Transportmittel", "Fahrzeuge werden von Logistikern am <marker name='Parkplatz'>Parkplatz</marker> bereitgestellt.<br></br>Fahrzeuge müssen mit Vorsicht genutzt werden.<br></br>Es ist möglich, als Gruppe Fahrzeuge zu pachten. Frage den Admin für mehr Infos dazu."]];
player createDiaryRecord ["Diary", ["Persönliche Ausrüstung", "Der Spieler startet grundsätzlich als Schütze und ist für die Aufbewahrung seiner Ausrüstung selber verantwortlich.<br></br><br></br>In der <marker name='Armory'>Waffenkammer</marker> kann die Ausrüstung angepasst werden.</br><br></br><br><img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\armor_ca.paa' color='#003311' width='16' height='16'/></br><br></br>Die <marker name='Kpfue'>Standortverwaltung</marker> ist verantwortlich für die Bereitstellung der Ausrüstung.</br><br></br><br><img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\container_ca.paa' color='#cccc00' width='16' height='16'/></br><br></br></br><br>Gruppen haben sich sinnvoll und realitätsnah zusammen auszurüsten."]];
player createDiaryRecord ["Diary", ["Persistenz", "Missionsfortschritt, Wetter, Zeit, Position und Ausrüstung der Spieler sowie Kisten und Fahrzeuge werden jede Minute gespeichert."]];
player createDiaryRecord ["Diary", ["Sanitätsdienst", "Wurdest du verwundet und kein Sanitäter ist präsent? KeinProblem!</br><br></br><br>Im <marker name='Mash'>Lazarett</marker> können Spieler medizinisch behandelt werden.</br><br></br><br><img image='\A3\ui_f\data\igui\cfg\simpleTasks\types\heal_ca.paa' color='#b30000' width='16' height='16'/>"]];
player createDiaryRecord ["Diary", ["Probleme", "Melde Probleme hier: https://github.com/Zumiii/Chernarus-Stabilisation-Force"]];
player createDiaryRecord ["Diary", ["Feedback", "Adde Zumi ingame oder kontaktiere ihn via armaworld.de (User: Zumi)"]];
player createDiaryRecord ["Diary", ["Fraktionen", "<font color='#b30000' size='20'>Feindkräfte </font><br></br><img image='\po_main\Data\3den\LOP_ChDKZ_Infantry_Rifleman.jpg' width='256' height='128'/><br></br>Normaler ChDKZ Soldat"]];
player createDiaryRecord ["Diary", ["Fraktionen", "<font color='#4d4dff' size='20'>Verbündete Kräfte </font><br></br><img image='\po_main\Data\3den\LOP_CDF_Infantry_Rifleman.jpg' width='256' height='128'/><br></br>Normaler CDF Soldat"]];
player createDiaryRecord ["Diary", ["Fraktionen", "<font color='#00b300' size='20'>Unabhängige Kräfte </font><br></br><img image='rhsgref\addons\rhsgref_editorPreviews\data\rhsgref_nat_pmil_rifleman.paa' width='256' height='128'/><br></br>Normaler NAPA Soldat"]];
player createDiaryRecord ["Diary", ["Kommunikation", "Der Chat ist kein Funkersatz. Halte dich ans Funkprotokoll. Gruppenführer müssen ein SEM 70 tragen."]];
player createDiaryRecord ["Diary", ["Befehlskette", "Die Befehlshierarchie entspricht der ORBAT - Zeichnung."]];
player createDiaryRecord ["Diary", ["Credits", "Thanks to the developerteams of CBA and ACE.<br></br>I was inspired and adapted code from Commy2 (Sector-Control, general scripting solutions, Tips), Dorbedo (Artillery, AI-Commanding), only to mention a few.<br></br>Thanks to all friends for testing and participating. Thanks to the BBHC Clan for hosting.<br></br><br></br>The Mission is WIP<br></br><br></br>Zumi"]];
