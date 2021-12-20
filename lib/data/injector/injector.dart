import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:minimax/data/bridge/channels.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/background_running/background_running_controller.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_controller.dart';
import 'package:minimax/ui/screens/decider/decider_controller.dart';
import 'package:minimax/ui/screens/home/home_controller.dart';
import 'package:minimax/ui/screens/sync_screen/sync_controller.dart';

void inject() {
  /// Controllers
  Get.create(() => DeciderController(Get.find()), permanent: false);
  Get.create(() => HomeController(), permanent: false);
  Get.create(() => BackgroundRunningController(Get.find()), permanent: false);
  Get.create(() => SyncController(), permanent: false);
  Get.create(() => CongratulationsController(Get.find()), permanent: false);

  /// Dependencies
  // Main bridge platform channel
  Get.create(() => mainPlatformChannel, permanent: true);

  // Battery provider
  Get.create(() => BatteryProvider(Get.find()));

  // Storage
  Get.create(() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  Get.create(() => MinimaStorage(Get.find()));
}
