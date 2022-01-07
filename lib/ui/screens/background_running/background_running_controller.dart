import 'package:get/get.dart';
import 'package:minimax/data/dependencies/battery.dart';
import 'package:minimax/ui/screens/background_running/enum/background_running_state_model.dart';

class BackgroundRunningController extends GetxController {
  final Rx<BackgroundRunningState> state = Rx(BackgroundRunningState.fresh);
  final Rxn nextTrigger = Rxn();

  BackgroundRunningController();

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
        break;
    }
  }


  void confirm() {
  }
}