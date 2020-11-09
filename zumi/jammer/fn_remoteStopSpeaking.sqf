params ["_speakingId","_netId"];

_speakingId = parseNumber _speakingId;
private _unit = objectFromNetId _netId;
if (!isNil "_unit") then {
    private _radioId = _unit getVariable ["acre_sys_core_currentSpeakingRadio", ""];
    if (_radioId != "") then {
        if (_unit in acre_sys_core_keyedMicRadios) then {
            missionNamespace setVariable [format ["%1_jammed_best_signal", _radioId], 0];
            missionNamespace setVariable [format ["%_jammerbestPxStr", _radioId], 0];
        };
    };
};
