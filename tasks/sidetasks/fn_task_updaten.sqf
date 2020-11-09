/*
	Autor: Zumi

	Beschreibung:
	Updatet den Sidetask und sendet das an alle Clients

*/

if (!isserver) ExitWith {};

private ["_task","_state"];

_state = (_this select 1);

for "_i" from 0 to (count zumi_sidetasks - 1) do {
	_task =+ (zumi_sidetasks select _i);
	if ((_task select 0) == (_this select 0)) then {
		_task set [4,_state];
	};
	zumi_sidetasks set [_i,_task];
};

publicvariable "zumi_sidetasks";

if (!isdedicated) then {
	zumi_sidetasks call zumi_fnc_sidetask_handler;
};
