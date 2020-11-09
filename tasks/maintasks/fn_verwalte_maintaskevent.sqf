
private "_name";

{
	_name = _x select 0;
	if (_name call zumi_fnc_hat_lokalen_maintask) then {
		if ([_name,(_x select 5)] call zumi_fnc_zeige_maintask_statuswechsel) then {
			_x call zumi_fnc_aktualisiere_lokalen_maintask;
		};
	} else {
		_x call zumi_fnc_add_lokal_maintask;
	};
} foreach _this;
