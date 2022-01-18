import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
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
      builder: (_, s) => Visibility(
        visible: s.data!,
        child: Column(
          children: [
            _buildConfirmButton(),
            medium.toSpace(),
            _buildSkipButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text("Background check", style: lmH2.copyWith(color: coreBlue100));
  }

  Widget _buildBatterySettingsExplanation() {
    return Text(
      "Waiting for your confirmation to accept to run Minima in the background…",
      style: lmBodyCopyMedium.copyWith(color: coreBlue100),
    );
  }

  Widget _buildConfirmButton() {
    return createPrimaryCTA(
      text: "Show modal again",
      onTap: controller.showModal,
    );
  }

  Widget _buildSkipButton() {
    return createSecondaryCTA(
      text: "Back to battery settings",
      onTap: () {
        subscriptionToBatteryOptimization?.cancel();
        Get.back();
      },
    );
  }
}
