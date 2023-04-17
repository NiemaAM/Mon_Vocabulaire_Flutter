import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/message_mascotte.dart';
import 'View/splash_screen.dart';

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
        home: BubbleMessage(
            message:
                "Nous devons prendre soin des animaux en les traitant avec gentillesse et respect !"));
  }
}
