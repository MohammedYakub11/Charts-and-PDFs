import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_testings/Firebase%20Notification/notification_service.dart';

class NotificationHomeScreen extends StatefulWidget {
  const NotificationHomeScreen({super.key});

  @override
  State<NotificationHomeScreen> createState() => _NotificationHomeScreenState();
}

class _NotificationHomeScreenState extends State<NotificationHomeScreen> {

  NotificationServices notificationServices = NotificationServices();

  @override
  void initState(){
    super.initState();
    notificationServices.requestNotificationPermission();
    // notificationServices.isTokenRefresh();
    notificationServices.firebaseInit();
    notificationServices.getDeviceToken().then((value){
      print('device token');
      print(value);
    });
  }

  void showFlutterNotification(RemoteMessage message){
    RemoteNotification? remoteNotification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    print('NOTIFICATION TITLE : ' + remoteNotification!.title.toString());

    showModalBottomSheet(context: context, builder: ((context){
      return Container(
        child: Column(
          children: [
            Text(remoteNotification.title!),
          ],
        ),
      );
    }
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Notification Home Screen"),
          ],
        ),
      ),
    );
  }
}
