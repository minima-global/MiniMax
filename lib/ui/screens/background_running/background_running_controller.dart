import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/ui/screens/background_running/enum/background_running_state_model.dart';

class BackgroundRunningController extends GetxController {
  final BackgroundService _backgroundService;

  final Rx<BackgroundRunningState> state = Rx(BackgroundRunningState.fresh);
  final Rxn nextTrigger = Rxn();

  BackgroundRunningController(this._backgroundService);

  void deny() {
    switch(state.value) {
      case BackgroundRunningState.fresh:
        state(BackgroundRunningState.confirm);
        break;
      case BackgroundRunningState.confirm:
        state(BackgroundRunningState.doubleConfirm);
        break;
      case BackgroundRunningState.doubleConfirm:
        nextTrigger.trigger(null);
        _backgroundService.startBackgroundService(false);
        break;
    }
  }


  void confirm() {
    nextTrigger.trigger(null);
    _backgroundService.startBackgroundService(true);
  }
}