import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/incentive_program_first_screen/incentive_program_first_screen.dart';
import 'package:minimax/ui/screens/rewards/rewards_screen.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';
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
import 'package:minimax/utils/extensions/rx_extensions.dart';

const int navigatorId = 1233;

class HomeScreen extends GetWidget<HomeController> {
  static const String routeName = "/home";

  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState>? _navigatorKey = Get.nestedKey(navigatorId);

  @override
  Widget build(BuildContext context) {
    return withGlossyBackground(
        child: Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(),
    ));
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: controller.darkMode.build(
        (darkMode) => AppBar(
          backgroundColor: darkMode ? coreBlackContrast : coreGrey5,
          title: _buildAppBarTitle(darkMode),
          leading: IconButton(
            padding: const EdgeInsets.all(medium),
            icon: const Icon(Icons.menu),
            color: darkMode ? coreGrey5 : coreBlackContrast,
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarTitle(bool darkMode) {
    return controller.pageSelected.build((pageSelected) {
      return Text(
        pageSelected.homeDrawerKey.tr,
        style: lmH2.copyWith(color: darkMode ? coreGrey40 : coreBlackContrast),
      );
    });
  }

  Widget _buildBody() {
    return Navigator(
      initialRoute: HomeController.defaultPageSelected.routeName,
      onGenerateRoute: (RouteSettings routeSettings) {
        HomePageModel.values
            .firstWhereOrNull((element) => element.routeName == routeSettings.name)
            ?.let((homePageModel) => controller.selectPage(homePageModel));

        return GetPageRoute(
          transition: Transition.fadeIn,
          page: () => _nestedPages[routeSettings.name]?.call() ?? Container(),
        );
      },
      key: _navigatorKey,
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
              Align(alignment: Alignment.centerRight, child: _buildDrawerFooter()),
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

    Get.toNamed(homePageModel.routeName, id: navigatorId);
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
      padding: const EdgeInsets.symmetric(
        vertical: large2,
        horizontal: small1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SvgPicture.asset(
            ImageKeys.minimaLogoLandscape,
            height: 25,
          ),
        ],
      ),
    );
  }
}

Map<String, Widget Function()> _nestedPages = {
  NodeStatusScreen.routeName: () => const NodeStatusScreen(),
  IncentiveCashScreen.routeName: () => IncentiveCashScreen(),
  IncentiveProgramFirstScreen.routeName: () => const IncentiveProgramFirstScreen(),
  RewardsScreen.routeName: () => const RewardsScreen(),
  NewsFeedScreen.routeName: () => const NewsFeedScreen(),
  BatteryOptimisationScreen.routeName: () => const BatteryOptimisationScreen(),
  TerminalScreen.routeName: () => TerminalScreen(),
  HelpScreen.routeName: () => const HelpScreen(),
};

extension HomePageModelRouteNames on HomePageModel {
  String get routeName {
    switch (this) {
      case HomePageModel.nodeStatus:
        return NodeStatusScreen.routeName;
      case HomePageModel.incentiveProgram:
        return IncentiveProgramFirstScreen.routeName;
      case HomePageModel.rewards:
        return RewardsScreen.routeName;
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
