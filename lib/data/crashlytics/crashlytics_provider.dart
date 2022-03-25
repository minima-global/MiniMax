import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CrashlyticsProvider {
  CrashlyticsProvider() {
    Firebase.initializeApp().then(
      (_) {
        if (!kDebugMode) {
          FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
        }
      },
    );
  }
}
