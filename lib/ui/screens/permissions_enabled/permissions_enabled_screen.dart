import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_screen.dart';
import 'package:minimax/ui/screens/incentive_cash_explanation/incentive_cash_explanation_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class PermissionsEnabledScreen extends StatelessWidget {
  static const String routeName = "/background_running/permissions_enabled";

  const PermissionsEnabledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: withGlossyBackground(
        child: Scaffold(
          body: _buildBody(),
        ),
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
        child: AnimatedContainer(
          color: allDone,
          padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
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
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return SizedBox(
      width: double.maxFinite,
      child: Text(
        StringKeys.permissionsEnabledTitle.tr,
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
        StringKeys.permissionsEnabledMainTitle.tr,
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
      child: Text(
        StringKeys.permissionsEnabledExplanation.tr,
        style: explanationStyle,
      ),
    );
  }

  Widget _buildConfirmButton() {
    return createPrimaryCTA(
      text: StringKeys.permissionsEnabledCTA.tr,
      onTap: _continue,
    );
  }

  void _continue() {
    Get.offNamedUntil(
        IncentiveCashExplanationScreen.routeName, (route) => route.settings.name == BatterySettingsScreen.routeName);
  }

}
