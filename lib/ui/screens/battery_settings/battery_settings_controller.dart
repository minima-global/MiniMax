import 'package:get/get.dart';
import 'package:minimax/data/dependencies/battery.dart';

class BatterySettingsController extends GetxController {
  final BatteryProvider _batteryProvider;

  BatterySettingsController(this._batteryProvider);

  void onConfirmedClicked() {
    _batteryProvider.ignoreBatteryOptimization(); // Fire and forget
  }
}