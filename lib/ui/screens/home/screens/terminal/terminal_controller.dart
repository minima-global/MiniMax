import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/data/dependencies/background.dart';
import 'package:minimax/data/dependencies/persistence.dart';

class TerminalController extends GetxController {
  final BackgroundService _backgroundService;
  final MinimaStorage _minimaStorage;

  final Rxn<bool> userHasSeenTerminalWarningAlready = Rxn();

  final TextEditingController runCommandController = TextEditingController();

  TerminalController(this._backgroundService, this._minimaStorage);

  @override
  void onInit() {
    super.onInit();
    _refreshWarning();
  }

  void _refreshWarning() {
    _minimaStorage.getUserSeenTerminalCopyPasteAtLeastOnce().then(userHasSeenTerminalWarningAlready);
  }

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
    _minimaStorage //
        .setUserSeenTerminalCopyPasteAtLeastOnce(true)
        .then((_) => _refreshWarning());
  }
}
