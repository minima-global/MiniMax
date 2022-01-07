import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/background_running/background_running_controller.dart';
import 'package:minimax/ui/screens/background_running/enum/background_running_state_model.dart';
import 'package:minimax/ui/screens/incentive_cash_explanation/incentive_cash_explanation_screen.dart';
import 'package:minimax/ui/screens/permissions_enabled/permissions_enabled_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/device/vibration.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class BackgroundRunningScreen extends GetWidget<BackgroundRunningController> {
  static const String routeName = "/background_running";

  const BackgroundRunningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nextTrigger.listenWhenNotNull(_next);

    return withGlossyBackground(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return controller.state.build((state) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: large7,
          horizontal: large1,
        ),
        child: semiTransparentModal(
          colour: _cardColour(state),
          child: AnimatedContainer(
            padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(),
                small1.toSpace(),
                _buildSeparator(state),
                medium.toSpace(),
                _buildMainTitle(state),
                small1.toSpace(),
                _buildExplanation(state),
                large1.toSpace(),
                _buildConfirmButton(state),
                medium.toSpace(),
                _buildDenyButton(state),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTitle() {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        StringKeys.backgroundRunningTitle.tr,
        style: lmBodyCopy.copyWith(fontSize: 14, color: coreBlackContrast),
      ),
    );
  }

  Widget _buildSeparator(BackgroundRunningState state) {
    return Container(
      color: _separatorColour(state),
      height: 1,
      width: double.maxFinite,
    );
  }

  Widget _buildMainTitle(BackgroundRunningState state) {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        _createBigTitle(state),
        style: lmH1.copyWith(color: coreBlackContrast),
      ),
    );
  }

  String _createBigTitle(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.fresh:
      case BackgroundRunningState.confirm:
        return StringKeys.backgroundRunningBigTitle.tr;
      case BackgroundRunningState.doubleConfirm:
        hapticFeedback();
        return StringKeys.backgroundRunningBigTitleAreYouSure.tr;
    }
  }

  Widget _buildExplanation(BackgroundRunningState state) {
    final TextStyle explanationStyle = lmBodyCopyMedium.copyWith(color: coreBlackContrast);
    return ConstrainedBox(
      // Min 5 lines
      constraints: BoxConstraints(
        minHeight: (explanationStyle.height ?? 0) * 5 * (explanationStyle.fontSize ?? 0),
        minWidth: double.maxFinite,
      ),
      child: Text(
        _createExplanation(state),
        style: explanationStyle,
      ),
    );
  }

  String _createExplanation(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.fresh:
        return StringKeys.backgroundRunningExplanation1.tr;
      case BackgroundRunningState.confirm:
        return StringKeys.backgroundRunningExplanation2.tr;
      case BackgroundRunningState.doubleConfirm:
        return StringKeys.backgroundRunningExplanation3.tr;
    }
  }

  Widget _buildConfirmButton(BackgroundRunningState state) {
    return createPrimaryCTA(
      text: state == BackgroundRunningState.fresh
          ? StringKeys.backgroundRunningCTAConfirm.tr
          : StringKeys.backgroundRunningCTAYes.tr,
      onTap: controller.yesTapped,
    );
  }

  Widget _buildDenyButton(BackgroundRunningState state) {
    return createSecondaryCTA(
      text: state == BackgroundRunningState.fresh
          ? StringKeys.backgroundRunningCTASkip.tr
          : StringKeys.backgroundRunningCTANo.tr,
      onTap: controller.noTapped,
    );
  }

  Color _cardColour(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.fresh:
        return white;
      case BackgroundRunningState.confirm:
      case BackgroundRunningState.doubleConfirm:
        return surface;
    }
  }

  Color _separatorColour(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.fresh:
        return coreGrey100;
      case BackgroundRunningState.confirm:
      case BackgroundRunningState.doubleConfirm:
        return white;
    }
  }

  void _next(bool useBackground) {
    if (useBackground) {
      Get.toNamed(PermissionsEnabledScreen.routeName);
    } else {
      Get.toNamed(IncentiveCashExplanationScreen.routeName);
    }
  }
}
