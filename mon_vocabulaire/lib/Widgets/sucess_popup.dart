import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import 'button.dart';

class SucessPopup extends StatefulWidget {
  const SucessPopup({super.key});

  @override
  State<SucessPopup> createState() => _SucessPopupState();
}

class _SucessPopupState extends State<SucessPopup>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final controller = ConfettiController();
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animation = Tween(begin: 1.0, end: 1.2).animate(_animationController);

    controller.play();

    _animationController.forward();

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed)
        _animationController.reverse();
      else if (status == AnimationStatus.dismissed)
        _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 40,
      backgroundColor: Colors.transparent,
      child: SizedBox(
          height: 370,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: controller,
                  shouldLoop: true,
                  blastDirectionality:
                      BlastDirectionality.explosive, //deriction up -pi / 2
                  numberOfParticles: 10, //par defaut 10
                  // minBlastForce: 1,
                  maxBlastForce: 30,
                  emissionFrequency: 0.05,
                  //set speed
                  //gravity: 0.5,
                  colors: const [
                    Palette.lighterGreen,
                    Color.fromARGB(255, 214, 26, 231),
                    Palette.pink,
                    Palette.indigo,
                    Palette.yellow,
                    Palette.orange
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Palette.lightGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "Bien Joué !",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Palette.pink),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(3),
                                child: Image.asset(
                                  'assets/images/ff.gif',
                                  scale: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 43),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "Terminé en",
                                  style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "10",
                                  style: TextStyle(
                                      color: Palette.pink,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "minutes",
                                  style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    Icons.timer_outlined,
                                    color: Palette.blue,
                                  )),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Palette.orange,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "20",
                                style: TextStyle(
                                    color: Palette.orange,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "pièces",
                                style: TextStyle(
                                    color: Palette.orange,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3),
                              child: Image.asset(
                                'assets/themes_images/coin.png',
                                scale: 20,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 25),
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Palette.lightGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "40",
                                style: TextStyle(
                                    color: Palette.lightGreen,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "mots",
                                style: TextStyle(
                                    color: Palette.lightGreen,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 13),
                                child: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Palette.lightGreen,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 19, bottom: 105),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: ScaleTransition(
                        scale: _animation,
                        child: Image.asset(
                          'assets/logo.png',
                          scale: 8.6,
                        ),
                      )),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Button(
                    callback: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    content: const Icon(
                      Icons.home_rounded,
                      color: Palette.white,
                    ),
                    width: 60,
                    heigth: 60,
                    color: Palette.pink,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 8),
                  child: Button(
                    callback: () {
                      Navigator.pop(context);
                    },
                    content: const Icon(
                      Icons.restart_alt_rounded,
                      color: Palette.white,
                    ),
                    width: 60,
                    heigth: 60,
                    color: Palette.pink,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30, bottom: 8),
                  child: Button(
                    callback: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    content: const Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: Palette.white,
                    ),
                    width: 60,
                    heigth: 60,
                    color: Palette.pink,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
