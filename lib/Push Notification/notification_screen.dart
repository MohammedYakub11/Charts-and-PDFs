import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'notification_widget.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    NotificationWidget.init();
    tz.initializeTimeZones();
    _scheduleNotifications();
  }

  void _scheduleNotifications() {
    // Schedule the 10:30 AM notification
    _scheduleNotification(
      id: 0,
      title: 'Reminder!! Testing',
      body: 'Good morning! Have a great day!',
      scheduledTime:
      tz.TZDateTime.from(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          14,
          19,
          0,
        ),
        tz.local,
      ),
    );

    // Schedule the 7:30 PM notification
    _scheduleNotification(
      id: 1,
      title: 'Evening Notification',
      body: 'Good evening! Enjoy your evening!',
      scheduledTime: tz.TZDateTime.from(
        DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          18,
          23,
          0,
        ),
        tz.local,
      ),
    );
  }

  void _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledTime,
  }) {
    print('Scheduling notification with id $id at $scheduledTime');

    NotificationWidget.showScheduleNotification(
      id: id,
      title: title,
      body: body,
      scheduledTime: scheduledTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text("Reminder for Check in time."),
          ]),
        ),
      ),
    );
  }
}
