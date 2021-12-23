import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/incentive_cash_controller.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_tab.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/views/set_up_instructions_widgett.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class IncentiveCashScreen extends GetWidget<IncentiveCashController> {
  static const String routeName = "/home/incentive_cash";

  const IncentiveCashScreen({Key? key}) : super(key: key);

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

  Widget _buildTabs(IncentiveCashTab selectedTab) {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(small3),
        child: Row(
          children: IncentiveCashTab.values
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

  Widget _buildTabContent(IncentiveCashTab selectedTab) {
    switch (selectedTab) {
      case IncentiveCashTab.setUpInstructions:
        return _buildSetUpInstructions();
      case IncentiveCashTab.balance:
        return _buildBalance();
    }
  }

  Widget _buildSetUpInstructions() {
    return controller.nodeId.build(
      (nodeId) => SetUpInstructionsWidget(
        nodeId,
        controller,
      ),
    );
  }

  Widget _buildBalance() {
    return Expanded(
      child: trarns,
    );
  }

  Widget _buildTab(IncentiveCashTab tab, {required bool selected}) {
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

extension _IncentiveCashTabExtensions on IncentiveCashTab {
  String get tabName {
    switch (this) {
      case IncentiveCashTab.setUpInstructions:
        return StringKeys.incentiveCashScreenSetUpTab.tr;
      case IncentiveCashTab.balance:
        return StringKeys.incentiveCashScreenBalanceTab.tr;
    }
  }
}
