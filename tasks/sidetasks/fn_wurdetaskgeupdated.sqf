/*
	Autor: Zumi

	Beschreibung:
	Pr�ft, ob ein Task vom Client geupdatet wurde

*/

private "_b";

_b = false;

{
	if ((_this select 0) == (_x select 0)) then {
		if ((_this select 1) != (_x select 1)) exitwith {
			_b = true;
		};
	};
} foreach zumi_sidetasks_lokal;

_b;
