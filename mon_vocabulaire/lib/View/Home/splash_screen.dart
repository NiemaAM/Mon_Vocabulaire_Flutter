// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names, equal_keys_in_map

import 'dart:async';
import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/View/Account/first_screen.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
  }

  late Timer timer;
  void goHome() {
    timer = Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        SlideButtom(page: const FirstSceen()),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
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
                  "assets/images/logo_ministere.png",
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
          AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _opacity,
            child: SizedBox(
              width: 150,
              height: 150,
              child: Animator<double>(
                  tween: Tween<double>(begin: 120, end: 150),
                  duration: const Duration(seconds: 3),
                  cycles: 0,
                  builder: (context, AnimatorState, child) => Center(
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: AnimatorState.value,
                            width: AnimatorState.value,
                            child: const Image(
                              image: AssetImage("assets/images/logo.png"),
                            )),
                      )),
            ),
          ),
          const Expanded(flex: 4, child: SizedBox()),
          const CircularProgressIndicator(
            color: Palette.lightBlue,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Mon Vocabulaire",
                style: GoogleFonts.acme(
                  textStyle: const TextStyle(
                    color: Palette.lightBlue,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
