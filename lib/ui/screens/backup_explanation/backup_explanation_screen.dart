import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/background_running/background_running_screen.dart';
import 'package:minimax/ui/screens/incentive_cash_explanation/incentive_cash_explanation_screen.dart';
import 'package:minimax/ui/utils/ui_constants.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class BackupExplanationScreen extends StatelessWidget {
  static const String routeName = "/backup_explanation";

  const BackupExplanationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: withGlossyBackground(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: large6,
        horizontal: large1,
      ),
      child: Material(
        elevation: mainModalElevation,
        borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
          child: Column(
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
    return Text(StringKeys.backupExplanationTitle.tr, style: lmH2.copyWith(color: coreBlue100));
  }

  Widget _buildBackupExplanation() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: setUpModalMinExplanationHeight,
        minWidth: double.maxFinite,
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: StringKeys.backupExplanationTextSplit1.tr,
              style: lmBodyCopy.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.backupExplanationTextSplit2.tr,
              style: lmH4Xtra.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.backupExplanationTextSplit3.tr,
              style: lmBodyCopy.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.backupExplanationTextSplit4.tr,
              style: lmH4Xtra.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.backupExplanationTextSplit5.tr,
              style: lmBodyCopy.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.backupExplanationTextSplit6.tr,
              style: lmH4Xtra.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.backupExplanationTextSplit7.tr,
              style: lmBodyCopy.copyWith(color: coreBlackContrast),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return createPrimaryCTA(
      text: StringKeys.backupExplanationCTA.tr,
      onTap: () => Get.toNamed(IncentiveCashExplanationScreen.routeName),
    );
  }

}
