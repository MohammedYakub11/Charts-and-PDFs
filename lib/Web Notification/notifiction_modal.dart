import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class NotificationList {
  final String title;
  final String body;

  NotificationList({required this.title, required this.body});

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    return NotificationList(
      title: json['title'] ?? '', // Provide a default value if null
      body: json['body'] ?? '', // Provide a default value if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
    };
  }
}

class NotificationService {
  Future<List<NotificationList>> fetchNotifications() async {
    try {
      final response = await rootBundle.loadString('assets/sample.json');
      print('File loaded successfully'); // Debug log

      final List<dynamic> data = json.decode(response);
      print('JSON decoded successfully: $data'); // Debug log

      return data.map((json) => NotificationList.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching notifications: $e'); // Debug log
      return [];
    }
  }

  Future<List<NotificationList>> removeNotification(String titleToRemove) async {
    try {
      // Load the existing data
      final response = await rootBundle.loadString('assets/sample.json');
      print('File loaded successfully'); // Debug log

      final List<dynamic> data = json.decode(response);
      print('JSON decoded successfully: $data'); // Debug log

      // Convert JSON data to a list of NotificationList objects
      List<NotificationList> notifications = data.map((json) => NotificationList.fromJson(json)).toList();

      // Remove the notification with the given title
      notifications.removeWhere((notification) => notification.title == titleToRemove);

      // Convert the updated list back to JSON
      final updatedJson = json.encode(notifications.map((notification) => notification.toJson()).toList());

      // Optionally, save the updated list back to the file or another storage
      // For example, you could use the path_provider package to write to a file:
      // final directory = await getApplicationDocumentsDirectory();
      // final file = File('${directory.path}/sample.json');
      // await file.writeAsString(updatedJson);

      return notifications;
    } catch (e) {
      print('Error removing notification: $e'); // Debug log
      return [];
    }
  }
}
