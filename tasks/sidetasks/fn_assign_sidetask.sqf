/*
	Autor: Zumi

	Beschreibung:
	Erstellt den eigentlichen Sidetask auf dem Client und aktualisiert sein lokales Sidetaskarray "PO3_sidetasks_TasksLocal"

*/
params ["_taskname","_description_kurz","_description_lang","_hud","_taskstate",["_position",[]],["_symbol","move"]];

private ["_subtaskhandle","_handles","_taskname","_taskstate","_parenttask","_hud","_description_kurz","_description_lang","_position","_symbol"];

_handles = [];
{
	for "_i" from 0 to (count ((zumi_maintasks_lokal select (tasknummer-1)) select 2)-1) do {
		_parenttask = ((zumi_maintasks_lokal select (tasknummer-1) select 2) select _i);
		if (_parenttask in (simpletasks _x)) then {
			_subtaskhandle = _x createsimpletask [_taskname,_parenttask];
			_subtaskhandle setsimpletaskdescription [_description_lang,_description_kurz,_hud];
			_subtaskhandle settaskstate _taskstate;
			_subtaskhandle setSimpleTaskType _symbol;
			_handles set [count _handles,_subtaskhandle];
			if (count _position > 0) then {
				_subtaskhandle setsimpletaskdestination _position;
			};
		};
	};

} foreach (if (ismultiplayer) then {playableunits} else {switchableunits});

zumi_sidetasks_lokal set [count zumi_sidetasks_lokal, [_taskname,_taskstate,_handles]];
