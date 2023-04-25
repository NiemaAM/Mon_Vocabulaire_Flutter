// ignore_for_file: equal_keys_in_map

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';
import '../Model/user.dart';
import '../Widgets/Palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;
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
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: _opacity,
                child: Image.asset(
                  "assets/logo_ministere.png",
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
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
          const Expanded(flex: 4, child: SizedBox()),
          const CircularProgressIndicator(
            color: Palette.blue,
          ),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
