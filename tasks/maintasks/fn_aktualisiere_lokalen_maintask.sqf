
params [
  ["_name","Platzhalter"],
  ["_kurz","Platzhalter"],
  ["_lang","Platzhalter"],
  ["_seite",[west,civilian]],
  ["_marker",[]],
  ["_status","created"],
  ["_pos",[0,0,0]],
  ["_kurzhinweis",""],
  ["_symbol",""]
];

private ["_task","_taskname","_state","_handle","_marker"];

for "_i" from 0 to (count zumi_maintasks_lokal - 1) do {
	_task =+ zumi_maintasks_lokal select _i;
	_taskname = _task select 0;
	if (_taskname == _name) then {
		_task set [1,_status];
		zumi_maintasks_lokal set [_i,_task];
		{
			_handle = _x;
			{
				if (_handle in (simpletasks _x)) then {
					_handle settaskstate _status;

					if (_x == player) then {
						if (tasks_zeige_hinweise) then {
              [_handle,_status] call zumi_fnc_zeige_maintask_hinweis;
            };
						if (count _marker > 0) then {
							if (_status in ["succeeded","failed","canceled"]) then {
								{
									deletemarkerlocal (_x select 0);
								} foreach _marker;
							};
						};
					};
				};
			} foreach (if ismultiplayer then {playableunits} else {switchableunits});
		} foreach (_task select 2);
	};
};
