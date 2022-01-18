import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/loader/loader_controller.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';

class LoaderScreen extends GetWidget<LoaderController> {
  static const String routeName = "/loader";

  const LoaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.connectedTrigger.listen(_onConnected);
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
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: large1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              large5.toSpace(),
              _buildMinimaLogo(),
              large1.toSpace(),
              _buildLoading(),
              large1.toSpace(),
              _buildLoader(),
              large3.toSpace(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimaLogo() {
    return SvgPicture.asset(
      ImageKeys.minimaLogoSquaredNoName,
      height: 99,
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 70,
      child: Center(
        child: Text(
          StringKeys.loaderScreenLoading.tr,
          style: lmH3.copyWith(
            color: coreBlackContrast,
          ),
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const LinearProgressIndicator(
      color: coreBlue100,
    );
  }

  void _onConnected(_) {
    Get.offAllNamed(HomeScreen.routeName);
  }
}
