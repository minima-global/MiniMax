import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/screens/node_status/node_status_controller.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class BatteryOptimisationScreen extends GetWidget<NodeStatusController> {
  static const String routeName = "/home/battery_optimisation";

  const BatteryOptimisationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
          child: semiTransparentModal(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: large1, horizontal: medium),
              child: Column(
                children: [
                  _buildBatteryOptimisationExplanation(),
                  medium.toSpace(),
                  createPrimaryCTA(
                    text: StringKeys.batteryOptimisationCTA.tr,
                    onTap: _goToBatteryOptimisationSettings,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBatteryOptimisationExplanation() {
    return Text(
      StringKeys.batteryOptimisationExplanation.tr,
      style: lmBodyCopyMedium.copyWith(color: coreBlackContrast),
    );
  }

  void _goToBatteryOptimisationSettings() {
    AppSettings.openBatteryOptimizationSettings(asAnotherTask: true);
  }
}
