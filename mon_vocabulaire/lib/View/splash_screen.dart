import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';

import '../Model/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;
  //TODO: change this user tester to user from database
  User user = User(
      id: 1,
      name: "salma",
      image: "https://cdn-icons-png.flaticon.com/512/3371/3371919.png",
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
        1: true,
        2: false,
        3: false,
        4: true,
        5: true,
        6: false,
        7: true,
        8: false,
        9: false,
        10: true,
        11: true,
        12: false,
      });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
  }

  void goHome() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(
            user: user,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    goHome();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.maxFinite,
            height: double.maxFinite,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _opacity,
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              // ignore: unnecessary_string_interpolations
                              image: AssetImage("assets/logo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Mon vocabulaire",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Image.asset(
                "assets/logo_ministere.png",
                scale: 4,
              ),
            ),
          )
        ],
      ),
    );
  }
}
