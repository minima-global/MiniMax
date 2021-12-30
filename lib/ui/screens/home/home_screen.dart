import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/home_controller.dart';
import 'package:minimax/ui/screens/home/model/home_page_model.dart';
import 'package:minimax/ui/screens/home/screens/battery_optimisation/battery_optimisation_screen.dart';
import 'package:minimax/ui/screens/home/screens/help/help_screen.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/incentive_cash_screen.dart';
import 'package:minimax/ui/screens/home/screens/news_feed/news_feed_screen.dart';
import 'package:minimax/ui/screens/home/screens/node_status/node_status_screen.dart';
import 'package:minimax/ui/screens/home/screens/terminal/terminal_screen.dart';
import 'package:minimax/ui/screens/home/ui/home_drawer_radio_widget.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class HomeScreen extends GetWidget<HomeController> {
  static const String routeName = "/home";

  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState>? _navigatorKey = Get.nestedKey(Random().nextInt(1 << 32));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: withGlossyBackground(
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: coreGrey5,
      title: _buildAppBarTitle(),
      leading: IconButton(
        padding: const EdgeInsets.all(medium),
        icon: const Icon(Icons.menu),
        color: coreBlackContrast,
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
    );
  }

  Widget _buildAppBarTitle() {
    return controller.pageSelected.build((pageSelected) {
      return Text(
        pageSelected.homeDrawerKey.tr,
        style: lmH2.copyWith(color: coreBlackContrast),
      );
    });
  }

  Widget _buildBody() {
    return Navigator(
      initialRoute: HomeController.defaultPageSelected.routeName,
      onPopPage: (_, __) => true,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute(
            builder: (_) =>
                _nestedPages.firstWhereOrNull((element) => element.name == routeSettings.name)?.page() ?? Container());
      },
      key: _navigatorKey,
      pages: _nestedPages,
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: medium),
          child: Column(
            children: [
              _buildHeaderTextDrawer(),
              large2.toSpace(),
              _buildHomePagesSelectors(),
              const Spacer(),
              _buildDrawerFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomePagesSelectors() {
    return controller.pageSelected.build(
      (pageSelected) {
        List<HomePageModel> pages = HomePageModel.values;
        List<Widget> children = pages
            .map(
              (homePageModel) => InkWell(
                onTap: () => _onPageSelected(homePageModel),
                child: HomeDrawerRadioWidget(
                  selected: pageSelected == homePageModel,
                  homePageModel: homePageModel,
                ),
              ),
            )
            .toList();

        return ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, position) => Container(
            width: double.maxFinite,
            height: 1,
            color: pages[position] == pageSelected ? coreBlue100 : coreGrey40,
          ),
          itemCount: children.length,
          itemBuilder: (_, position) => children[position],
        );
      },
    );
  }

  void _onPageSelected(HomePageModel homePageModel) {
    if (_scaffoldKey.currentState?.isDrawerOpen == true) {
      Get.back();
    }
    controller.selectPage(homePageModel);

    _navigatorKey?.currentState?.pushNamed(homePageModel.routeName);
  }

  Widget _buildHeaderTextDrawer() {
    return controller.version.build((version) {
      return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: medium),
        child: Text(StringKeys.homeScreenDrawerHeaderVersion.trArgs([version]), style: lmBodyCopy),
      );
    });
  }

  Widget _buildDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: large2),
      child: Column(
        children: [
          createPrimaryCTA(text: StringKeys.homeScreenDrawerBackUpNodeCTA.tr),
          large2.toSpace(),
          SvgPicture.asset(
            ImageKeys.minimaLogoLandscape1,
            height: 32,
          ),
        ],
      ),
    );
  }
}

List<GetPage> _nestedPages = [
  GetPage(
    name: NodeStatusScreen.routeName,
    page: () => const NodeStatusScreen(),
  ),
  GetPage(
    name: IncentiveCashScreen.routeName,
    page: () => const IncentiveCashScreen(),
  ),
  GetPage(
    name: NewsFeedScreen.routeName,
    page: () => const NewsFeedScreen(),
  ),
  GetPage(
    name: BatteryOptimisationScreen.routeName,
    page: () => const BatteryOptimisationScreen(),
  ),
  GetPage(
    name: TerminalScreen.routeName,
    page: () => TerminalScreen(),
  ),
  GetPage(
    name: HelpScreen.routeName,
    page: () => const HelpScreen(),
  ),
];

extension HomePageModelRouteNames on HomePageModel {
  String get routeName {
    switch (this) {
      case HomePageModel.nodeStatus:
        return NodeStatusScreen.routeName;
      case HomePageModel.incentiveCash:
        return IncentiveCashScreen.routeName;
      case HomePageModel.newsFeed:
        return NewsFeedScreen.routeName;
      case HomePageModel.batteryOptimisation:
        return BatteryOptimisationScreen.routeName;
      case HomePageModel.terminal:
        return TerminalScreen.routeName;
      case HomePageModel.help:
        return HelpScreen.routeName;
    }
  }
}
