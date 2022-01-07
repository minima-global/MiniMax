import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/ui/screens/background_running/enum/background_running_state_model.dart';

class BackgroundRunningController extends GetxController {
  final BackgroundService _backgroundService;
  final MinimaStorage _minimaStorage;

  final Rx<BackgroundRunningState> state = Rx(BackgroundRunningState.fresh);
  final Rxn<bool> nextTrigger = Rxn<bool>();

  BackgroundRunningController(this._backgroundService, this._minimaStorage);

  void noTapped() {
    switch (state.value) {
      case BackgroundRunningState.fresh:
        state(BackgroundRunningState.confirm);
        break;
      case BackgroundRunningState.confirm:
      case BackgroundRunningState.doubleConfirm:
        state(BackgroundRunningState.fresh);
        break;
    }
  }

  void yesTapped() {
    switch (state.value) {
      case BackgroundRunningState.fresh:
        _next(useBackground: true);
        break;
      case BackgroundRunningState.confirm:
        state(BackgroundRunningState.doubleConfirm);
        break;
      case BackgroundRunningState.doubleConfirm:
        _next(useBackground: false);
        break;
    }
  }


  void _next({required bool useBackground}) {
    nextTrigger.trigger(useBackground);
    _backgroundService.startBackgroundService(useBackground);
    _minimaStorage.setUserWantsToKeepRunningTheService(useBackground);

    Future.delayed(const Duration(seconds: 1)).then((_) => state(BackgroundRunningState.fresh));
  }
}