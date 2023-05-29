import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Bureau.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Ferme.dart';
import 'package:mon_vocabulaire/View/Home/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Themes/theme_provider.dart';
import 'View/Games/Trouvaille/Foret.dart';
import 'View/Games/Trouvaille/classRoom.dart';
import 'View/Games/Trouvaille/trouvaillecour.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider()..loadTheme(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mon vocabulaire',
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            themeMode: themeProvider.themeMode,
            home: ClassRoom(),
          );
        },
      ),
    );
  }
}
