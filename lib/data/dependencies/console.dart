import 'package:flutter/services.dart';

class MinimaConsole {
  static List<String> messages = [];
  static Stream? streamReceiver;

  MinimaConsole(EventChannel eventChannel) {
    streamReceiver = eventChannel.receiveBroadcastStream();
    streamReceiver?.listen(
      (event) {
        messages = (event as List<dynamic>).map((e) => e.toString()).toList();
      },
      cancelOnError: false,
    );
  }
}
