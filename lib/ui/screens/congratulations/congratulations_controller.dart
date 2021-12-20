import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';

class CongratulationsController extends GetxController {
  final MinimaStorage _minimaStorage;

  CongratulationsController(this._minimaStorage);

  void setUserConfiguredDevice() {
    _minimaStorage.setUserConfiguredDeviceFirstTime(true);
  }
}
