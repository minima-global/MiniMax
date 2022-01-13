import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/data/dependencies/persistence.dart';

class BatterySettingsController extends GetxController {
  final BatteryProvider _batteryProvider;
  final MinimaStorage _minimaStorage;
  final Rxn<bool> nextTrigger = Rxn<bool>();

  BatterySettingsController(this._batteryProvider, this._minimaStorage);

  void onConfirmedClicked() {
    _batteryProvider.ignoreBatteryOptimization(); // Fire and forget
    _minimaStorage.setUserWantsToKeepRunningTheService(true);
  }
}