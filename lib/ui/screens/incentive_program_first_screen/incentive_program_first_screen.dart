import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/home/screens/incentive_cash/incentive_cash_screen.dart';
import 'package:minimax/ui/screens/incentive_program_first_screen/incentive_program_first_controller.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class IncentiveProgramFirstScreen extends GetWidget<IncentiveProgramFirstController> {
  static const String routeName = "/incentive_program/intro";

  const IncentiveProgramFirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nextTrigger.listen(_next);
    return withGlossyBackground(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return controller.nextTrigger.buildIgnoreNull(
          (shouldItGoNext) => Visibility(
        visible: !shouldItGoNext,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: large2,
            horizontal: large1,
          ),
          child: semiTransparentModal(
            child: Container(
              constraints: const BoxConstraints(minHeight: 350),
              padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTitle(),
                  medium.toSpace(),
                  _buildBatterySettingsExplanation(),
                  large1.toSpace(),
                  _buildContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
        width: double.maxFinite,
        child: Text(StringKeys.incentiveCashFirstScreenTitle.tr, style: lmH4Xtra.copyWith(color: coreBlue100)));
  }

  Widget _buildBatterySettingsExplanation() {
    return simpleHtmlText(StringKeys.incentiveCashFirstScreenExplanation.tr);
  }

  Widget _buildContinueButton() {
    return createPrimaryCTA(
      text: StringKeys.incentiveCashFirstScreenContinueCTA.tr,
      onTap: _continue,
    );
  }

  void _continue() {
    controller.next();
  }

  void _next(bool? shouldGoNext) {
    if (shouldGoNext == true) {
      Get.toNamed(IncentiveCashScreen.routeName, id: navigatorId);
    }
  }
}
