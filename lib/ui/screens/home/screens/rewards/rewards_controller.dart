import 'package:get/get.dart';
import 'package:minimax/data/dependencies/persistence.dart';
import 'package:minimax/data/repositories/ping_repository.dart';
import 'package:minimax/data/services/ping/ping_response_model.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_tab_model.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_ui_model.dart';

class RewardsController extends GetxController {
  final PingRepository _pingRepository;
  final MinimaStorage _minimaStorage;

  final Rxn<RewardsUIModel> rewards = Rxn();
  final Rx<RewardsTab> selectedTab = Rx(RewardsTab.values.first);

  RewardsController(this._pingRepository, this._minimaStorage);

  void selectTab(RewardsTab tab) {
    selectedTab(tab);
  }

  void refreshRewards() {
    _minimaStorage.getNodeId()
        .then((uid) {
      if (uid != null) {
        return _pingRepository.getPingAndRewards(uid: uid);
      } else {
        return Future.value(null);
      }
    })
    .then((pingResponseModel) => rewards(RewardsUIModel.fromPingResponseModel(pingResponseModel)));
  }
}