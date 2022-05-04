import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/background_check_screen/background_check_args.dart';
import 'package:minimax/ui/screens/background_check_screen/background_check_screen.dart';
import 'package:minimax/ui/screens/home/screens/battery_optimisation/battery_optimisation_controller.dart';
import 'package:minimax/ui/screens/permissions_enabled/permission_enabled_args.dart';
import 'package:minimax/ui/screens/permissions_enabled/permissions_enabled_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class BatteryOptimisationScreen extends GetWidget<BatteryOptimisationController> {
  static const String routeName = "/home/battery_optimisation";

  const BatteryOptimisationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.batteryOptimisationPreviouslyAcceptedTrigger.listenWhenNotNull(_onTapped);
    return ListView(
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
                    onTap: controller.onTapped,
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

  void _onTapped(bool previouslyAccepted) {
    if (previouslyAccepted) {
      AppSettings.openBatteryOptimizationSettings(asAnotherTask: true);
    } else {
      Get.toNamed(
        BackgroundCheckScreen.routeName,
        arguments: BackgroundCheckArgs(
          onAllowed: () => Get.offNamed(
            PermissionsEnabledScreen.routeName,
            arguments: PermissionEnabledArgs(
              onContinueTapped: () => Get.back(),
            ),
          ),
        ),
      );
    }
  }
}
