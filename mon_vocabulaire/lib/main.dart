import 'package:flutter/material.dart';
import 'View/splash_screen.dart';
import 'package:mon_vocabulaire/View/Account/profil.dart';
import 'package:mon_vocabulaire/View/home.dart';

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
      home: const Home(),
    );
  }
}
