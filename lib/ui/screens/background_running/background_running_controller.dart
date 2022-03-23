import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/background_running/enum/background_running_state_model.dart';

class BackgroundRunningWarningController extends GetxController {
  final MinimaStorage _minimaStorage;

  final Rx<BackgroundRunningState> state = Rx(BackgroundRunningState.confirm);
  final Rxn nextTrigger = Rxn();
  final Rxn backTrigger = Rxn();

  BackgroundRunningWarningController(this._minimaStorage);

  void noTapped() {
    backTrigger.trigger(null);
  }

  void yesTapped() {
    switch (state.value) {
      case BackgroundRunningState.confirm:
        state(BackgroundRunningState.doubleConfirm);
        break;
      case BackgroundRunningState.doubleConfirm:
        _next();
        break;
    }
  }

  void _next() {
    nextTrigger.trigger(null);
    _minimaStorage.setUserWantsToKeepRunningTheService(false);

    Future.delayed(const Duration(seconds: 1)).then((_) => state(BackgroundRunningState.confirm));
  }
}