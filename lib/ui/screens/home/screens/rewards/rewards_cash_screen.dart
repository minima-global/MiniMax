import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_tab_model.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_ui_model.dart';
import 'package:minimax/ui/screens/home/screens/rewards/rewards_controller.dart';
import 'package:minimax/ui/screens/home/screens/rewards/views/rewards_info_widget.dart';
import 'package:minimax/ui/screens/home/screens/rewards/views/rewards_widget.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class RewardsScreen extends GetWidget<RewardsController> {
  static const String routeName = "/home/rewards";

  const RewardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return controller.selectedTab.build((selectedTab) {
      return NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () {
                controller.refreshRewards();
                return HapticFeedback.heavyImpact();
              },
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: large1, vertical: large2),
                    child: Column(
                      children: [
                        _buildTabs(selectedTab),
                        medium.toSpace(),
                        _buildTabContent(selectedTab),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildTabs(RewardsTab selectedTab) {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(small3),
        child: Row(
          children: RewardsTab.values
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

  Widget _buildTabContent(RewardsTab selectedTab) {
    switch (selectedTab) {
      case RewardsTab.rewards:
        return RewardsWidget(
          rewardsUIModel: RewardsUIModel(
            additionalRewards: 22,
            rewards: 21,
            dailyNodeRewards: 25,
            inviteRewards: 234,
          ),
        );
      case RewardsTab.rewardsInfo:
        return RewardsInfoWidget();
    }
  }

  Widget _buildTab(RewardsTab tab, {required bool selected}) {
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

extension _RewardsTabExtensions on RewardsTab {
  String get tabName {
    switch (this) {
      case RewardsTab.rewards:
        return StringKeys.rewardsTab.tr;
      case RewardsTab.rewardsInfo:
        return StringKeys.rewardsInfoTab.tr;
    }
  }
}
