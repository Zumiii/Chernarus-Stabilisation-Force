class zumi_fncs {
	tag = "zumi";

	class asymmetric_combattants {
		file = "zumi\sectors\ambiente\asymmetric";
		class combattants;
	};

	class asymmetric_caches {
		file = "zumi\sectors\ambiente\asymmetric\caches";
		class rearm;
	};

	class civilian {
		file = "zumi\sectors\ambiente\civilian";
		class citizens;
	};

	class dynamic {
		file = "zumi\sectors\ambiente\dynamic";
		class dyn_ask_for_orders;
		class dyn_loop;
		class init_dyn;
		class dyn_definiere;
		class dyn_posupdate;
		class dyn_spawn;
		class dyn_wegpunkt;
		class dyn_zusammensetzung;
	};

	class ieds {
		file = "zumi\sectors\ambiente\asymmetric\ieds";
		class assign_cellphone_to_ied;
		class c4_vest;
		class c4_wait;
		class call_ied;
		class carbomb;
		class handle_ied_defused;
		class place_ied;
		class preplaced_ied;
		class sneaky;
		class trigger_vest;
		class village_ied;
		class watch_ied;
		class hit_and_run;
		class loiter;
	};

	class intel {
		file = "zumi\intel";
		class adde_intel;
		class intel_handler;
		class intel_wahl;
		class produziere_intel;
	};

	class villages {
		file = "zumi\sectors\ambiente\villages";
		class decorate;
		class house;
		class housepositions;
		class init_villages;
		class set_decoratives;
		class villages_loop;
		class bonus_malus;
	};

	class gefechtsauftraege {
		file = "tasks\gefechtsauftraege";
		class offiziere;
		class funkwagen;
		class luftabwehr;
		class nehme_stadt;
		class attack;
	};

	class patrols {
		file = "tasks\patrol";
		class patrol;
	};

	class whitelist {
		file = "zumi\whitelist";
		class whitelist_anzeigen;
		class whitelist_updaten;
		class whitelist_wahl;
		class whitelistbuttons_updaten;
	};

	class main {
		file = "zumi\main";
		class reset;
		class rnd_pos;
		class nahe_spieler;
		class nahe_Ki;
		class sichtcheck;
		class fzg_namen;
		class grp_namen;
		class grab_it;
		class neue_posi;
		class spawn_it;
		class reinf_pos;
		class himmelsrichtung;
		class radiale_position;
		class replace_radio;
	};

	class misc {
		file = "zumi\misc";
		class cleanup;
		class interaction_create;
		class show_statistic;
  };

	class fuhrpark {
		file = "zumi\fuhrpark";
		class fuhrpark_gui_anzeigen;
		class fuhrpark_gui_updaten;
		class fuhrpark_spawn;
		class fuhrpark_startspawn;
		class fuhrpark_vehikel_speichern;
		class fuhrpark_info;
	};

	class maintaskframework {
		file = "tasks\maintasks";
		class add_lokal_maintask;
		class add_maintask;
		class aktualisiere_lokalen_maintask;
		class aktualisiere_maintask;
		class hat_lokalen_maintask;
		class maintask_master;
		class maintask_zuweisen;
		class parameter_prozessieren;
		class starte_maintask_sequenz;
		class verwalte_maintaskevent;
		class zeige_maintask_hinweis;
		class zeige_maintask_statuswechsel;
	};

	class sidetaskframework {
		file = "tasks\sidetasks";
		class add_sidetask;
		class sidetask_handler;
		class assign_sidetask;
		class task_updaten;
		class update_sidetask;
		class hatlokalentask;
		class wurdetaskgeupdated;
		class taskcleanup;
	};

	class sector_related_tasks {
		file = "tasks\sector_related";
		class humanitarian;
		class humanitarian_task;
		class ameliorate_conditions;
		class tension;
		class warlord;
		class defending;
	};


	class verteidigung {
		file = "zumi\verteidigung";
		class spawn_camper;
		class spawn_pat;
		class spawn_fzg;
		class spawn_grp;
		class minenfeld;
		class house;
		class sichten_melden;
		class besatzung;
	};

	class aufklaerung {
		file = "zumi\verteidigung\feindbewegung\aufklaerung";
		class meldungen;
	};

	class ausfuehrung {
		file = "zumi\verteidigung\feindbewegung\ausfuehrung";
		class auflauern;
		class besetzen;
		class patrouille;
		class pruefen;
		class addWaypoint;
	};

	class gewichtung {
		file = "zumi\verteidigung\feindbewegung\gewichtung";
		class ziele_gewichten;
		class encounterwahl;
	};

	class kommando {
		file = "zumi\verteidigung\feindbewegung\kommando";
		class kommandant_registrieren;
		class kommandant_handler;
		class befehl_handler;
		class befehl_erfragen;
		class befehl_erhalten;
		class befehl_ausgeben;
	};

	class luftschlag {
		file = "zumi\verteidigung\feindbewegung\luftschlag";
		class luftschlag_ende;
	};

	class surrendering {
		file = "zumi\verteidigung\feindbewegung\misc";
		class abhauen;
		class aufgeben;
	};

	class paradrops {
		file = "zumi\verteidigung\feindbewegung\paradrops";
		class paradrop;
		class airdrop_cleanup;
	};

	class steilfeuer {
		file = "zumi\verteidigung\feindbewegung\steilfeuer";
		class feuer_frei;
		class steilfeuer_handler;
		class rohr_registrieren;
		class steilfeuerbereitschaft;
		class steilfeuerbefehl;
	};

	class verstaerkung {
		file = "zumi\verteidigung\feindbewegung\verstaerkung";
		class verst_loop;
		class verst_spawn;
	};

	class achsenmaechte {
		file = "zumi\verteidigung\achsenmaechte";
		class axis;
		class register_post;
		class setup_defence;
	};

	class waka {
		file = "zumi\waka";
		class waka_aufroedeln;
		class waka_updaten;
		class waka_anzeigen;
  };

	class persistenz {
		file = "zumi\persistenz";
		class speichern;
		class persistent_join;
		class new_join;
	};

	class logistik {
		file = "zumi\logistik";
		class can_build;
		class fortify_spawn;
		class ggst_spawn;
		class logistik_gui_anzeigen;
		class logistik_gui_updaten;
		class eintrag_pruefen;
		class lieferung_bearbeiten;
		class liefereinheiten_updaten;
		class lieferkategorien_anzeigen;
		class zum_warenkorb;
		class bestellung_ausloesen;
		class update_progressbar;
		class deliver_init;
		class deliver;
		class was_built;
	};

	class cooperation {
		file = "zumi\sectors\ambiente\civilian\interaction";
		class freeze;
		class handsup;
		class festgesetzt;
		class moveon;
		class anweisen;
		class gebe_item;
		class informant;
		class kontrollieren;
		class helmcheck;
	};

};
