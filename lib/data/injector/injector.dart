import 'package:get/get.dart';
import 'package:minimax/data/bridge/channels.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/ui/screens/background_running/background_running_controller.dart';
import 'package:minimax/ui/screens/sync_screen/sync_controller.dart';

void inject() {
  /// Controllers
  Get.create(() => BackgroundRunningController(Get.find()), permanent: false);
  Get.create(() => SyncController(), permanent: false);

  /// Dependencies
  // Main bridge platform channel
  Get.create(() => mainPlatformChannel, permanent: true);

  // Battery provider
  Get.create(() => BatteryProvider(Get.find()));
}
