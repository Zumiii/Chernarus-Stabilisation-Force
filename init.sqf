/*

	Generelle Initialisierung

*/



if (!isDedicated && hasInterface) then {
	zumi_sidetasks_lokal = [];
	waituntil {!isnil "zumi_sidetasks"};
	private "_sh";
	_sh = zumi_sidetasks spawn zumi_fnc_sidetask_handler;
	waituntil {scriptdone _sh};
	"zumi_sidetasks" addPublicVariableEventHandler {(_this select 1) call zumi_fnc_sidetask_handler;};
};

independent setFriend [west, 0];
independent setFriend [civilian, 1];
independent setFriend [east, 0];
west setFriend [independent, 0];
west setFriend [civilian, 1];
west setFriend [east, 0];
civilian setFriend [independent, 1];
civilian setFriend [east, 1];
civilian setFriend [west, 1];
east setFriend [independent, 0];
east setFriend [civilian, 1];
east setFriend [west, 0];

enableTeamSwitch false;
enableSentences false;
enableRadio false;
enableSaving [false, false];


[[leinwand], [leinwand], ["CUP\Terrains\cup_terrains_worlds\pictureMap\chernarus_ca.paa"], [1], 0, "Sat-Map"] call ace_slideshow_fnc_createSlideshow;


0 enableChannel true;
1 enableChannel false;
2 enableChannel false;
3 enableChannel false;
4 enableChannel false;
5 enableChannel false;


enableDynamicSimulationSystem true;
"Group" setDynamicSimulationDistance 2000;
"Vehicle" setDynamicSimulationDistance 2500;
"EmptyVehicle" setDynamicSimulationDistance 1500;
"Prop" setDynamicSimulationDistance 1500;
"IsMoving" setDynamicSimulationDistanceCoef 1.5;
