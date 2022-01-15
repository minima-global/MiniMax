import 'package:get/get.dart';
import 'package:minimax/data/dependencies/battery.dart';

class BackgroundCheckController extends GetxController {
  final BatteryProvider _batteryProvider;

  final Stream<bool> isIgnoringBatteryOptimization;

  BackgroundCheckController(this._batteryProvider)
      : isIgnoringBatteryOptimization = Stream.periodic(
          const Duration(milliseconds: 200),
          (_) async {
            var bool = await _batteryProvider.isIgnoringBatteryOptimizationMethodName();
            print(bool);
            return bool;
          },
        )
      .asyncMap((event) async => await event);

  void showModal() {
    _batteryProvider.ignoreBatteryOptimization();
  }
}
