import 'package:flutter/material.dart';
import 'View/Quiz/drag_and_drop.dart';
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
      home: const DragAndDrop(),
    );
  }
}
