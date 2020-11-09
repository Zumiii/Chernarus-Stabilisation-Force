
params ["_args", "_result"];
_args params ["_transmitterClass", "_receiverClass"];

if !(_result isEqualTo []) then {
    _result params ["_id", "_signal"];

    private _bestSignalStr = format ["%1_best_signal", _transmitterClass];
    private _bestAntStr = format ["%1_best_ant", _transmitterClass];
    private _jammedSignalStr = format ["%1_jammed_best_signal", _transmitterClass];
    private _maxSignal = missionNamespace getVariable [_bestSignalStr , -992];
    private _jammedmaxSignal = missionNamespace getVariable [_jammedSignalStr , -992];
    private _currentAntenna = missionNamespace getVariable [_bestAntStr, ""];
    private _jammerbestPxStr = format ["%_jammerbestPxStr", _transmitterClass];
    if ((_id == _currentAntenna) || {(_id != _currentAntenna) && {_signal > _maxSignal}}) then {
        missionNamespace setVariable [_bestSignalStr, _signal];
        missionNamespace setVariable [_bestAntStr, _id];

        private _bestPxStr = format ["%1_best_px", _transmitterClass];
        if (_maxSignal >= -500) then {
            private _realRadioRx = [_receiverClass] call acre_sys_radio_fnc_getRadioBaseClassname;
            private _min = getNumber (configFile >> "CfgAcreComponents" >> _realRadioRx >> "sensitivityMin");
            private _max = getNumber (configFile >> "CfgAcreComponents" >> _realRadioRx >> "sensitivityMax");

            private _Px = (((_jammedmaxSignal - _min) / (_max - _min)) max 0.0) min 1.0;

            missionNamespace setVariable [_bestPxStr, _Px];
            missionNamespace setVariable [_jammerbestPxStr, _Px, true];
        } else {

            missionNamespace setVariable [_bestPxStr, 0];
            missionNamespace setVariable [_jammerbestPxStr, 0, true];
        };
        if (count _result > 3) then {
            ACRE_DEBUG_SIGNAL_FILE = _result select 3;
        };
    };
};
private _runningCountStr = format ["%1_running_count", _transmitterClass];
private _count = missionNamespace getVariable [_runningCountStr, 0];
missionNamespace setVariable [_runningCountStr, _count - 1];
