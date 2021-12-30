import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ConsolePlatformView extends StatelessWidget {
  const ConsolePlatformView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return AndroidView(
      viewType: "TerminalPlatformView",
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }

}