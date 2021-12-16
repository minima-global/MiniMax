import 'package:flutter/services.dart';

Future<void> hapticFeedback() async {
  await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
}
