
params ["_player", "_power", "_frequency"];

private _currentJammer = _player getVariable ["zumi_currentJammer", objNull];
private _radio = ([] call acre_api_fnc_getCurrentRadio);
private _maxSignal = missionNamespace getVariable [_radio + "_best_signal", -992];
//missionNamespace setVariable [format ["%_jammerbestPxStr", _radioId], 0];
//missionNamespace setVariable [format ["%1_jammed_best_signal", _radio], _maxSignal, true];

if (isnull _currentJammer) exitWith {
  [_power, _maxSignal];
};

if (_radio isequalTo "") exitWith {
  [_power, _maxSignal];
};

private _channel = [_radio] call acre_api_fnc_getRadioChannel;

if (_channel < 0) exitWith {
  [_power, _maxSignal];
};

private _txData = [_radio, "getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
private _frequenzTX = _txData getVariable ["frequencyTX", 0];
private _rxData = [_radio, "getCurrentChannelData"] call acre_sys_data_fnc_dataEvent;
private _frequenzRX = _txData getVariable ["frequencyRX", 0];


private _frequenz_jammed = false;
{
 if ((_frequenzTX >= (_x select 0)) && (_frequenzTX <= (_x select 1))) then {
   _frequenz_jammed = true;
 };
 if ((_frequenzRX >= (_x select 0)) && (_frequenzRX <= (_x select 1))) then {
   _frequenz_jammed = true;
 };
} count zumi_frequenzen;


if !(_frequenz_jammed) exitWith {
  [_power, _maxSignal];
};

private _distance2d = _player distance2D _currentJammer;

//P0 . . . Sendeleistung
//α . . . Dämpfungsfaktor
//d . . . Entfernung
//PR = P0 − 10 · α · log10(d)

//private _signalNew = _maxSignal - 10 * _faktor * (log _distance2d);

//private _signalNew = (linearConversion [50, 2000, _distance2d, -992, -109.99, true]) max -992;
private _px = linearConversion [50, 2000, _distance2d, 1, 0, true];
//Set the jammer value for that radio
//missionNamespace setVariable [format ["%1_jammed_best_signal", _radio], _signalNew, true];
missionNamespace setVariable [format ["%_jammerbestPxStr", _radioId], _px, true];

//diag_log format ["Returned after jamming: Power: %1 and Signal: %2", _power, _signalNew];

[_power, _signalNew];
