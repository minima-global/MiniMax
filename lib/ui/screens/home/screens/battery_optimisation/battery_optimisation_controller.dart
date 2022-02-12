import 'package:get/get.dart';
import 'package:minimax/data/dependencies/battery.dart';

class BatteryOptimisationController extends GetxController {
  final BatteryProvider _batteryProvider;
  final Rxn<bool> batteryOptimisationPreviouslyAcceptedTrigger = Rxn<bool>();

  BatteryOptimisationController(this._batteryProvider);

  void onTapped() {
    _batteryProvider //
        .isIgnoringBatteryOptimizationMethodName()
        .then((value) => batteryOptimisationPreviouslyAcceptedTrigger.trigger(value));
  }
}
