import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/battery_settings/battery_settings_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';

class SetUpScreen extends StatelessWidget {
  static const String routeName = "/set_up";

  const SetUpScreen({Key? key}) : super(key: key);

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMinimaLogo(),
              _buildSetUpYourPhone(),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimaLogo() {
    return SvgPicture.asset(
      ImageKeys.minimaLogoSquared,
      height: 142,
    );
  }

  Widget _buildSetUpYourPhone() {
    return Text(
      StringKeys.homeSetUpYourPhone.tr,
      style: lmH2.copyWith(
        color: coreBlackContrast,
      ),
    );
  }

  Widget _buildContinueButton() {
    return createPrimaryCTA(
      text: StringKeys.homeCTATitle.tr,
      onTap: () => Get.toNamed(BatterySettingsScreen.routeName),
    );
  }
}
