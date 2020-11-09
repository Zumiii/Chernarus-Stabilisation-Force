if !isserver exitWith {};

private "_task";

for "_i" from 0 to (count zumi_maintasks - 1) do {
	if (_this == ((zumi_maintasks select _i) select 0)) then {
		_task =+ zumi_maintasks select _i;
		_task set [5,"assigned"];
		zumi_maintasks set [_i,_task];
	};
};

publicvariable "zumi_maintasks";

if (!isdedicated && tasks_init) then {
	zumi_maintasks spawn zumi_fnc_verwalte_maintaskevent;
};
