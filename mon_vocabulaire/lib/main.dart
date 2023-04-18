import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:mon_vocabulaire/View/Settings/heather_page.dart';
import 'package:mon_vocabulaire/View/Settings/notification.dart';
import 'package:mon_vocabulaire/View/Settings/settings_page.dart';
import 'View/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Settings.getValue<bool>(HeaderPage.keyDarkMode, true);
    final isNotification =
        Settings.getValue<bool>(NotificationPage.keyNotification, true);

    return ValueChangeObserver<bool>(
      cacheKey: HeaderPage.keyDarkMode,
      defaultValue: true,
      builder: (_, isDarkMode, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mon vocabulaire',
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
                primaryColor: Colors.teal,
                accentColor: Colors.green,
                scaffoldBackgroundColor: Color(0xFF170635),
                canvasColor: Color(0xFF170635),
              )
            : ThemeData.light().copyWith(accentColor: Colors.green),
        //ThemeData(
        // primarySwatch: Colors.blue,
        // ),
        home: const SettingsPage(),
      ),
    );
  }
}
