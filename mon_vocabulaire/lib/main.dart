import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/pages/quiz_page.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'Widgets/button.dart';

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
