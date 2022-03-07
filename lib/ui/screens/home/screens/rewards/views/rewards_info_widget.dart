import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';

class RewardsInfoWidget extends StatelessWidget {
  const RewardsInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildRewardInfoTile(
          title: StringKeys.rewardsInfoDailyRewardsTitle.tr,
          text: StringKeys.rewardsInfoDailyRewardsExplanation.tr,
        ),
        medium.toSpace(),
        _buildRewardInfoTile(
          title: StringKeys.rewardsInfoInviteRewardTitle.tr,
          text: StringKeys.rewardsInfoInviteRewardExplanation.tr,
          extraWidget: _buildExtraRewardsExplanation(),
        ),
        medium.toSpace(),
        _buildRewardInfoTile(
          title: StringKeys.rewardsInfoAdditionalRewardsTitle.tr,
          text: StringKeys.rewardsInfoAdditionalRewardsExplanation.tr,
        ),
      ],
    );
  }

  Widget _buildRewardInfoTile({
    required String title,
    required String text,
    Widget? extraWidget,
  }) {
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
                style: lmH4Xtra.copyWith(color: coreBlue100),
              ),
              simpleHtmlText(text),
              small3.toSpace(),
              extraWidget ?? Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtraRewardsExplanation() {
    final Map<int, num> peopleToRewardsList = {
      5: 50,
      10: 100,
      15: 150,
      20: 200,
    };

    List<Widget> widgets = [];
    widgets.add(small2.toSpace());

    widgets.addAll(peopleToRewardsList.entries.map(
      (e) => semiTransparentModal(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: small1, horizontal: small2),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                StringKeys.rewardsInfoSPeople.trArgs([e.key.toString()]),
                style: lmBodyCopyMedium.copyWith(color: coreBlackContrast),
              ),
              Text(
                StringKeys.rewardsInfoSRewards.trArgs([e.value.toString()]),
                style: lmH4.copyWith(color: coreBlue100),
              ),
            ],
          ),
        ),
      ),
    ));

    // Footer
    widgets.add(simpleHtmlText(StringKeys.rewardsInfoInviteRewardsFooter.tr));

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widgets.length,
      itemBuilder: (_, position) => widgets[position],
      separatorBuilder: (_, __) => medium.toSpace(),
    );
  }
}
