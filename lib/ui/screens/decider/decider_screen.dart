import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/decider/decider_controller.dart';
import 'package:minimax/ui/screens/decider/model/decider_model.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/loader/loader_screen.dart';
import 'package:minimax/ui/screens/set_up/set_up_screen.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';
import 'package:minimax/utils/extensions/rx_extensions.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class DeciderScreen extends GetWidget<DeciderController> {
  static const String routeName = "/decider";

  const DeciderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.decider.listenWhenNotNull(_onDecision);
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
    return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOut,
        duration: controller.introShowDuration,
        builder: (BuildContext context, double opacity, Widget? child) {
          return Opacity(
            opacity: opacity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: large8,
                horizontal: large1,
              ),
              child: semiTransparentModal(
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(horizontal: large1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      large6.toSpace(),
                      _buildMinimaLogo(),
                      large1.toSpace(),
                      _buildSetUpYourPhone(),
                      _buildVersion(),
                      small1.toSpace(),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildMinimaLogo() {
    return SvgPicture.asset(
      ImageKeys.minimaLogoSquared,
      height: 142,
    );
  }

  Widget _buildSetUpYourPhone() {
    return SizedBox(
      height: 72,
      child: Center(
        child: Text(
          StringKeys.deciderMainContent.tr,
          style: lmH2.copyWith(
            color: coreBlackContrast,
          ),
        ),
      ),
    );
  }

  Widget _buildVersion() {
    return controller.version.build(
      (version) => SizedBox(
        height: 70,
        child: Center(
          child: Text(
            version,
            style: lmBodyCopyMedium.copyWith(
              color: coreBlackContrast,
            ),
          ),
        ),
      ),
    );
  }

  void _onDecision(DeciderModel decision) {
    switch (decision) {
      case DeciderModel.setUp:
        Get.offNamed(SetUpScreen.routeName);
        break;
      case DeciderModel.goMain:
        Get.offNamed(LoaderScreen.routeName);
        break;
    }
  }
}
