params [
  ["_name", "Platzhalter"],
  ["_kurz", "Platzhalter"],
  ["_lang", "Platzhalter"],
  ["_seite", [west, civilian, east, resistance]],
  ["_marker", []],
  ["_status", "created"],
  ["_pos", [0,0,0]],
  ["_kurzhinweis", ""],
  ["_symbol", ""]
];

private ["_handle","_handles","_name","_status","_seite","_marker","_pos","_chev","_subtask","_symbol"];

_handles = [];
{
	if ((side _x) in _seite) then {
		_handle = _x createsimpletask [_name];
		_handle setsimpletaskdescription [_lang,_kurz,_kurzhinweis];
		_handle settaskstate _status;
		if (_status in ["assigned"]) then {
			_x setcurrenttask _handle;
		};
    if (count _pos > 0) then {
      		_handle setsimpletaskDestination _pos;
    };
    _handle setSimpleTaskType _symbol;
    _handles set [count _handles,_handle];
		if (_x == player) then {
			if (tasks_zeige_hinweise) then {
        [_handle,_status] call zumi_fnc_zeige_maintask_hinweis;
      };
			if !(_marker isequalto []) then {
				if !(_status in ["succeeded","failed","canceled"]) then {
					private ["_m","_t","_c","_txt"];
					{
            _x params [
              ["_markername","unique_markername"],
              ["_markerpos",_pos],
              ["_tmp_mrk_typ",""],
              ["_tmp_mrk_color",""],
              ["_markertext","Einsatzziel"],
              ["_markersize",1]
            ];
						_m = createmarkerlocal [_markername,_markerpos];
						_m setmarkershapelocal "ICON";
						_t = "hd_objective";
						if (_tmp_mrk_typ != "") then {
							_t = _tmp_mrk_typ;
						};
						_m setmarkertypelocal _t;
						_c = "ColorRed";
						if (_tmp_mrk_color != "") then {
							_c = _tmp_mrk_color;
						};
						_m setmarkercolorlocal _c;
						_m setmarkertextlocal format[" %1",_markertext];
						_m setMarkerSizeLocal _markersize;
					} foreach _marker;
				};
			};
		};
	};
} foreach (if ismultiplayer then {playableunits} else {switchableunits});



zumi_maintasks_lokal set [count zumi_maintasks_lokal, [_name,_status,_handles]];
