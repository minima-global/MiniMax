import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/model/home_page_model.dart';
import 'package:package_info/package_info.dart';

class HomeController extends GetxController {
  static const defaultPageSelected = HomePageModel.nodeStatus;

  final Rx<HomePageModel> pageSelected = Rx<HomePageModel>(defaultPageSelected);
  final RxBool darkMode = RxBool(false);
  final RxString version;

  HomeController(PackageInfo packageInfo) : version = RxString(packageInfo.version);

  void selectPage(HomePageModel newPageSelected) {
    pageSelected(newPageSelected);
    darkMode(newPageSelected.shouldEnableDarkMode);
  }
}

extension _HomePageModelExtensions on HomePageModel {
  bool get shouldEnableDarkMode => this == HomePageModel.terminal;
}