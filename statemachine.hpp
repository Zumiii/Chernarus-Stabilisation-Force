
/*
also :
_players = [] call cba_fnc_players;
{
    _pcount = {_x distanced2d _sector <= 1000} count _players;
_x setVariable ["players_in_sector", _pcount];
} forEach _sectors;

*/

class Sector_Statemachine {
    //Do only process active Sectors to save ressources
    list = "commy_sectors select {_x getVariable ['players_in_sector', 0] > 0}";
    skipNull = 1;

    //Sector is being triggered
    class Initial {
        onState = "";
        onStateEntered = "";
        onStateLeaving = "";
        //Only possible state yet: Triggering
        class Triggering {
            targetState = "Spawn_Objects";
            //Sector needs >0 players inside
            //events[] = {"zumi_trigger_sector"};
            condition = "_this getVariable ['players_in_sector', 0] > 0";
            onTransition = "";
        };
    };
    //Sector is being triggered, Objects spawn
    class Spawn_Objects {
        onState = "";
        //Spawn Objects and set the Variable
        onStateEntered = "private _obj = [_this] call zumi_fnc_spawn_obj; _this setVariable ['objects', _obj];";
        onStateLeaving = "";
        //Possible target state: Cleanup
        class despawn {
            targetState = "Cleanup";
            //Transition for Cleanup: Triggered when no more players are in a sector
            condition = "_this getVariable ['players_in_sector', 0] < 1";
            //events[] = {"zumi_sector_despawn"};
            onTransition = "";
        };
        //Possible target state: Spawn groups
        class triggered {
          targetState = "Spawn_Groups";
          //Sector objects must be spawned
          condition = "count (_this getVariable ['objects', []]) > 0";
          //events[] = {"zumi_triggered_sector"};
          onTransition = "";
        };
    };
    //Sector has been triggered, Groups spawn
    class Spawn_Groups {
        onState = "";
        //Spawn Objects and set the Variable
        onStateEntered = "private _grps = [_this] call zumi_fnc_spawn_grps; _this setVariable ['groups', _grps];";
        onStateLeaving = "";
        //Possible target state: Cleanup
        class despawn {
            targetState = "Cleanup";
            //Transition for Cleanup: Triggered when no more players are in a sector
            condition = "_this getVariable ['players_in_sector', 0] < 1";
            //events[] = {"zumi_sector_despawn"};
            onTransition = "";
        };
        //Possible target state: Spawn Combattants
        class Combattants {
            targetState = "Spawn_Combattants";
            //events[] = {};
            //Transition for Cleanup: Triggered when no more players are in a sector
            condition = "count (_this getVariable ['groups', []]) > 0";
            onTransition = "";
        };

    };
    //Sector has been triggered, Combattants spawn
    class Spawn_Combattants {
        onState = "";
        //Spawn Objects and set the Variable
        onStateEntered = "private _combattants = [_this] call zumi_fnc_combattants; _this setVariable ['groups', _combattants];";
        onStateLeaving = "";
        //Possible target state: Cleanup
        class despawn {
            targetState = "Cleanup";
            //events[] = {"zumi_sector_despawn"};
            //Transition for Cleanup: Triggered when no more players are in a sector
            condition = "_this getVariable ['players_in_sector', 0] < 1";

            onTransition = "";
        };
        class ieds_spawn {
          targetState = "Spawn_Ieds";
          //events[] = {"zumi_activated_sector"};
          //Sector groups must be spawned
          condition = "((_this getVariable ['securityparams', [100, 100, true]]) select 2) && (count (_this getVariable ['groups', []]) > 0)";

          onTransition = "";
        };

        //Possible target state: fully spawned
        class fullyspawned {
          targetState = "Active";
          //events[] = {"zumi_activated_sector"};
          //Sector groups must be spawned
          condition = "!((_this getVariable ['securityparams', [100, 100, true]]) select 2) && (count (_this getVariable ['groups', []]) > 0)";

          onTransition = "";
        };

    };
    //Sector has been triggered, IEDS may spawn
    class Spawn_Ieds {
        onState = "";
        //Spawn Objects and set the Variable
        onStateEntered = "private _grps = _this getVariable ['groups', []]; private _triggermen = [_this] call zumi_fnc_village_ied; _this setVariable ['groups', _grps + _triggermen];";
        onStateLeaving = "";
        //Possible target state: Cleanup
        class despawn {
            targetState = "Cleanup";
            //events[] = {"zumi_sector_despawn"};
            //Transition for Cleanup: Triggered when no more players are in a sector
            condition = "_this getVariable ['players_in_sector', 0] < 1";
            onTransition = "";
        };
        //Possible target state: fully spawned
        class ied_spawned {
          targetState = "Active";
          //events[] = {"zumi_activated_sector"};
          //Sector groups must be spawned
          condition = "count (_this getVariable ['groups', []]) > 0";
          onTransition = "";
        };

    };
    //Sector has been triggered and is now fully active
    class Active {
        onState = "";
        onStateEntered = "";
        //onStateLeaving = "_this setVariable ['active', false];";
        onStateLeaving = "";
        //Only Possible target state: Cleanup
        class despawn {
            targetState = "Cleanup";
            //events[] = {"zumi_sector_despawn"};
            //Transition for Cleanup: Triggered when no more players are in a sector
            condition = "_this getVariable ['players_in_sector', 0] < 1";

            onTransition = "";
        };
    };
    //Sector is being mopped up
    class Cleanup {
        onState = "";
        //Mopp up Groups and Objects
        onStateEntered = "[_this getVariable ['objects', []], _this getVariable ['groups', []]] call cba_fnc_deleteEntity;";
        //Resett variables, flag inactive
        onStateLeaving = "_this setVariable ['objects', []]; _this setVariable ['groups', []];";
        //Only possible Transition: Reset to initial state
        class Reset {
            //events[] = {"zumi_sector_reset"};
            //Reset to inital State, when Sector is inactive
            targetState = "Initial";
            condition = "!(_this getVariable ['actve', false])";
            onTransition = "";
        };
    };

};
