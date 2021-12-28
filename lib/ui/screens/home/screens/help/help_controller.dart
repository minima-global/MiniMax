import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/screens/help/model/help_tab.dart';

class HelpController extends GetxController {
  final Rx<HelpTab> selectedTab = Rx(HelpTab.values.first);

  void selectTab(HelpTab tab) {
    selectedTab(tab);
  }
}
