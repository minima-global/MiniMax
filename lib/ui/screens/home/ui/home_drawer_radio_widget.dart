import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/model/home_page_model.dart';

class HomeDrawerRadioWidget extends StatelessWidget {
  final bool selected;
  final HomePageModel homePageModel;

  const HomeDrawerRadioWidget({
    Key? key,
    required this.selected,
    required this.homePageModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: medium),
      child: Row(
        children: [
          SvgPicture.asset(
            selected ? ImageKeys.icRadialSelected : ImageKeys.icRadialUnselected,
            width: 20,
            height: 20,
            color: selected ? coreBlue100 : coreBlackContrast,
          ),
          large1.toSpace(),
          Text(
            homePageModel.homeDrawerKey,
            style: (selected ? lmH2 : lmBodyCopy).copyWith(color: coreBlackContrast),
          ),
        ],
      ),
    );
  }
}

extension HomePageModelExtensions on HomePageModel {
  String get homeDrawerKey {
    switch (this) {
      case HomePageModel.nodeStatus:
        return StringKeys.homeScreenDrawerTitleNodeStatus.tr;
      case HomePageModel.incentiveProgram:
        return StringKeys.homeScreenDrawerTitleIncentiveCash.tr;
      case HomePageModel.rewards:
        return StringKeys.homeScreenDrawerTitleRewards.tr;
      case HomePageModel.newsFeed:
        return StringKeys.homeScreenDrawerTitleNewsFeed.tr;
      case HomePageModel.batteryOptimisation:
        return StringKeys.homeScreenDrawerTitleBatteryOptimisation.tr;
      case HomePageModel.terminal:
        return StringKeys.homeScreenDrawerTitleTerminal.tr;
      case HomePageModel.help:
        return StringKeys.homeScreenDrawerTitleHelp.tr;
    }
  }
}
