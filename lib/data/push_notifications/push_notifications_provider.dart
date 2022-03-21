import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:minimax/res/translations/string_keys.dart';
import 'package:minimax/utils/extensions/iterable_extensions.dart';
import 'package:minimax/utils/extensions/object_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class PushNotificationsProvider {
  static final AndroidNotificationChannel _updatesChannel = AndroidNotificationChannel(
    'updates_channel',
    StringKeys.updatesNotificationsChannel.tr,
    importance: Importance.max,
  );

  static final AndroidNotificationChannel _regularChannel = AndroidNotificationChannel(
    'regular_channel',
    StringKeys.regularNotificationsChannel.tr,
    importance: Importance.max,
  );

  static final List<AndroidNotificationChannel> channels = [_updatesChannel, _regularChannel];

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  PushNotificationsProvider() {
    _initFirebase();
  }

  void _initFirebase() {
    Firebase.initializeApp().then((_) {
      _createChannel(_updatesChannel);
      _createChannel(_regularChannel);

      _setOnLocalNotificationOpened();
      _setOnMessageOnForeground();
      _checkIfNotificationWasOpenedFromTerminatedApp();
    });
  }

  void _createChannel(AndroidNotificationChannel channel) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  void _setOnMessageOnForeground() {
    FirebaseMessaging.instance.getToken(); // Bug, needed to be able to listen. No need to wait.
    FirebaseMessaging.onMessage.listen(_onMessageReceived);
    FirebaseMessaging.onMessageOpenedApp.listen((message) => _onMessageOpened(message.data));
  }

  Future<void> _onMessageReceived(RemoteMessage message) {
    return message.notification?.let(
          (notification) =>
              channels
                  .firstOrNull(
                    (channel) => channel.id == (notification.android?.channelId ?? _regularChannel.id),
                  )
                  .let(
                    (channel) => flutterLocalNotificationsPlugin.show(
                      notification.hashCode,
                      notification.title,
                      notification.body,
                      NotificationDetails(
                        android: AndroidNotificationDetails(
                          channel.id,
                          channel.name,
                          icon: "ic_notification",
                        ),
                      ),
                      payload: message.data.let((it) => jsonEncode(it)),
                    ),
                  ) ??
              Future.value(),
        ) ??
        Future.value();
  }

  void _onMessageOpened(Map<String, dynamic> data) {
    String? urlToGo = data['url'];
    if (urlToGo != null) {
      launch(urlToGo);
    }
  }

  void _setOnLocalNotificationOpened() {
    const InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings("ic_notification"),
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (payload) {
      payload?.let((it) => cast<Map<String, dynamic>>(jsonDecode(it)))?.let(_onMessageOpened);
    });
  }

  void _checkIfNotificationWasOpenedFromTerminatedApp() {
    FirebaseMessaging.instance //
        .getInitialMessage()
        .then((remoteMessage) => remoteMessage?.data.let(_onMessageOpened));
  }
}
