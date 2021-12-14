import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:minimax/res/images/images.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';
import 'package:minimax/res/styles/margins.dart';
import 'package:minimax/res/styles/text_styles.dart';
import 'package:minimax/res/translations/string_keys.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(mainModalRadius)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: extraLarge, horizontal: large),
        color: white,
        child: Column(
          children: [
            _buildWelcomeTo(),
            large.toSpace(),
            _buildMinimaLogo(),
            extraLarge.toSpace(),
            _buildMinimaSentence(),
            extraLarge.toSpace(),
            _buildSetUpYourPhone(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeTo() {
    return Text(
      StringKeys.homeWelcomeTitle.tr,
      style: lmBodyCopy.copyWith(
        color: coreBlackContrast,
      ),
    );
  }

  Widget _buildMinimaLogo() {
    return SvgPicture.asset(
      ImageKeys.minimaLogoLandscape1,
      height: 51,
    );
  }



  Widget _buildMinimaSentence() {
    return Text(
      StringKeys.homeMinimaSentence.tr,
      style: lmBodyCopy.copyWith(
        color: coreBlackContrast,
      ),
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

  
}
