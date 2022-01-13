import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:minimax/data/injector/injector.dart';
import 'package:minimax/res/styles/styles.dart';
import 'package:minimax/res/translations/translations.dart';
import 'package:minimax/routing/get_pages.dart';
import 'package:minimax/ui/screens/decider/decider_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  runApp(const MiniMaxApp());
}

class MiniMaxApp extends StatelessWidget {
  const MiniMaxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.downToUp,
      translations: MiniMaxTranslations(),
      locale: const Locale.fromSubtags(languageCode: "en"),
      debugShowCheckedModeBanner: false,
      theme: generateAppTheme(),
      getPages: getPages,
      home: const DeciderScreen(),
    );
  }
}
