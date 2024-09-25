import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/notification_controller.dart';
import '../model/notification_model.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController _notificationController = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: _notificationController.getUserNotifications(), // Ensure you call the function here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!;
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              NotificationModel notification = notifications[index];
              return ListTile(
                title: Text(notification.type == 'like' ? 'Someone liked your post' : 'Someone commented on your post'),
                subtitle: Text(notification.timestamp.toString()), // Ensure timestamp is formatted correctly
              );
            },
          );
        },
      ),
    );
  }
}
