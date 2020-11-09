  class frequency_allocation {
    id = 1;
    idType = 0;
    type = "Infantry";
    size = "Division";
    side = "west";
    tags[] = {"frequency_allocation"};
    description = "Troop overview and radio frequency allocation";
    text = "4th Cavalry Division";
    textShort = "4th Cavalry Division";
		texture = __EVAL(MISSIONLOCATION + "pics\4cav.paa");
		color[] = {1,1,1,1};
    insignia = "\idi\acre\addons\ace_interact\data\icons\antenna.paa";
    //colorinsignia[] = {1,1,1,1};
		class company {
			type = "HQ";
			text = "Chief in Command";
			tags[] = {"company"};
			textShort = "Overlord";
			size = "Company";
			side = "west";
	    class infantry_net {
	      id = 1;
	      idType = 0;
	      type = "Infantry";
	      size = "Platoon";
	      side = "west";
	      tags[] = {"infantry_net"};
	      description = "The platoon standard radio is the AN/PRC-117F";
	      text = "30 MHz";
	      textShort = "Alpha";
				insignia = "\idi\acre\addons\sys_prc117f\Data\PRC117F_ico.paa";

				class squad_net_alpha_one {
					id = 1;
					idType = 0;
					type = "Infantry";
					size = "Squad";
					side = "west";
					tags[] = {"squad_net_alpha_one"};
					description = "The squad standard radio is the AN/PRC-152";
					textShort = "Alpha 1";
					text = "Channel 1";
					insignia = "\idi\acre\addons\sys_prc152\Data\PRC152c_ico.paa";

					class squad_net_alpha_one_1 {
						id = 1;
						idType = 0;
						type = "Infantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_1"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 1-1";
						text = "Block 1, Channels 1-8";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_one_2 {
						id = 2;
						idType = 0;
						type = "Infantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_2"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 1-2";
						text = "Block 1, Channels 9-16";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_one_3 {
						id = 3;
						idType = 0;
						type = "Infantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_3"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 1-3";
						text = "Block 2, Channels 1-8";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_one_4 {
						id = 4;
						idType = 0;
						type = "Recon";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_one_4"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 1-4";
						text = "Block 2, Channels 9-16";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

				};

				class squad_net_alpha_two {
					id = 1;
					idType = 0;
					type = "MechanizedInfantry";
					size = "Squad";
					side = "west";
					tags[] = {"squad_net_alpha_two"};
					description = "The squad standard radio is the AN/PRC-152";
					textShort = "Alpha 2";
					text = "Channel 2";
					insignia = "\idi\acre\addons\sys_prc152\Data\PRC152c_ico.paa";

					class squad_net_alpha_two_1 {
						id = 1;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_1"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 2-1";
						text = "Block 3, Channels 1-8";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_two_2 {
						id = 2;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_2"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 2-2";
						text = "Block 3, Channels 9-16";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_two_3 {
						id = 3;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_3"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 2-3";
						text = "Block 4, Channels 1-8";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_two_4 {
						id = 4;
						idType = 0;
						type = "MechanizedInfantry";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_two_4"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 2-4";
						text = "Block 4, Channels 9-16";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

				};

				class squad_net_alpha_three {
					id = 1;
					idType = 0;
					type = "Support";
					size = "Squad";
					side = "west";
					tags[] = {"squad_net_alpha_two"};
					description = "The squad standard radio is the AN/PRC-152";
					textShort = "Alpha 3";
					text = "Channel 3";
					insignia = "\idi\acre\addons\sys_prc152\Data\PRC152c_ico.paa";

					class squad_net_alpha_three_1 {
						id = 1;
						idType = 0;
						type = "Medical";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_1"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 3-1";
						text = "Block 5, Channels 1-8";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
            commander = "F3u3rvogel";
            commanderRank = "Sergeant";
					};

					class squad_net_alpha_three_2 {
						id = 2;
						idType = 0;
						type = "Maintenance";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_2"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 3-2";
						text = "Block 5, Channels 9-16";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_three_3 {
						id = 3;
						idType = 0;
						type = "Service";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_3"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 3-3";
						text = "Block 6, Channels 1-8";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
					};

					class squad_net_alpha_three_4 {
						id = 4;
						idType = 0;
						type = "Artillery";
						size = "fireteam";
						side = "west";
						tags[] = {"squad_net_alpha_three_4"};
						description = "The fireteam standard radio is the AN/PRC-343";
						textShort = "Alpha 3-4";
						text = "Block 6, Channels 9-16";
						insignia = "\idi\acre\addons\sys_prc343\Data\static\prc343_icon.paa";
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
	      description = "The platoon standard radio is the AN/PRC-117F";
	      text = "32/33 MHz";
	      textShort = "Bravo";
				insignia = "\idi\acre\addons\sys_prc117f\Data\PRC117F_ico.paa";

				class air_net_helicopter {
					id = 1;
		      idType = 0;
		      type = "Helicopter";
		      size = "Squad";
		      side = "west";
		      tags[] = {"air_net_helicopter"};
		      description = "The platoon standard radio is the AN/PRC-117F";
		      text = "32 MHz";
		      textShort = "Bravo 1";
					insignia = "\idi\acre\addons\sys_prc117f\Data\PRC117F_ico.paa";

					class air_net_helicopter_bravo_one_1 {
						id = 1;
						idType = 0;
						type = "AviationSupport";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_helicopter_bravo_one_1"};
						insignia = "\rhsusf\addons\rhsusf_a2port_air\data\mapico\Icon_ch47f_CA.paa";
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
						insignia = "\rhsusf\addons\rhsusf_a2port_air\data\mapico\Icon_uh60m_CA.paa";
					};

					class air_net_helicopter_bravo_one_3 {
						id = 3;
						idType = 0;
						type = "CombatAviation";
						size = "fireteam";
						side = "west";
						tags[] = {"air_net_helicopter_bravo_one_3"};
						insignia = "\rhsusf\addons\rhsusf_a2port_air\data\mapico\Icon_ah64d_CA.paa";
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
		      description = "The platoon standard radio is the AN/PRC-117F";
		      text = "33 MHz";
		      textShort = "Bravo 2";
					insignia = "\idi\acre\addons\sys_prc117f\Data\PRC117F_ico.paa";

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
	      description = "The platoon standard radio is the AN/PRC-117F";
	      text = "31 MHz";
	      textShort = "Charlie";
				insignia = "\idi\acre\addons\sys_prc117f\Data\PRC117F_ico.paa";
				class tank_net_charlie_one {
					id = 1;
					idType = 0;
					type = "Armored";
					size = "fireteam";
					side = "west";
					tags[] = {"tank_net_charlie_one"};
					textShort = "Charlie 1";
					text = "M1A1 TUSK";
					insignia = "\rhsusf\addons\rhsusf_m1a1\icons\M1A1AIMTUSKI.paa";
					assets[] = {
						rhsusf_m1a1aim_tuski_d
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
					text = "M1A1 TUSK";
					insignia = "\rhsusf\addons\rhsusf_m1a1\icons\M1A1AIMTUSKI.paa";
					assets[] = {
						rhsusf_m1a1aim_tuski_d
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
					text = "M1A2 TUSK";
					insignia = "\rhsusf\addons\rhsusf_m1a1\icons\M1A1AIMTUSKI.paa";
					assets[] = {
						rhsusf_m1a2sep1tuskiid_usarmy
					};
				};

				class tank_net_charlie_four {
					id = 4;
					idType = 0;
					type = "Armored";
					size = "fireteam";
					side = "west";
					tags[] = {"tank_net_charlie_four"};
					textShort = "Charlie 4";
					text = "M1A2 TUSK";
					insignia = "\rhsusf\addons\rhsusf_m1a1\icons\M1A1AIMTUSKI.paa";
					assets[] = {
						rhsusf_m1a2sep1tuskiid_usarmy
					};
				};

	    };

		};

  };
