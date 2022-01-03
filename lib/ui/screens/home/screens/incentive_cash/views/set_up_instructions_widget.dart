import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/incentive_cash_controller.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/keyboard.dart';
import 'package:url_launcher/url_launcher.dart';

class SetUpInstructionsWidget extends StatelessWidget {
  final String? nodeId;
  final IncentiveCashController controller;
  final FocusNode _nodeIdFocusNode = FocusNode();

  SetUpInstructionsWidget(this.nodeId, this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      _buildNodeIdInput(),
      medium.toSpace(),
      _buildIncentiveCashInfoProgram(),
    ];

    return Column(
      children: nodeId != null ? widgets : widgets.reversed.toList(),
    );
  }

  Widget _buildIncentiveCashInfoProgram() {
    return semiTransparentModal(
      child: Padding(
        padding: const EdgeInsets.all(large1),
        child: Column(
          children: [
            _buildIncentiveCashInfoTitle(),
            small1.toSpace(),
            _buildIncentiveCashInfoExplanation(),
            medium.toSpace(),
            createSecondaryCTA(
              text: StringKeys.incentiveCashScreenIncentiveCashProgramCTA.tr,
              onTap: _goToIncentiveCashUrl,
            )
          ],
        ),
      ),
    );
  }

  void _goToIncentiveCashUrl() {
    launch(StringKeys.incentiveCashScreenIncentiveCashProgramCTAUrl.tr);
  }

  Widget _buildIncentiveCashInfoTitle() {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        StringKeys.incentiveCashScreenIncentiveCashProgramTitle.tr,
        style: lmH4Xtra.copyWith(color: coreBlue100),
      ),
    );
  }

  Widget _buildIncentiveCashInfoExplanation() {
    return Text(
      StringKeys.incentiveCashScreenIncentiveCashProgramExplanation.tr,
      style: lmBodyCopy.copyWith(color: coreBlackContrast),
    );
  }

  Widget _buildNodeIdInput() {
    return semiTransparentModal(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: large1),
              child: Text(
                StringKeys.incentiveCashScreenSetUpTextFieldTitle.tr,
                style: lmH2.copyWith(color: coreBlackContrast),
              ),
            ),
            small2.toSpace(),
            semiTransparentModal(
              child: Padding(
                padding: const EdgeInsets.all(medium),
                child: TextFormField(
                  focusNode: _nodeIdFocusNode,
                  controller: controller.nodeIdController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  style: lmH2.copyWith(color: coreBlackContrast),
                  decoration: InputDecoration.collapsed(
                    hintText: StringKeys.incentiveCashScreenSetUpTextFieldHint.tr,
                    hintStyle: lmH2.copyWith(color: coreGrey40),
                  ),
                ),
              ),
            ),
            medium.toSpace(),
            createPrimaryCTA(
                text: nodeId == null
                    ? StringKeys.incentiveCashScreenSetUpTextFieldEnterFirstTime.tr
                    : StringKeys.incentiveCashScreenSetUpTextFieldEnterUpdate.tr,
                onTap: () {
                  controller.saveNodeId();
                  hideKeyboard();
                  _nodeIdFocusNode.unfocus();
                })
          ],
        ),
      ),
    );
  }
}
