import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimax/data/injector/injector.dart';
import 'package:minimax/res/styles/styles.dart';
import 'package:minimax/res/translations/translations.dart';
import 'package:minimax/routing/get_pages.dart';
import 'package:minimax/ui/screens/decider/decider_screen.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await inject();
      runApp(const MiniMaxApp());
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}

class MiniMaxApp extends StatelessWidget {
  const MiniMaxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      translations: MiniMaxTranslations(),
      locale: const Locale.fromSubtags(languageCode: "en"),
      debugShowCheckedModeBanner: false,
      theme: generateAppTheme(),
      getPages: getPages,
      home: const DeciderScreen(),
    );
  }
}
