import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/help/help_controller.dart';
import 'package:minimax/ui/screens/home/screens/help/model/help_tab.dart';
import 'package:minimax/ui/screens/home/screens/help/views/help_community.dart';
import 'package:minimax/ui/screens/home/screens/help/views/help_dev.dart';
import 'package:minimax/ui/screens/home/screens/help/views/help_tech_papers.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class HelpScreen extends GetWidget<HelpController> {
  static const String routeName = "/home/help";

  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return controller.selectedTab.build((selectedTab) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: large1, vertical: large2),
        child: Column(
          children: [
            _buildTabs(selectedTab),
            medium.toSpace(),
            _buildTabContent(selectedTab),
          ],
        ),
      );
    });
  }

  Widget _buildTabs(HelpTab selectedTab) {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(small3),
        child: Row(
          children: HelpTab.values
              .map(
                (tab) => _buildTab(
                  tab,
                  selected: selectedTab == tab,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildTabContent(HelpTab selectedTab) {
    Widget tab;
    switch (selectedTab) {
      case HelpTab.community:
        tab = const HelpCommunityWidget();
        break;
      case HelpTab.dev:
        tab = const HelpDevWidget();
        break;
      case HelpTab.techPapers:
        tab = const HelpTechPapersWidget();
        break;
    }
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(small1),
        child: tab,
      ),
    );
  }

  Widget _buildTab(HelpTab tab, {required bool selected}) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.selectTab(tab),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Container(
            color: selected ? coreBlue100 : Colors.transparent,
            height: 38,
            child: Center(
              child: AutoSizeText(
                tab.tabName,
                maxLines: 1,
                minFontSize: 0,
                style: lmH4Xtra.copyWith(color: selected ? white : coreBlackContrast),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _HelpTabExtensions on HelpTab {
  String get tabName {
    switch (this) {
      case HelpTab.community:
        return StringKeys.helpScreenCommunityTab.tr;
      case HelpTab.dev:
        return StringKeys.helpScreenCommunityDev.tr;
      case HelpTab.techPapers:
        return StringKeys.helpScreenCommunityTechPapers.tr;
    }
  }
}
