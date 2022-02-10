import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  ///Plugin to handle notifications
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notif_icon');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) => notificationSelected(payload),
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {}

  void pushNotification() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Channel ID', 'ZotPonics', 'Channel Description',
        importance: Importance.Default,
        priority: Priority.Default,
        ticker: 'Replace your nutrient water!');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    double count = 0.0;
    while (count < 2) {
      flutterLocalNotificationsPlugin.show(0, 'test', 'test notification', platformChannelSpecifics, payload: 'testing');
      count += 1;
    }
  }

  void pushScheduledNotification(String notifBody) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Channel ID', 'ZotPonics', 'Channel Description',
        importance: Importance.Default,
        priority: Priority.Default,
        ticker: 'Replace your nutrient water!');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0,
      "ZotPonics",
      notifBody,
      tz.TZDateTime.now(tz.local),
      platformChannelSpecifics,);
  }

  NotificationService._internal();

}