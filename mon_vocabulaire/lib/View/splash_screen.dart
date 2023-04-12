import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0;
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
          builder: (context) => const Home(),
        ),
      );
    });
  }

   @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    goHome();
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _opacity,
              child: Column(
                children: [
                  Container(
                    width: width / 3,
                    height: width / 3,
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
    );
  }
}
