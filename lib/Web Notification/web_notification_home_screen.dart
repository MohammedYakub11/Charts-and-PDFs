import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter_testings/constants/colors.dart';
import 'notifiction_modal.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<NotificationList>> _notifications;
  OverlayEntry? _overlayEntry;
  List<NotificationList>? _notificationList;

  @override
  void initState() {
    super.initState();
    _notifications = NotificationService().fetchNotifications();
  }

  void _showOverlay(BuildContext context, Offset offset) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + 50, // Adjust this value as needed
        left: offset.dx - 220,
        child: Material(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15.0),
            width: 250, // Adjust width as needed
            height: 350, // Adjust height as needed
            child: FutureBuilder<List<NotificationList>>(
              future: _notifications,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  developer.log('Error: ${snapshot.error}',
                      name: 'NotificationPage');
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  _notificationList = snapshot.data;
                  return ListView.builder(
                    itemCount: _notificationList?.length ?? 0,
                    itemBuilder: (context, index) {
                      final notification = _notificationList![index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: ListTile(
                          title: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.mainTheme,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(notification.body),
                          ),
                          // leading: CircleAvatar(
                          //   backgroundImage: NetworkImage(notification.imageUrl),
                          // ),
                          onTap: () {
                            // Handle notification tap
                            final titleToRemove = notification.title;
                            setState(() {
                              _notificationList!.removeAt(index);
                              // Update future with the modified list
                              _notifications = Future.value(_notificationList!);
                            });

                            // Remove from the data source
                            NotificationService()
                                .removeNotification(titleToRemove)
                                .catchError((e) {
                              developer.log(
                                  'Error removing notification from data source: $e',
                                  name: 'NotificationPage');
                            });

                            // Optionally remove the overlay
                            _overlayEntry?.remove();
                            _overlayEntry = null;
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No notifications'));
                }
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notifications'),
        actions: [
          FutureBuilder<List<NotificationList>>(
            future: _notifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                developer.log('Error: ${snapshot.error}',
                    name: 'NotificationPage');
                return IconButton(
                  icon: Icon(Icons.notifications_none_sharp,
                      color: AppColors.mainTheme, size: 27),
                  onPressed: () {},
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Stack(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications_none_sharp,
                          color: AppColors.mainTheme, size: 27),
                      onPressed: () {
                        final RenderBox renderBox =
                            context.findRenderObject() as RenderBox;
                        final Offset offset =
                            renderBox.localToGlobal(Offset.zero);
                        _showOverlay(context, offset);
                      },
                    ),
                    Positioned(
                      right: 10,
                      top: 11,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 8,
                          minHeight: 8,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.notifications_none_sharp,
                      color: AppColors.mainTheme, size: 27),
                  onPressed: () {
                    final RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    final Offset offset = renderBox.localToGlobal(Offset.zero);
                    _showOverlay(context, offset);
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Home Page Content'),
      ),
    );
  }
}
