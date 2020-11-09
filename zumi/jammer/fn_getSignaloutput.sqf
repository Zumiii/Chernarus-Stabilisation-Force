params ["_transmitterClass"];

private _maxSignal = missionNamespace getVariable [_transmitterClass + "_best_signal", -992];
private _Px = missionNamespace getVariable [_transmitterClass + "_best_px", 0];



private _jammer_signal = missionNamespace getVariable [_transmitterClass + "_jammed_best_signal", 0];
private _jammer_px = missionNamespace getVariable [_transmitterClass + "_jammerbestPxStr", 0];

if (ACRE_SIGNAL_DEBUGGING > 0) then {
    private _signalTrace = missionNamespace getVariable [_transmitterClass + "_signal_trace", []];
    _signalTrace pushBack _maxSignal;
    missionNamespace setVariable [_transmitterClass + "_signal_trace", _signalTrace];
};


//y = 10 ^ x // x = log y
// private _px = (1 - (((log(abs _signal)/log(1.7))-8.6) max 0)) max 0;
//_Px = ((_Px - _jammer_px) min 1) max 0;
private _realRadioRx = [_transmitterClass] call acre_sys_radio_fnc_getRadioBaseClassname;
private _min = getNumber (configFile >> "CfgAcreComponents" >> _realRadioRx >> "sensitivityMin");
private _max = getNumber (configFile >> "CfgAcreComponents" >> _realRadioRx >> "sensitivityMax");
private _Px = (((_maxSignal - _min) / (_max - _min)) max 0.0) min 1.0;
private _Px = ((_Px - _jammer_px) min 1) max 0;

hintSilent parseText format["Px= %1 <br />   Signal= %2 <br />Jammer:<br />   Reduced Px = %3<br />   Signal = %4", _Px, _maxSignal, _jammer_px, _jammer_signal];

[_Px, _maxSignal];
