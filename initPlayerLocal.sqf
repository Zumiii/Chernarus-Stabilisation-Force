
if (!hasInterface) exitWith {};

waituntil {!isnull player};


["InitializePlayer", [player, true]] call BIS_fnc_dynamicGroups;


player setVariable ["ACE_canMoveRallypoint", false];

[
  {(!isNil "server_init_done") && ([player] call CBA_fnc_isAlive)},
  {
    params ["_player","_clientOwner","_PlayerUID","_name", "_insignia"];
    "ladebildschirm" cutText ["ACRE2 is mandatory!", "BLACK FADED", 0, true, false];
    check_in_db = [_player, _clientOwner, _PlayerUID, _name, _insignia];
    publicVariableServer "check_in_db";
    playMusic "nine_lashes_intro";
  },
  [player, clientOwner, getPlayerUID player, name player, "alpha_1_1_private"]
] call CBA_fnc_waitUntilAndExecute;


player createDiaryRecord ["Diary", ["Whitelist", "For a serious gameplay, important roles need to be distributed to able players. Therefor the rights are administered by:<br></br><br></br>1. Zumi from the former FschJgBtl 323<br></br>2. Foremen<br></br><br></br>The following roles can be obtained:<br></br>- Combat first responder A/B/C<br></br>- Pionier 1 and 2<br></br>- EOD<br></br>- Pilot 1 (Helicopter) und 2 (Jets)<br></br>- Tank Crew<br></br>- Foreman<br></br><br></br>The foremen administer the vehicles, commissions and the armory. "]];
player createDiaryRecord ["Diary", ["Welcome", "ITs your first day, rookie? Go to the <marker name='kpfue'>recruitment office</marker>.<br></br>An officer will assign you to a squad and you will be given your proper equipment."]];
player createDiaryRecord ["Diary", ["Rules", "Play the game the way it is supposed to be played. No shenanigans! Do not ruin peoples immersion."]];
player createDiaryRecord ["Diary", ["Prison", "People can be detained in the <marker name='Prison'>prison cell</marker>.<br></br>This feature does nothing yet. It is work in progress."]];
player createDiaryRecord ["Diary", ["Transportation", "Vehicles are provided by the foremen at the <marker name='Parkplatz'>parking lot</marker>.<br></br>Vehicles have to be parked properly and safely after use. Repairs can be done by engineers.<br></br>It is possible for consistent groups to own a vehicle. Speak to the admin for more info."]];
player createDiaryRecord ["Diary", ["Personal gear", "Everyone starts off as a rifleman. The players are self-responsible for their gear. There is no compensation of lost gear. Gear can be commissioned by foremen.</br><br>The equipment has to suit the groups needs. There is no special treatment."]];
player createDiaryRecord ["Diary", ["Persistency", "Mission progress, weather, time, position and personal gear of players, crates and vehicles are being saved continiously every minute.<br></br>After connecting and loading into the map, a player will teleport to his last spot (roundabout).<br></br>The <marker name='safezone'>starting area</marker> is an exception: No players inside that area will be saved to the database."]];
player createDiaryRecord ["Diary", ["Medical", "If necessary, one can heal up in the <marker name='Mash'>medical facility</marker>."]];
player createDiaryRecord ["Diary", ["Issues", "Report them here: https://github.com/Zumiii/Chernarus-Stabilisation-Force"]];
player createDiaryRecord ["Diary", ["Feedback", "Feel free to add Zumi ingame and contact him directly there or via armaworld.de (Zumi)"]];
player createDiaryRecord ["Diary", ["Factions", "<font color='#b30000' size='20'>Enemy forces </font><br></br><img image='\po_main\Data\3den\LOP_ChDKZ_Infantry_Rifleman.jpg' width='256' height='128'/><br></br>Common ChDKZ soldier"]];
player createDiaryRecord ["Diary", ["Factions", "<font color='#4d4dff' size='20'>Allied forces </font><br></br><img image='\po_main\Data\3den\LOP_CDF_Infantry_Rifleman.jpg' width='256' height='128'/><br></br>Common CDF soldier"]];
player createDiaryRecord ["Diary", ["Factions", "<font color='#00b300' size='20'>Independent forces </font><br></br><img image='rhsgref\addons\rhsgref_editorPreviews\data\rhsgref_nat_pmil_rifleman.paa' width='256' height='128'/><br></br>Common NAPA gunman"]];
player createDiaryRecord ["Diary", ["Communications", "The Chat does not replace radios. Stick to the radio protocoll. Squadleaders have to carry a personal longrange-radio (AN/PRC 152). The standard longrange-radio for the radioman the AN/PRC-117."]];
player createDiaryRecord ["Diary", ["Chain of command", "Overlord is in command. His bureau is <marker name='kpfue'>here</marker>. <br></br>Briefings and cooperation is a must!"]];
player createDiaryRecord ["Diary", ["Credits", "Thanks to the developerteams of CBA and ACE.<br></br>I was inspired and adapted code from Commy2 (Sector-Control, general scripting solutions, Tips), Shuko (Task-System), Dorbedo (Artillery, AI-Commanding), only to mention a few.<br></br>Thanks to all friends for testing and participating. Thanks to the BBHC Clan for hosting.<br></br><br></br>The Mission is WIP<br></br><br></br>Zumi"]];
