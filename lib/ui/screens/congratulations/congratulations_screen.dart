import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_controller.dart';
import 'package:minimax/ui/screens/decider/decider_screen.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/utils/ui_constants.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class CongratulationsScreen extends GetWidget<CongratulationsController> {
  static const String routeName = "/congratulations";

  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withGlossyBackground(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: large8,
        horizontal: large1,
      ),
      child: semiTransparentModal(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              medium.toSpace(),
              _buildBackupExplanation(),
              large1.toSpace(),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(StringKeys.congratulationsTitle.tr, style: lmH2.copyWith(color: coreBlue100));
  }

  Widget _buildBackupExplanation() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: setUpModalMinExplanationHeight,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: StringKeys.congratulationsExplanationSplit1.tr,
              style: lmBodyCopy.copyWith(color: coreBlackContrast),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return createPrimaryCTA(
      text: StringKeys.congratulationsCTA.tr,
      onTap: () {
        controller.setUserConfiguredDevice(); // Fire and forget
        Get.offAllNamed(DeciderScreen.routeName);
      },
    );
  }
}
