private "_hat";

_hat = false;

{
	if (_this == (_x select 0)) exitwith {_hat = true};
} foreach zumi_maintasks_lokal;

_hat;
