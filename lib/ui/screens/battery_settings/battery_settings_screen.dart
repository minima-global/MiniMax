import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/are_you_sure_skip_battery/are_you_sure_skip_battery.dart';
import 'package:minimax/ui/screens/background_running/background_running_screen.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_controller.dart';
import 'package:minimax/ui/utils/ui_constants.dart';
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
        vertical: large7,
        horizontal: large1,
      ),
      child: semiTransparentModal(
        child: Container(
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
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: setUpModalMinExplanationHeight,
        minWidth: double.maxFinite,
      ),
      child: Text(StringKeys.batterySettingsExplanation.tr, style: lmBodyCopyMedium.copyWith(color: coreBlackContrast)),
    );
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
      onTap: () {
        Get.toNamed(AreYouSureSkipBatteryScreen.routeName);
      },
    );
  }

  void _confirm() {
    controller.onConfirmedClicked();
    Get.toNamed(BackgroundRunningScreen.routeName);
  }
}
