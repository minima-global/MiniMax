import 'package:flutter/services.dart';

class BatteryProvider {
  final MethodChannel _methodChannel;

  BatteryProvider(this._methodChannel);

  Future<bool> ignoreBatteryOptimization() {
    return _methodChannel.invokeMethod<bool>(_ignoreBatteryOptimizationMethodName)
        .then((value) => value!);
  }

  Future<bool> isIgnoringBatteryOptimizationMethodName() {
    return _methodChannel.invokeMethod<bool>(_isIgnoringBatteryOptimizationMethodName)
        .then((value) => value!);
  }
}

const _ignoreBatteryOptimizationMethodName = "ignoreBatteryOptimization";
const _isIgnoringBatteryOptimizationMethodName = "isIgnoringBatteryOptimization";
