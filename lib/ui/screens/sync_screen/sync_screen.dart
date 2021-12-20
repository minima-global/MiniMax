import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/sync_screen/sync_controller.dart';
import 'package:minimax/ui/screens/sync_screen/sync_state_model.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/ui/widgets/buttons.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';

class SyncScreen extends GetWidget<SyncController> {
  static const String routeName = "/sync_screen";

  const SyncScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: withGlossyBackground(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: large6,
        horizontal: large1,
      ),
      child: Material(
        elevation: mainModalElevation,
        borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
        child: Container(
          height: 340,
          padding: const EdgeInsets.symmetric(vertical: large2, horizontal: large1),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMinimaLogo(),
                  _buildStateText(),
                ],
              ),
              _createLaunchButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimaLogo() {
    return SvgPicture.asset(
      ImageKeys.minimaLogoLandscape1,
      height: 51,
    );
  }

  Widget _buildStateText() {
    TextStyle textStyle = lmH2.copyWith(color: coreBlackContrast);
    return SizedBox(
      height: (textStyle.height ?? 0) * 2 * (textStyle.fontSize ?? 0),
      child: controller.state.build((state) {
        switch (state) {
          case SyncStateModel.syncing:
            return Text(
              StringKeys.syncScreenSyncingText.tr,
              style: textStyle,
            );
          case SyncStateModel.greetingReceived:
            return Text(
              StringKeys.syncScreenGreetingText.tr,
              style: textStyle,
            );
          case SyncStateModel.readyToLaunch:
            return Container();
        }
      }),
    );
  }

  Widget _createLaunchButton() {
    return controller.state.build((state) {
      switch (state) {
        case SyncStateModel.syncing:
        case SyncStateModel.greetingReceived:
          return Container();
        case SyncStateModel.readyToLaunch:
          return Align(
            alignment: Alignment.bottomCenter,
            child: createPrimaryCTA(
              text: StringKeys.syncScreenLaunchCTA.tr,
              onTap: () => Get.toNamed(HomeScreen.routeName),
            ),
          );
      }
    });
  }
}
