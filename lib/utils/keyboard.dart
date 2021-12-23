import 'package:flutter/services.dart';

Future hideKeyboard() {
  return SystemChannels.textInput.invokeMethod('TextInput.hide');
}