if !(isServer) exitWith {};

private ["_auftrag"];


params ["_task","_status"];

for "_i" from 0 to (count zumi_maintasks - 1) do {
	_auftrag =+ (zumi_maintasks select _i);
	if ((_auftrag select 0) == _task) then {
		_auftrag set [5,_status];
	};
	zumi_maintasks set [_i,_auftrag];
};

if (count _this > 2) then {
	switch (typename (_this select 2)) do {
		case (typename ""): { (_this select 2) call zumi_fnc_maintask_zuweisen; };
		case (typename []): { (_this select 2) spawn { sleep 1; _this call zumi_fnc_add_maintask;} };
	};
};

publicvariable "zumi_maintasks";

if (!isdedicated && tasks_init) then {
	zumi_maintasks spawn zumi_fnc_verwalte_maintaskevent;
};
