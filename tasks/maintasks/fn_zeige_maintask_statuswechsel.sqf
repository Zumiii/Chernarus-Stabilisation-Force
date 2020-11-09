private "_gewechselt";

_gewechselt = false;

{
	if ((_this select 0) == (_x select 0)) then {
		if ((_this select 1) != (_x select 1)) exitwith {
			_gewechselt = true;
		};
	};
} foreach zumi_maintasks_lokal;

_gewechselt;
