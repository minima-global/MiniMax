import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/rewards/model/rewards_ui_model.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';

class RewardsWidget extends StatelessWidget {
  final RewardsUIModel rewardsUIModel;

  const RewardsWidget({Key? key, required this.rewardsUIModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildTotalRewards(),
        large2.toSpace(),
        _buildBreakdownOfRewards(),
      ],
    );
  }

  Widget _buildBreakdownOfRewards() {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(top: medium, bottom: large2, start: medium, end: medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: medium),
              child: Text(
                StringKeys.rewardsTabBreakdownOfRewards.tr,
                style: lmH4.copyWith(color: coreBlue100),
              ),
            ),
            small3.toSpace(),
            _buildRewardTile(
              StringKeys.rewardsTabDailyNodeRewardsTitle.tr,
              rewardsUIModel.dailyNodeRewards.toString(),
            ),
            medium.toSpace(),
            _buildRewardTile(
              StringKeys.rewardsTabInviteRewardsTitle.tr,
              rewardsUIModel.inviteRewards.toString(),
            ),
            medium.toSpace(),
            _buildRewardTile(
              StringKeys.rewardsTabAdditionalRewardsTitle.tr,
              rewardsUIModel.additionalRewards.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRewards() {
    return _buildRewardTile(
      StringKeys.rewardsTabTotalRewardsTitle.tr,
      rewardsUIModel.rewards.toString(),
    );
  }

  Widget _buildRewardTile(String title, String text) {
    return semiTransparentModal(
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.all(medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: lmH4Xtra.copyWith(color: coreBlackContrast),
              ),
              Text(
                text,
                style: lmBodyCopyMedium.copyWith(color: coreBlackContrast),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
