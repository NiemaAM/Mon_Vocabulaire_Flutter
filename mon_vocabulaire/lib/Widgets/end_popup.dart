import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import 'button.dart';

class EndPopup extends StatefulWidget {
  const EndPopup({super.key});

  @override
  State<EndPopup> createState() => _EndPopupState();
}

class _EndPopupState extends State<EndPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
          height: 320,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Palette.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 68),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Bien Joué !",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Palette.indigo),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "10",
                                  style: TextStyle(
                                      color: Palette.blue,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Palette.indigo,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(3),
                              child: Text(
                                "+",
                                style: TextStyle(
                                    color: Palette.indigo,
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
                                padding: EdgeInsets.all(3),
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
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Button(
                    callback: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Home(),
                        ),
                      );
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
              const Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.star_rounded,
                  color: Palette.white,
                  size: 120,
                ),
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.star_rounded,
                  color: Palette.white,
                  size: 120,
                ),
              ),
              const Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Icon(
                  Icons.star_rounded,
                  color: Palette.white,
                  size: 120,
                ),
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Icon(
                  Icons.star_rounded,
                  color: Palette.yellow,
                  size: 100,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.yellow,
                    size: 100,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10, top: 10),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.star_rounded,
                    color: Palette.lightGrey,
                    size: 100,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
