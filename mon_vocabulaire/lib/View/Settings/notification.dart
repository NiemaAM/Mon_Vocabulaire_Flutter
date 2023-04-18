import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mon_vocabulaire/Widgets/icon_widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mon_vocabulaire/Services/local_notification_service.dart';

class NotificationPage extends StatelessWidget {
  static const keyNotification = 'key-notification';

  LocalNotificationService localNotificationService =
      LocalNotificationService();

  Widget buildNotification() => SwitchSettingsTile(
        settingKey: keyNotification,
        leading: IconWidget(icon: Icons.notifications, color: Colors.green),
        title: 'Notification',
        onChange: (isNotification) {
          (isNotification)
              ? localNotificationService.showNotification(
                  "Tu nous as manqué", "Il y a encore des mots à decouverire ")
              : localNotificationService.stopNotifications();
        },
      );

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildNotification(),
        ],
      );
}
