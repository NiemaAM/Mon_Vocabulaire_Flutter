import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('@drawable/ic_launcher');

  Future<void> getNotificationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? notif = prefs.getBool('notification');
    if (notif!) {
      showNotification(
          "✨ Tu nous as manqué !", "Il y a encore des mots à découvrir 🏆");
    } else {
      stopNotifications();
    }
  }

  Future<void> setNotificationState(bool state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification', state);
    getNotificationState();
  }

  Future<void> initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body) async {
    await initialiseNotifications();
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
    );
  }

  void stopNotifications() async {
    await initialiseNotifications();
    _flutterLocalNotificationsPlugin.cancel(0);
  }
}
