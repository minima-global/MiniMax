import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/decider/model/decider_model.dart';
import 'package:package_info/package_info.dart';

class DeciderController extends GetxController {
  final Rxn<DeciderModel> decider = Rxn();
  final RxString version;

  final MinimaStorage _minimaStorage;

  final Duration introShowDuration = const Duration(milliseconds: 1500);
  final Duration delayAfterPresented = const Duration(milliseconds: 1000);

  DeciderController(this._minimaStorage, PackageInfo _packageInfo)
      : version = RxString("v${_packageInfo.version}") {

    Future.delayed(Duration(milliseconds: introShowDuration.inMilliseconds + delayAfterPresented.inMilliseconds))
        .then((_) => _onAfterPresented());
  }

  void _onAfterPresented() {
    _minimaStorage.getUserConfiguredDeviceFirstTime() //
        .then((configured) {
      switch (configured) {
        case true:
          return decider(DeciderModel.goMain);
        case false:
          return decider(DeciderModel.setUp);
      }
    });
  }
}
