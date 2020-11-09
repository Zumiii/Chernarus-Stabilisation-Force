
params ["_f", "_mW", "_receiverClass", "_transmitterClass"];

private _count = (missionNamespace getVariable [_transmitterClass + "_running_count", 0]) max 0;

private _signal_and_px = [acre_player, _mW, _f] call zumi_fnc_calculate_power;
_signal_and_px params [ "_pXnew", "_signalNew"];

if (_count == 0) then {

	private _rxAntennas = [_receiverClass] call acre_sys_components_fnc_findAntenna;
	private _txAntennas = [_transmitterClass] call acre_sys_components_fnc_findAntenna;
	//diag_log format ["New Power after Jamming: %1 RX Antennas: %2 TX Antennas: %3", _mWnew, _rxAntennas, _txAntennas];
	{
		private _txAntenna = _x;
		{
			private _rxAntenna = _x;
			_count = _count + 1;
			private _id = format ["%1_%2_%3_%4", _transmitterClass, (_txAntenna select 0), _receiverClass, (_rxAntenna select 0)];
			//Calculate new Signal

			[
				"process_signal",
				[
					_id,
					(_txAntenna select 2),
					(_txAntenna select 3),
					(_txAntenna select 0),
					(_rxAntenna select 2),
					(_rxAntenna select 3),
					(_rxAntenna select 0),
					_f,
					_mW, //Signalstärke
					acre_sys_signal_terrainScaling,
					diag_tickTime,
					ACRE_SIGNAL_DEBUGGING,
					acre_sys_signal_omnidirectionalRadios
				],
				true,
				zumi_fnc_handleSignalReturn,
				[_transmitterClass, _receiverClass]
			] call acre_sys_core_fnc_callExt;
		} forEach _rxAntennas;
	} forEach _txAntennas;
	missionNamespace setVariable [_transmitterClass + "_running_count", _count];
};

//private _maxSignal = missionNamespace getVariable [_transmitterClass + "_best_signal", -992];
//private _Px = missionNamespace getVariable [_transmitterClass + "_best_px", 0];


if (ACRE_SIGNAL_DEBUGGING > 0) then {
	private _signalTrace = missionNamespace getVariable [_transmitterClass + "_signal_trace", []];
	_signalTrace pushBack _signalNew; //_maxSignal
	missionNamespace setVariable [_transmitterClass + "_signal_trace", _signalTrace];
};

[_transmitterClass] call zumi_fnc_getSignalOutput;
//[_Px, _maxSignal];
