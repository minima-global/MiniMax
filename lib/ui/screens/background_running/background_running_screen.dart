import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/background_running/background_running_controller.dart';
import 'package:minimax/ui/screens/background_running/enum/background_running_state_model.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_screen.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_screen.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class BackgroundRunningWarningScreen extends GetWidget<BackgroundRunningWarningController> {
  static const String routeName = "/background_running";

  const BackgroundRunningWarningScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.nextTrigger.listen(_next);
    controller.backTrigger.listen(_back);
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
            padding: const EdgeInsetsDirectional.only(top: large2,  start: large1, end: large1, bottom: small2),
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
                _buildActions(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildDenyButton(),
        medium.toSpace(),
        _buildConfirmButton(),
      ],
    );
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
      case BackgroundRunningState.confirm:
        return StringKeys.backgroundRunningBigTitle.tr;
      case BackgroundRunningState.doubleConfirm:
        HapticFeedback.heavyImpact();
        return StringKeys.backgroundRunningBigTitleAreYouSure.tr;
    }
  }

  Widget _buildExplanation(BackgroundRunningState state) {
    final TextStyle explanationStyle = lmBodyCopy.copyWith(color: coreBlackContrast, height: 1.4);
    return ConstrainedBox(
      // Min 5 lines
      constraints: BoxConstraints(
        minHeight: (explanationStyle.height ?? 0) * 6 * (explanationStyle.fontSize ?? 0),
        minWidth: double.maxFinite,
      ),
      child: simpleHtmlText(
        _createExplanation(state),
        style: explanationStyle,
      ),
    );
  }

  String _createExplanation(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.confirm:
        return StringKeys.backgroundRunningExplanation2.tr;
      case BackgroundRunningState.doubleConfirm:
        return StringKeys.backgroundRunningExplanation3.tr;
    }
  }

  Widget _buildConfirmButton() {
    return createRobotoButton(
      text: StringKeys.backgroundRunningCTAYes.tr,
      colour: coreBlue100,
      onTap: controller.yesTapped,
    );
  }

  Widget _buildDenyButton() {
    return createRobotoButton(
      text: StringKeys.backgroundRunningCTANo.tr,
      colour: coreBlackContrast,
      onTap: controller.noTapped,
    );
  }

  Color _cardColour(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.confirm:
      case BackgroundRunningState.doubleConfirm:
        return surface;
    }
  }

  Color _separatorColour(BackgroundRunningState state) {
    switch (state) {
      case BackgroundRunningState.confirm:
      case BackgroundRunningState.doubleConfirm:
        return white;
    }
  }

  void _next(_) {
    Get.offNamedUntil(
      CongratulationsScreen.routeName,
          (route) => route.settings.name == BatterySettingsScreen.routeName,
    );
  }

  void _back(_) {
    Get.back();
  }
}
