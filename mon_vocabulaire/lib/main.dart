import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:mon_vocabulaire/pages/quiz_page.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'Widgets/button.dart';
=======
import 'package:mon_vocabulaire/View/home.dart';
import 'package:mon_vocabulaire/View/themes.dart';

import 'View/Quiz/quiz_text_images.dart';
import 'View/account.dart';
import 'View/lesson_path.dart';
import 'View/sub_themes.dart';
>>>>>>> Stashed changes

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mon vocabulaire',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Quiz(),
    );
  }
}
