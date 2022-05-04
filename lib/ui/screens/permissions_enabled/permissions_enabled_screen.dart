import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_screen.dart';
import 'package:minimax/ui/screens/congratulations/congratulations_screen.dart';
import 'package:minimax/ui/screens/permissions_enabled/permission_enabled_args.dart';
import 'package:minimax/ui/utils/simple_html_text.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class PermissionsEnabledScreen extends StatelessWidget {
  static const String routeName = "/background_running/permissions_enabled";

  const PermissionsEnabledScreen({Key? key}) : super(key: key);

  PermissionEnabledArgs get _args => Get.arguments as PermissionEnabledArgs;

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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: large8,
          horizontal: large1,
        ),
        child: semiTransparentModal(
          child: AnimatedContainer(
            color: allDone,
            padding: const EdgeInsetsDirectional.only(top: large2, start: large1, end: large1, bottom: small2),
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
    final TextStyle explanationStyle = lmBodyCopyMedium.copyWith(color: coreBlackContrast, height: 1.4);
    return ConstrainedBox(
      // Min 5 lines
      constraints: BoxConstraints(
        minHeight: (explanationStyle.height ?? 0) * 5 * (explanationStyle.fontSize ?? 0),
        minWidth: double.maxFinite,
      ),
      child: simpleHtmlText(
        StringKeys.permissionsEnabledExplanation.tr,
        overridingStyles: (styles) => styles
          ..addEntries(
            [MapEntry("html", Style.fromTextStyle(explanationStyle))],
          ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        createRobotoButton(
          text: StringKeys.permissionsEnabledCTA.tr,
          colour: coreBlue100,
          onTap: _args.onContinueTapped,
        ),
      ],
    );
  }

}
