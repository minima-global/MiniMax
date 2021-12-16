import 'package:get/get.dart';
import 'package:minimax/ui/screens/background_running/background_running_controller.dart';

void inject() {
  Get.create(() => BackgroundRunningController(), permanent: false);
}
