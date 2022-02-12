import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_tab_model.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_ui_model.dart';

class RewardsController extends GetxController {
  final Rxn<RewardsUIModel> rewards = Rxn();
  final Rx<RewardsTab> selectedTab = Rx(RewardsTab.values.first);

  void selectTab(RewardsTab tab) {
    selectedTab(tab);
  }

  void refreshRewards() {

  }
}