import 'package:flutter/services.dart';

class BackgroundService {
  final MethodChannel _methodChannel;

  BackgroundService(this._methodChannel);

  void startBackgroundService() {
    _methodChannel.invokeMethod("startMinimaService");
  }

  void runCommand({required String command, required bool showInConsole}) {
    _methodChannel.invokeMethod(
      "runCommand",
      {"command": command, "show_in_console": showInConsole},
    );
  }

  void clearConsole() {
    _methodChannel.invokeMethod("clearTerminal");
  }
}
