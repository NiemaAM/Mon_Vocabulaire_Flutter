import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:mon_vocabulaire/Services/local_notification_service.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mon_vocabulaire/View/Settings/heather_page.dart';
import 'package:mon_vocabulaire/View/Settings/notification.dart';
import 'package:mon_vocabulaire/Widgets/icon_widget.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:mon_vocabulaire/Model/user.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  LocalNotificationService localNotificationService =
      LocalNotificationService();

  static const keyDarkMode = 'key-dark-mode';

  static const keyNotification = 'key-notification';

  User user = User(
      id: 1,
      name: "salma",
      image: "https://cdn-icons-png.flaticon.com/512/3371/3371919.png",
      current_level: 1,
      words_per_level: {1: 120},
      coins: 20,
      words_per_subtheme: {
        1: 65,
        2: 25,
        3: 40,
        4: 28,
        5: 33,
        6: 50,
        7: 65,
        8: 25,
        9: 40,
        10: 28,
        11: 33,
        12: 50,
      },
      stars_per_subtheme: {
        1: true,
        2: false,
        3: false,
        4: true,
        5: true,
        6: false,
        7: true,
        8: false,
        9: false,
        10: true,
        11: true,
        12: false,
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotificationService.initialiseNotifications();
  }

  Widget buildLogout() => SimpleSettingsTile(
        title: 'Se déconnecter',
        subtitle: '',
        leading: IconWidget(icon: Icons.logout, color: Colors.blueAccent),
        onTap: () {
          Settings.clearCache();
        },
      );

  Widget buildDeleteAccount() => SimpleSettingsTile(
        title: 'Supprimer compte',
        subtitle: '',
        leading: IconWidget(icon: Icons.delete, color: Colors.pink),
        onTap: () {},
      );

  Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
        title: 'Report A Bug',
        subtitle: '',
        leading: IconWidget(icon: Icons.bug_report, color: Colors.teal),
        onTap: () {},
      );

  Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
        title: 'Send FeedBack',
        subtitle: '',
        leading: IconWidget(icon: Icons.thumb_up, color: Colors.purple),
        onTap: () {},
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        title: const Text("Paramètres"),
        centerTitle: true,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  user: user,
                ),
              ),
            );
          },
          icon: const Icon(Icons.home),
          tooltip: "Page d'acceuil",
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            HeaderPage(),
            SettingsGroup(
              title: 'General',
              children: <Widget>[
                NotificationPage(),
                buildLogout(),
                buildDeleteAccount(),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            SettingsGroup(
              title: 'FEEDBACK',
              children: <Widget>[
                const SizedBox(
                  height: 8,
                ),
                buildReportBug(context),
                buildSendFeedback(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
