import 'package:get/get.dart';
import 'package:minimax/data/dependencies/battery.dart';

class BackgroundCheckController extends GetxController {
  final Stream<bool> isIgnoringBatteryOptimization;

  BackgroundCheckController(BatteryProvider _batteryProvider)
      : isIgnoringBatteryOptimization = Stream.periodic(
          const Duration(milliseconds: 200),
          (_) async {
            return await _batteryProvider.isIgnoringBatteryOptimizationMethodName();
          },
        )
      .asyncMap((event) async => await event);
}
