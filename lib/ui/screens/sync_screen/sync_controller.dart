import 'package:get/get.dart';
import 'package:minimax/ui/screens/sync_screen/sync_state_model.dart';

class SyncController extends GetxController {
  final Rx<SyncStateModel> state = Rx(SyncStateModel.syncing);

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 3))
        .then((_) => state(SyncStateModel.greetingReceived))
        .then((_) => Future.delayed(const Duration(seconds: 1)))
        .then((_) => state(SyncStateModel.readyToLaunch));
  }
}
