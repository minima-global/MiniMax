import 'package:flutter/material.dart';
import 'package:minimax/res/styles/colours.dart';
import 'package:minimax/res/styles/dimensions.dart';

class BatterySettingsScreen extends StatelessWidget {
  const BatterySettingsScreen({Key? key}) : super(key: key);

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
            _buildTitle(),
            _buildBatterySettingsExplanation(),
            _buildConfirmButton(),
            _buildSkipButton(),
          ],
        ),
      ),
    );
  }
}