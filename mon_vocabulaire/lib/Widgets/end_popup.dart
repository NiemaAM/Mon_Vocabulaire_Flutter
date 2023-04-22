import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import 'button.dart';

class EndPopup extends StatefulWidget {
  const EndPopup({super.key});

  @override
  State<EndPopup> createState() => _EndPopupState();
}

class _EndPopupState extends State<EndPopup> {
  bool isPlaying = false;
  final controller = ConfettiController();
  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: SizedBox(
          height: 340,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 260,
                  decoration: const BoxDecoration(
                    color: Palette.lightGrey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Oh non ...",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Palette.pink),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(3),
                                child: Text(
                                  "Tu n'as plus de coeurs",
                                  style: TextStyle(
                                      color: Palette.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Icon(
                                    Icons.heart_broken,
                                    color: Palette.pink,
                                  )),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/xx.gif',
                            scale: 4.1,
                          ),
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
                      Icons.library_books,
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
