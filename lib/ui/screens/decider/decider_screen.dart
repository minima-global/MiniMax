import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/ui/screens/decider/decider_controller.dart';
import 'package:minimax/ui/screens/decider/model/decider_model.dart';
import 'package:minimax/ui/screens/home/home_screen.dart';
import 'package:minimax/ui/screens/set_up/set_up_screen.dart';
import 'package:minimax/utils/extensions/rxn_extensions.dart';

class DeciderScreen extends GetWidget<DeciderController> {
  static const String routeName = "/decider";

  const DeciderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.decider.listenWhenNotNull(_onDecision);

    return Scaffold(
      backgroundColor: backgroundColour,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return const Center(
      child: CircularProgressIndicator(
        color: coreBlue100,
      ),
    );
  }

  void _onDecision(DeciderModel decision) {
    switch (decision) {
      case DeciderModel.setUp:
        Get.offNamed(SetUpScreen.routeName);
        break;
      case DeciderModel.goMain:
        Get.offNamed(HomeScreen.routeName);
        break;
    }
  }
}
