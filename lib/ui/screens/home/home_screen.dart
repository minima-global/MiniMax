import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/ui/screens/home/home_controller.dart';
import 'package:minimax/ui/widgets/backgrounds.dart';

class HomeScreen extends GetWidget<HomeController> {
  static const String routeName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: withGlossyBackground(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Text("HOME");
  }
}
