import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/incentive_cash_controller.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';
import 'package:minimax/utils/keyboard.dart';
import 'package:url_launcher/url_launcher.dart';

class IncentiveProgramFirstTabScreen extends StatelessWidget {
  final String? nodeId;
  final IncentiveProgramController controller;
  final FocusNode _nodeIdFocusNode = FocusNode();

  IncentiveProgramFirstTabScreen(this.nodeId, this.controller, {Key? key}) : super(key: key);

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
            large2.toSpace(),
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
    return simpleHtmlText(
      StringKeys.incentiveCashScreenIncentiveCashProgramExplanation.tr,
    );
  }

  Widget _buildNodeIdInput() {
    return controller.lockedEdition.buildMapped(
          (bool locked) => locked && nodeId != null,
          (bool locked) => semiTransparentModal(
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
                child: _buildTextFormField(locked),
              ),
              medium.toSpace(),
              createPrimaryCTA(
                text: nodeId == null
                    ? StringKeys.incentiveCashScreenSetUpTextFieldEnterFirstTime.tr
                    : locked
                    ? StringKeys.incentiveCashScreenSetUpTextFieldEnterUpdateLocked.tr
                    : StringKeys.incentiveCashScreenSetUpTextFieldEnterUpdate.tr,
                onTap: locked
                    ? null
                    : () {
                  controller.saveNodeId();
                  hideKeyboard();
                  _nodeIdFocusNode.unfocus();
                },
                colour: primaryCTAColour.withOpacity(locked ? 0.2 : 1),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(bool locked) {
    _focusIfNeeded(locked);

    return Padding(
      padding: const EdgeInsets.all(medium),
      child: Row(
        children: [
          Expanded(
            child: AbsorbPointer(
              absorbing: locked,
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
          if (nodeId != null)
            InkWell(
              onTap: controller.toggleLock,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: small1),
                child: locked
                    ? const Icon(
                  Icons.lock_outline,
                  color: coreGrey100,
                )
                    : SvgPicture.asset(
                  ImageKeys.icLockOpen,
                  color: coreGrey100,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _focusIfNeeded(bool locked) {
    if (nodeId == null) {
      return;
    }
    if (!locked) {
      FocusScope.of(Get.context!).requestFocus(_nodeIdFocusNode);
    } else {
      FocusScope.of(Get.context!).unfocus();
      _nodeIdFocusNode.unfocus();
      hideKeyboard();
    }
  }
}
