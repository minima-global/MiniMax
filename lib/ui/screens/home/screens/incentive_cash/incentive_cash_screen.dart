import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/all_done/all_done_screen.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/incentive_cash_controller.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/model/incentive_cash_tab.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/views/incentive_cash_widget.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/views/incentive_program_first_tab_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class IncentiveCashScreen extends GetWidget<IncentiveProgramController> {
  static const String routeName = "/home/incentive_cash";

  IncentiveCashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.showAllDoneTrigger.listen(_showAllDoneTrigger);

    return SafeArea(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return controller.selectedTab.buildIgnoreNull((selectedTab) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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

  Widget _buildTabs(IncentiveProgramTab selectedTab) {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(small3),
        child: Row(
          children: IncentiveProgramTab.values
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

  Widget _buildTabContent(IncentiveProgramTab selectedTab) {
    switch (selectedTab) {
      case IncentiveProgramTab.incentiveProgram:
        return _buildSetUpInstructions();
      case IncentiveProgramTab.inviteCode:
        return _buildBalance();
    }
  }

  Widget _buildSetUpInstructions() {
    return controller.nodeId.build(
      (nodeId) => IncentiveProgramFirstTabScreen(
        nodeId,
        controller,
      ),
    );
  }

  Widget _buildBalance() {
    return controller.loadingBalance.build(
      (loading) => controller.incentiveCashModel.build(
        (incentiveCashModel) => IncentiveCashWidget(
          incentiveCashModel,
          loading,
          onRefresh: controller.refreshBalance,
        ),
      ),
    );
  }

  Widget _buildTab(IncentiveProgramTab tab, {required bool selected}) {
    return Expanded(
      child: InkWell(
        onTap: () => controller.selectTab(tab),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Container(
            color: selected ? coreBlue100 : Colors.transparent,
            height: 38,
            child: Center(
              child: controller.inviteCodeOpacity.build(
                (opacity) => wrapInFadeTransitionIfNeeded(
                  wrapInFadeTransition: tab == IncentiveProgramTab.inviteCode && !selected,
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
        ),
      ),
    );
  }

  Widget _buildFadeTransitionWrapper(Widget widget) {
    return FadeTransition(
      opacity: controller.animationController,
      child: widget,
    );
  }

  Widget wrapInFadeTransitionIfNeeded({
    required bool wrapInFadeTransition,
    required Widget child,
  }) {
    if (wrapInFadeTransition) {
      return _buildFadeTransitionWrapper(child);
    } else {
      return child;
    }
  }

  void _showAllDoneTrigger(_) {
    Get.toNamed(AllDoneScreen.routeName);
  }
}

extension _IncentiveCashTabExtensions on IncentiveProgramTab {
  String get tabName {
    switch (this) {
      case IncentiveProgramTab.incentiveProgram:
        return StringKeys.incentiveCashScreenIncentiveProgramTab.tr;
      case IncentiveProgramTab.inviteCode:
        return StringKeys.incentiveCashScreenInviteCodeTab.tr;
    }
  }
}
