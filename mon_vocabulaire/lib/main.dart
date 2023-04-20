import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Settings/settingsPage2.dart';
import 'package:provider/provider.dart';
import 'View/splash_screen.dart';
import 'package:mon_vocabulaire/Provider/theme.provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mon vocabulaire',
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: const SettingsPage2(),
          );
        },
      );
}
