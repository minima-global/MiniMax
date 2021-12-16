import 'package:flutter/services.dart';

class BatteryProvider {
  final MethodChannel _methodChannel;

  BatteryProvider(this._methodChannel);

  Future<bool> ignoreBatteryOptimization() {
    return _methodChannel.invokeMethod<bool>(_ignoreBatteryOptimizationMethodName)
        .then((value) => value!);
  }
}

const _ignoreBatteryOptimizationMethodName = "ignoreBatteryOptimization";
