import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/foret.dart';

import 'package:mon_vocabulaire/View/Home/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Themes/theme_provider.dart';
import 'View/Games/Trouvaille/acceuil_themes.dart';
import 'View/Games/Trouvaille/ferme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  User user = User(
      id: 1,
      name: "salma",
      image: "assets/images/avatars/avatar_girl.png",
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
        1: 1,
        2: 2,
        3: 2,
        4: 1,
        5: 1,
        6: 2,
        7: 1,
        8: 2,
        9: 2,
        10: 1,
        11: 0,
        12: 2,
      },
      status_per_Subtheme: {
        1: {1: true},
        1: {2: true},
        1: {3: false},
        1: {4: false},
        1: {5: false},
        2: {1: true},
        2: {2: true},
        2: {3: false},
        2: {4: false},
        2: {5: false},
        3: {1: true},
        3: {2: true},
        3: {3: false},
        3: {4: false},
        3: {5: false},
        4: {1: true},
        4: {2: true},
        4: {3: true},
        4: {4: true},
        4: {5: true},
        5: {1: true},
        5: {2: true},
        5: {3: false},
        5: {4: false},
        5: {5: false},
        6: {1: true},
        6: {2: true},
        6: {3: false},
        6: {4: false},
        6: {5: false},
        7: {1: true},
        7: {2: true},
        7: {3: false},
        7: {4: false},
        7: {5: false},
        8: {1: true},
        8: {2: true},
        8: {3: false},
        8: {4: false},
        8: {5: false},
        9: {1: true},
        9: {2: true},
        9: {3: false},
        9: {4: false},
        9: {5: false},
        10: {1: true},
        10: {2: true},
        10: {3: false},
        10: {4: false},
        10: {5: false},
        11: {1: true},
        11: {2: true},
        11: {3: false},
        11: {4: false},
        11: {5: false},
        12: {1: true},
        12: {2: true},
        12: {3: false},
        12: {4: false},
        12: {5: false},
      });

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
            home: TrouvailleThemes(
              user: user,
            ),
          );
        },
      ),
    );
  }
}
