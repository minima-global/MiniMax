import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:minimax/data/bridge/channels.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/data/dependencies/network_manager.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/news_repository.dart';
import 'package:minimax/data/services/news_service.dart';
import 'package:minimax/ui/screens/background_running/background_running_controller.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_controller.dart';
import 'package:minimax/ui/screens/decider/decider_controller.dart';
import 'package:minimax/ui/screens/home/home_controller.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/news_feed_controller.dart';
import 'package:minimax/ui/screens/sync_screen/sync_controller.dart';
import 'package:package_info/package_info.dart';

Future inject() async {
  /// Controllers
  Get.create(() => DeciderController(Get.find()), permanent: false);
  Get.create(() => HomeController(Get.find()), permanent: false);
  Get.create(() => BackgroundRunningController(Get.find()), permanent: false);
  Get.create(() => SyncController(), permanent: false);
  Get.create(() => CongratulationsController(Get.find()), permanent: false);
  Get.create(() => NewsFeedController(Get.find()), permanent: true);

  /// Services and repositories
  Get.create<NewsService>(() => NewsServiceImpl(Get.find()));
  Get.create<NewsRepository>(() => NewsRepositoryImpl(Get.find()));

  /// Dependencies
  // Main bridge platform channel
  Get.create(() => mainPlatformChannel, permanent: true);

  // Battery provider
  Get.create(() => BatteryProvider(Get.find()));

  // Storage
  Get.create(() => const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true)));
  Get.create(() => MinimaStorage(Get.find()));

  // Packages
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Get.create(() => packageInfo, permanent: false);

  // Dio
  Get.create(() => DioClient());
}
