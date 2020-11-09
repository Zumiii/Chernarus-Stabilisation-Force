/*
	Autor: Zumi

	Beschreibung:
	Pr�ft ob Client den Task hat und ob der Status davon ge�ndert wurde

*/

private "_b";

_b = false;

{
	if (_this == (_x select 0)) exitwith { _b = true };
} foreach zumi_sidetasks_lokal;

_b;
