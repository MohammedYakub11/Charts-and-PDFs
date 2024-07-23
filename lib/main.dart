import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_testings/home_screen.dart';
import 'package:flutter_testings/radar_map/checkIn.dart';
import 'package:flutter_radar/flutter_radar.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'Admin Shift Roster Table/admin_shift_roster_table.dart';
import 'Firebase Notification/firebase_notification_home_screen.dart';
import 'Pages/leave_apply.dart';
import 'Push Notification/notification_screen.dart';
import 'Push Notification/notification_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Web Notification/web_notification_home_screen.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //           apiKey: "AIzaSyABkBdLx2p3VpUY8G1ZM3SLgy-mBT1aD7U",
  //           authDomain: "flutter-sample-project-318a4.firebaseapp.com",
  //           projectId: "flutter-sample-project-318a4",
  //           storageBucket: "flutter-sample-project-318a4.appspot.com",
  //           messagingSenderId: "1085982793073",
  //           appId: "1:1085982793073:web:3aeee2b0e3d3519967ead0"));
  // } else {
  //   await Firebase.initializeApp();
  // }

  await NotificationWidget.init();
  tz.initializeTimeZones();
  // if (!kIsWeb) {
  //   try {
  //     await Radar.initialize(
  //         'prj_live_pk_237943c3d2e1d87e898141fbcae9986da35303e3');
  //   } catch (e) {
  //     print('Error initializing Radar SDK: $e');
  //   }
  // }

  runApp(const ProviderScope(child: MyApp()));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: NotificationHomeScreen(),
      navigatorKey: navigatorKey,
    );
  }
}
