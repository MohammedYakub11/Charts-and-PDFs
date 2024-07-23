import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:elegant_notification/resources/arrays.dart';

import '../common/text_widgets.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitializationSettings = const DarwinInitializationSettings();
    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {});
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      showNotification(
        message,
      );
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(10000).toString(),
        'High Importance Notification',
        importance: Importance.max);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    //Ios handle itself. below code is sample for understanding
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentSound: true,
      presentBadge: true,
      presentAlert: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      iOS: darwinNotificationDetails,
      android: androidNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });

    RemoteNotification? remoteNotification = message.notification;
    if (kDebugMode) {
      try {
        print('NOTIFICATION TITLE  ' + remoteNotification!.title!.toString());
      } catch (e) {
        print('An error occurred: $e');
      }
    }
    ElegantNotification(
      icon: const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 30,
      ),
      description: text13Normal(
        text: remoteNotification!.body!,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      title: text15Normal(
        text: remoteNotification.title!,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      progressIndicatorColor: Colors.green,
      width: 300,
      height: 70,
      toastDuration: const Duration(seconds: 5),
      animation: AnimationType.fromRight,
      displayCloseButton: true,
    );
  }

  Future<String> getDeviceToken() async {
    try {
      String? token = await messaging.getToken();
      if (token == null) {
        throw Exception('Failed to get device token');
      }
      print('Token: $token');
      return token;
    } catch (e) {
      print('Error getting device token: $e');
      rethrow;
    }
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh token');
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      // Notifications can be displayed to the user on the device

      announcement: true,
      badge: true,
      // shows the no of notifications on the logo of the app
      carPlay: true,
      //
      criticalAlert: true,
      sound: true,
      // notificaions sounds
      provisional:
          true, // allows the user to choose whether the notifications are enabled or not
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      AppSettings.openAppSettings();
      print('user denied permission');
    }
  }
}
