/*
	Autor: Zumi

	Beschreibung:
	Durchläuft das Sidetask-Array und weist Task lokal zu oder updatet gegebenenfalls den Taskstatus lokal.

*/

//waituntil {alive player};

private "_name";

{
	_name = _x select 0;
	if (_name call zumi_fnc_hatlokalentask) then {
		if ([_name,(_x select 4)] call zumi_fnc_wurdetaskgeupdated) then {
			_x call zumi_fnc_update_sidetask;
		};
	} else {
		_x call zumi_fnc_assign_sidetask;
	};
} foreach _this;


