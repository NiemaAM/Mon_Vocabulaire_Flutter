import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Home/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DataBase/db.dart';
import 'Themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SharedPreferences.getInstance();
  /*  final dbHelper = DatabaseHelper();
  final database = await dbHelper.initDb(); */

// Retrieve a subtheme from the database
  /*  final subthemeId = 1; // Replace with the desired subtheme ID
  final subtheme = await database
      .query('Sub_Themes', where: 'id_sub_theme = ?', whereArgs: [subthemeId]);
  if (subtheme.isNotEmpty) {
    final subthemeName = subtheme.first['name_sub_theme'];
    print('Subtheme: $subthemeName');
  } else {
    print('Subtheme not found');
  }

  await database.close(); */
  runApp(const MyApp());
  DatabaseHelper();
  await DatabaseHelper().insertData_subtheme_quiz();
  //List<User> allData = await DatabaseHelper().getUsers();
 // User user = User(name: 'NOURA', image: 'image', current_level: 2, coins: 100);
  //await DatabaseHelper().addUser(user);
  //print("ok");
  //print(await DatabaseHelper().getUsers());
  //print(allData[1].toMap());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
