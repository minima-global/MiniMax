import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class AllDoneScreen extends StatelessWidget {
  static const String routeName = "/home/incentive_cash/all_done";

  const AllDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return withGlossyBackground(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: large8,
          horizontal: large1,
        ),
        child: semiTransparentModal(
          colour: allDone,
          child: AnimatedContainer(
            padding: const EdgeInsetsDirectional.only(top: large2,  start: large1, end: large1, bottom: small2),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(),
                small1.toSpace(),
                _buildSeparator(),
                medium.toSpace(),
                _buildMainTitle(),
                small1.toSpace(),
                _buildExplanation(),
                large1.toSpace(),
                _buildCloseButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        StringKeys.allDoneScreenTitle.tr,
        style: lmBodyCopy.copyWith(fontSize: 14, color: coreBlackContrast),
      ),
    );
  }

  Widget _buildSeparator() {
    return Container(
      color: white,
      height: 1,
      width: double.maxFinite,
    );
  }

  Widget _buildMainTitle() {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        StringKeys.allDoneScreenBigTitle.tr,
        style: lmH1.copyWith(color: coreBlackContrast),
      ),
    );
  }

  Widget _buildExplanation() {
    final TextStyle explanationStyle = lmBodyCopyMedium.copyWith(color: coreBlackContrast);
    return ConstrainedBox(
      // Min 5 lines
      constraints: BoxConstraints(
        minHeight: (explanationStyle.height ?? 0) * 5 * (explanationStyle.fontSize ?? 0),
        minWidth: double.maxFinite,
      ),
      child: simpleHtmlText(
        StringKeys.allDoneScreenContent.tr,
        style: explanationStyle,
      ),
    );
  }

  Widget _buildCloseButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        createRobotoButton(
          text: StringKeys.allDoneScreenCloseCTA.tr,
          colour: coreBlue100,
          onTap: Get.back,
        ),
      ],
    );
  }
}
