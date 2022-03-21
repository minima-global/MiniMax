import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';

class TerminalController extends GetxController {
  final BackgroundService _backgroundService;

  final RxBool userHasSeenTerminalWarningAlready = RxBool(false);

  final TextEditingController runCommandController = TextEditingController();

  TerminalController(this._backgroundService);

  void runCommand() {
    if (runCommandController.text.isNotEmpty) {
      _backgroundService.runCommand(command: runCommandController.text, showInConsole: true);
      runCommandController.text = "";
    }
  }

  void clearConsole() {
    _backgroundService.clearConsole();
  }

  void warningUnderstood() {
    userHasSeenTerminalWarningAlready(true);
  }
}
