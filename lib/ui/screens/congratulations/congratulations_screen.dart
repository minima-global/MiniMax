import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/utils/ui_constants.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class CongratulationsScreen extends StatelessWidget {
  static const String routeName = "/congratulations";

  const CongratulationsScreen({Key? key}) : super(key: key);

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
        vertical: extraExtraExtraExtraLarge,
        horizontal: large,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: extraLarge, horizontal: large),
          color: white.withOpacity(0.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              medium.toSpace(),
              _buildBackupExplanation(),
              large.toSpace(),
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
        minWidth: double.maxFinite,
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: StringKeys.congratulationsExplanationSplit1.tr,
              style: lmBodyCopy.copyWith(color: coreBlackContrast),
            ),
            TextSpan(
              text: StringKeys.congratulationsExplanationSplit2.tr,
              style: lmH4Xtra.copyWith(color: coreBlackContrast),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return createPrimaryCTA(
      text: StringKeys.congratulationsCTA.tr,
      onTap: () {},
    );
  }
}
