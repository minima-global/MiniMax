import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/background_check_screen/background_check_screen.dart';
import 'package:minimax/ui/screens/background_running/background_running_screen.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_controller.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class BatterySettingsScreen extends GetWidget<BatterySettingsController> {
  static const String routeName = "/battery_settings";

  const BatterySettingsScreen({Key? key}) : super(key: key);

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
          constraints: const BoxConstraints(minHeight: 350),
          padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              medium.toSpace(),
              _buildBatterySettingsExplanation(),
              large1.toSpace(),
              _buildConfirmButton(),
              medium.toSpace(),
              _buildSkipButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(StringKeys.batterySettingsTitle.tr, style: lmH2.copyWith(color: coreBlue100));
  }

  Widget _buildBatterySettingsExplanation() {
    return simpleHtmlText(StringKeys.batterySettingsExplanation.tr);
  }

  Widget _buildConfirmButton() {
    return createPrimaryCTA(
      text: StringKeys.batterySettingsConfirm.tr,
      onTap: _confirm,
    );
  }

  Widget _buildSkipButton() {
    return createSecondaryCTA(
      text: StringKeys.batterySettingsSkip.tr,
      onTap: _skip,
    );
  }

  void _confirm() {
    controller.onConfirmedClicked();
    Get.toNamed(BackgroundCheckScreen.routeName);
  }

  void _skip() {
    Get.toNamed(BackgroundRunningWarningScreen.routeName);
  }
}
