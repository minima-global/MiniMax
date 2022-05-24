import 'package:flutter/services.dart';

class BackgroundService {
  final MethodChannel _methodChannel;

  BackgroundService(this._methodChannel);

  void startBackgroundService(bool runInBackgroundEvenWhenKilled, {bool force = false}) {
    _methodChannel.invokeMethod("startMinimaService", {
      "runInBackgroundEvenWhenKilled": runInBackgroundEvenWhenKilled,
      "force": force,
    });
  }

  Future<T?> runCommand<T>({required String command, required bool showInConsole}) {
    return _methodChannel.invokeMethod<T>(
      "runCommand",
      {"command": command, "show_in_console": showInConsole},
    );
  }

  void clearConsole() {
    _methodChannel.invokeMethod("clearTerminal");
  }

  Future<String?> getIncentiveCashInfo(String nodeId) {
    return runCommand(
      command: "incentivecash uid:$nodeId",
      showInConsole: false,
    );
  }

  Future<String?> getNodeStatus() {
    return runCommand(
      command: "status",
      showInConsole: false,
    );
  }

  Future enableRPC() {
    return runCommand(
      command: "rpc enable:true",
      showInConsole: false,
    );
  }
}
