  class frequency_allocation {
    id = 1;
    idType = 0;
    type = "Infantry";
    size = "Army";
    side = "west";
    tags[] = {"frequency_allocation"};
    description = "Friedenserziwngender Einsatz unter Führung eines internationalen Kontignentes zum Schutze der zivilen Bevölkerung von Chernarus";
    text = "CFOR";
    textShort = "Mission";
    insignia = __EVAL(MISSIONLOCATION + "pics\cfor.paa");
    texture = __EVAL(MISSIONLOCATION + "pics\cfor.paa");
    color[] = {1,1,1,1};
    commander = "Hawthorn";
    commanderRank = "General";
    //colorinsignia[] = {1,1,1,1};
		class company {
			type = "HQ";
			text = "Kommando";
			tags[] = {"company"};
			textShort = "Overlord";
			size = "Division";
			side = "west";
      description = "Befehlshabender Offizier";
      commander = "Williamson";
      commanderRank = "Major";

	    class infantry_net {
	      id = 1;
	      idType = 0;
	      type = "Infantry";
	      size = "Platoon";
	      side = "west";
	      tags[] = {"infantry_net"};
	      description = "Das standardmässige Zugfunkgerät ist die SEM-70";
	      text = "30 MHz";
	      textShort = "Alpha";
				insignia = "\idi\acre\addons\sys_sem70\data\ui\SEM70_icon.paa";
        commander = "Karrenbauer";
        commanderRank = "Captain";
        class mp {
          id = 1;
          idType = 0;
          type = "Unknown";
          size = "Troop";
          side = "west";
          tags[] = {"mp"};
          description = "Das Adminteam";
          text = "Server-Administration";
          textShort = "MP";
          insignia = __EVAL(MISSIONLOCATION + "pics\mp.paa");
          texture = __EVAL(MISSIONLOCATION + "pics\mp.paa");
          color[] = {1,1,1,1};
          commander = "Zumi";
          commanderRank = "Sergeant";
        };
        class keiler {
					id = 1;
					idType = 0;
					type = "Infantry";
					size = "Squad";
					side = "west";
					tags[] = {"keiler"};
					description = "https://www.twitch.tv/horkmaster92";
					textShort = "Keiler";
					text = "AN/PRC-152 on Channel 1";
					insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
          texture = __EVAL(MISSIONLOCATION + "pics\keiler.paa");
          color[] = {1,1,1,1};
          commander = "Horkmaster";
          commanderRank = "Sergeant";
        };

        class squad_net_alpha_one {
					id = 1;
					idType = 0;
					type = "Infantry";
					size = "Squad";
					side = "west";
					tags[] = {"squad_net_alpha_one"};
					description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
					textShort = "Alpha 1";
					text = "46 MHz";
					insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
          texture = __EVAL(MISSIONLOCATION + "pics\banner92.paa");
          color[] = {1,1,1,1};
          commander = "Von Bergen";
          commanderRank = "Lieutenant";
					class squad_net_alpha_one_1 {
						id = 1;
						idType = 0;
						type = "Infantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_1"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 1-1";
						text = "47 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
            texture = __EVAL(MISSIONLOCATION + "pics\banner92.paa");
            color[] = {1,1,1,1};
					};

					class squad_net_alpha_one_2 {
						id = 2;
						idType = 0;
						type = "Infantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_2"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 1-2";
						text = "48 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
            texture = __EVAL(MISSIONLOCATION + "pics\banner92.paa");
            color[] = {1,1,1,1};
					};

					class squad_net_alpha_one_3 {
						id = 3;
						idType = 0;
						type = "Infantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_3"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 1-3";
						text = "49 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
            texture = __EVAL(MISSIONLOCATION + "pics\banner92.paa");
            color[] = {1,1,1,1};
					};

				};

				class squad_net_alpha_two {
					id = 1;
					idType = 0;
					type = "MechanizedInfantry";
					size = "Squad";
					side = "west";
					tags[] = {"squad_net_alpha_two"};
					description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
					textShort = "Alpha 2";
					text = "50 MHz";
					insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
          commander = "Mishkar";
          commanderRank = "Lieutenant";
          texture = __EVAL(MISSIONLOCATION + "pics\PzGrenBtl402_Logo.paa");
          color[] = {1,1,1,1};
          assets[] = {
            Redd_Marder_1A5_Flecktarn
          };
					class squad_net_alpha_two_1 {
						id = 1;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_1"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 2-1";
						text = "51 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
            texture = __EVAL(MISSIONLOCATION + "pics\PzGrenBtl402_Logo.paa");
            color[] = {1,1,1,1};
            assets[] = {
              Redd_Marder_1A5_Flecktarn
            };

					};

					class squad_net_alpha_two_2 {
						id = 2;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_2"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 2-2";
						text = "52 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
            texture = __EVAL(MISSIONLOCATION + "pics\PzGrenBtl402_Logo.paa");
            color[] = {1,1,1,1};
            assets[] = {
              Redd_Marder_1A5_Flecktarn
            };

					};

					class squad_net_alpha_two_3 {
						id = 3;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_3"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 2-3";
						text = "53 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
            texture = __EVAL(MISSIONLOCATION + "pics\PzGrenBtl402_Logo.paa");
            color[] = {1,1,1,1};
            assets[] = {
              Redd_Marder_1A5_Flecktarn
            };

					};

				};

				class squad_net_alpha_three {
					id = 1;
					idType = 0;
					type = "Support";
					size = "Squad";
					side = "west";
					tags[] = {"squad_net_alpha_two"};
					description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
					textShort = "Alpha 3";
					text = "54 MHz";
					insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
          commander = "Birkenmeier";
          commanderRank = "Lieutenant";
					class squad_net_alpha_three_1 {
						id = 1;
						idType = 0;
						type = "Medical";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_1"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 3-1";
						text = "55 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
					};

					class squad_net_alpha_three_2 {
						id = 2;
						idType = 0;
						type = "Maintenance";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_2"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 3-2";
						text = "56 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
					};

					class squad_net_alpha_three_3 {
						id = 3;
						idType = 0;
						type = "Service";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_3"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 3-3";
						text = "57 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
					};

					class squad_net_alpha_three_4 {
						id = 4;
						idType = 0;
						type = "Artillery";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_4"};
						description = "Das standardmässige Gruppenfunkgerät ist die SEM-52 SL";
						textShort = "Alpha 3-4";
						text = "58 MHz";
						insignia = "\idi\acre\addons\sys_sem52sl\data\ui\SEM52sl_icon.paa";
					};

				};

			};

			class air_net {
	      id = 1;
	      idType = 0;
	      type = "Support";
	      size = "Platoon";
	      side = "west";
	      tags[] = {"air_net"};
	      description = "Das standardmässige Zugfunkgerät ist die SEM-70";
	      text = "32/33 MHz";
	      textShort = "Bravo";
				insignia = "\idi\acre\addons\sys_sem70\data\ui\SEM70_icon.paa";
        commander = "Malinowksy";
        commanderRank = "Captain";
				class air_net_helicopter {
					id = 1;
		      idType = 0;
		      type = "Helicopter";
		      size = "Squad";
		      side = "west";
		      tags[] = {"air_net_helicopter"};
		      description = "Das standardmässige Zugfunkgerät ist die SEM-70";
		      text = "32 MHz";
		      textShort = "Bravo 1";
					insignia = "\idi\acre\addons\sys_sem70\data\ui\SEM70_icon.paa";

					class air_net_helicopter_bravo_one_1 {
						id = 1;
						idType = 0;
						type = "AviationSupport";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_helicopter_bravo_one_1"};
						insignia = "\rhsusf\addons\rhsusf_ch53\data\ui\ch53_icon_ca.paa";
						text = "Aviation Support";
						textShort = "Bravo 1-1";
					};

					class air_net_helicopter_bravo_one_2 {
						id = 2;
						idType = 0;
						type = "Helicopter";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_helicopter_bravo_one_2"};
						textShort = "Bravo 1-2";
						text = "Cavalry";
						insignia = "\rhsusf\addons\rhsusf_a2port_air2\data\mapico\Icon_UH1Y_CA.paa";
					};

					class air_net_helicopter_bravo_one_3 {
						id = 3;
						idType = 0;
						type = "CombatAviation";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_helicopter_bravo_one_3"};
						insignia = "\rhsusf\addons\rhsusf_a2port_air2\data\mapico\icomap_ah1z_ca.paa";
						textShort = "Bravo 1-3";
						text = "Cavalry";
					};

				};

				class air_net_jet {
					id = 1;
		      idType = 0;
		      type = "CombatAviation";
		      size = "Squad";
		      side = "west";
		      tags[] = {"air_net_jet"};
		      description = "Das standardmässige Zugfunkgerät ist die SEM-70";
		      text = "33 MHz";
		      textShort = "Bravo 2";
					insignia = "\idi\acre\addons\sys_sem70\data\ui\SEM70_icon.paa";

					class air_net_jet_bravo_two_1 {
						id = 1;
						idType = 0;
						type = "Fighter";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_jet_bravo_two_1"};
						textShort = "Bravo 2-1";
						text = "Combat Aviation";
						insignia = "\rhsusf\addons\rhsusf_a2port_air\data\mapico\icon_a10_ca.paa";
					};

					class air_net_jet_bravo_two_2 {
						id = 2;
						idType = 0;
						type = "Fighter";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_jet_bravo_two_2"};
						textShort = "Bravo 2-2";
						text = "Combat Aviation";
						insignia = "\rhsusf\addons\rhsusf_f22\data\f22_icon.paa";
					};

				};

	    };

			class tank_net {
	      id = 1;
	      idType = 0;
	      type = "Armored";
	      size = "Platoon";
	      side = "west";
	      tags[] = {"tank_net"};
	      description = "Das standardmässige Zugfunkgerät ist die SEM-70";
	      text = "31 MHz";
	      textShort = "Charlie";
				insignia = "\idi\acre\addons\sys_sem70\data\ui\SEM70_icon.paa";
        commander = "Gutknecht";
        commanderRank = "Captain";
        assets[] = {
          BWA3_Leopard2_Fleck
        };
				class tank_net_charlie_one {
					id = 1;
					idType = 0;
					type = "Armored";
					size = "fireteam";
					side = "west";
					tags[] = {"tank_net_charlie_one"};
					textShort = "Charlie 1";
					text = "31 MHz";
					assets[] = {
						BWA3_Leopard2_Fleck
					};
				};

				class tank_net_charlie_two {
					id = 2;
					idType = 0;
					type = "Armored";
					size = "fireteam";
					side = "west";
					tags[] = {"tank_net_charlie_two"};
					textShort = "Charlie 2";
					text = "31 MHz";
					assets[] = {
						BWA3_Leopard2_Fleck
					};
				};

				class tank_net_charlie_three {
					id = 3;
					idType = 0;
					type = "Armored";
					size = "fireteam";
					side = "west";
					tags[] = {"tank_net_charlie_three"};
					textShort = "Charlie 3";
					text = "31 MHz";
					assets[] = {
						BWA3_Leopard2_Fleck
					};
				};


	    };

		};

  };
