import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/background_check_screen/background_check_controller.dart';
import 'package:minimax/ui/screens/permissions_enabled/permissions_enabled_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class BackgroundCheckScreen extends GetWidget<BackgroundCheckController> {
  static const String routeName = "/background_check";

  BackgroundCheckScreen({Key? key}) : super(key: key);

  StreamSubscription? subscriptionToBatteryOptimization;

  @override
  Widget build(BuildContext context) {
    _listenWhenAllowed();

    return withGlossyBackground(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  void _listenWhenAllowed() {
    subscriptionToBatteryOptimization = controller.isIgnoringBatteryOptimization.listen(
      (isIgnoring) {
        if (isIgnoring) {
          Get.toNamed(PermissionsEnabledScreen.routeName);
          controller.onClose();
          subscriptionToBatteryOptimization?.cancel();
        }
      },
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
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitle(),
              medium.toSpace(),
              _buildBatterySettingsExplanation(),
              medium.toSpace(),
              const CircularProgressIndicator(),
              medium.toSpace(),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return FutureBuilder<bool>(
      initialData: false,
      future: Future.delayed(const Duration(milliseconds: 1500)).then((_) => true),
      builder: (_, s) => Opacity(
        opacity: s.data! ? 1 : 0,
        child: Column(
          children: [
            _buildSkipButton(s.data!),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      StringKeys.backgroundCheckTitle.tr,
      style: lmH2.copyWith(color: coreBlue100),
    );
  }

  Widget _buildBatterySettingsExplanation() {
    return Text(
      StringKeys.backgroundCheckExplanation.tr,
      style: lmBodyCopyMedium.copyWith(color: coreBlue100),
    );
  }

  Widget _buildSkipButton(bool enabled) {
    return createSecondaryCTA(
      text: StringKeys.backgroundCheckBackToBatterySettingsCTA.tr,
      onTap: enabled
          ? () {
              subscriptionToBatteryOptimization?.cancel();
              Get.back();
            }
          : null,
    );
  }
}
