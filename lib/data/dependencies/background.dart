import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:minimax/data/dependencies/persistence.dart';

class BackgroundService {
  final MethodChannel _methodChannel;
  final MinimaStorage _storage;

  BackgroundService(this._methodChannel, this._storage);

  void startBackgroundService() {
    _methodChannel.invokeMethod("startMinimaService");
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
}
