/*
	Autor: Zumi

	Beschreibung:
	Updatet den Sidetask f�r den Client

*/

private ["_task","_name","_state","_handle","_marker"];

for "_i" from 0 to (count zumi_sidetasks_lokal - 1) do {
	_task =+ zumi_sidetasks_lokal select _i;
	_name = _task select 0;
	if (_name == (_this select 0)) then {
		_state = _this select 4;
		_task set [1,_state];
		zumi_sidetasks_lokal set [_i,_task];
		{
			_handle = _x;
			{
				if (_handle in (simpletasks _x)) then {
					_handle settaskstate _state;

					if (_x == player) then {
						if (tasks_zeige_hinweise) then {[_handle,_state] call zumi_fnc_zeige_maintask_hinweis;};
					};
				};
			} foreach (if ismultiplayer then {playableunits} else {switchableunits});
		} foreach (_task select 2);
	};
};
