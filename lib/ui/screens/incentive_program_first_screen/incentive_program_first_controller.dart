import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';

class IncentiveProgramFirstController extends GetxController {
  final MinimaStorage _minimaStorage;
  final Rxn<bool> nextTrigger = Rxn<bool>();

  IncentiveProgramFirstController(this._minimaStorage);

  @override
  void onInit() {
    super.onInit();

    _minimaStorage //
        .getUserSeenIncentiveProgramAtLeastOnce()
        .then(nextTrigger);
  }

  void next() {
    _minimaStorage.setUserSeenIncentiveProgramAtLeastOnce(true);
    nextTrigger(true);
  }
}
