import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';

class Ferme extends StatefulWidget {
  const Ferme({super.key});

  @override
  State<Ferme> createState() => _FermeState();
}

class _FermeState extends State<Ferme> {
  bool _isCowClicked = false;
  bool _isHorClicked = false;
  bool _isChiClicked = false;
  bool _isTorClicked = false;
  bool _isTreeClicked = false;
  bool _isPouClicked = false;
  int countdown = 10;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;

  void startTimer() {
    {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          countdown--;
          if (countdown == 4) {
            Sfx.play("audios/sfx/race_start.mp3", 1);
          }
          if (countdown < 0) {
            duration--;
            if (duration == 0) {
              timer.cancel();
            }
          }
        });
      });
    }
  }

  void endGame() {
    if (duration > 0) {
      _controllerConfetti.play();
      Sfx.play("audios/sfx/win.mp3", 1);
    } else {
      Sfx.play("audios/sfx/lose.mp3", 1);
    }

    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      customHeader: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: duration > 0 ? Palette.yellow : Palette.red,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Icon(
          duration > 0 ? Icons.star_rounded : Icons.timer,
          color: Palette.white,
          size: 80,
        ),
      ),
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            duration > 0
                ? "Très bon travail !"
                : "Oh non, le temps est écoulé !",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Palette.pink,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            duration > 0
                ? "Bravo, tu as trouvé tous les animaux !"
                : "Tu y étais presque, essaye encore une fois",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          duration > 0
              ? "assets/images/mascotte/win.gif"
              : "assets/images/mascotte/lose.gif",
          scale: 4,
        ),
      ]),
      btnCancelIcon: Icons.home,
      btnCancelText: " ",
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnOkIcon: Icons.restart_alt_rounded,
      btnOkText: " ",
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Ferme(),
          ),
        );
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();

    AudioBK.pauseBK();

    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.pause();
    _timer.cancel();
    AudioBK.playBK();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Sfx.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    AudioBK.pauseBK();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/search.png",
              width: 40,
            ),
            const Text(
              "  Trouvaille",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SafeArea(
            child: Stack(children: [
              LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                animation: true,
                lineHeight: 10,
                animationDuration: 0,
                percent: duration / 60,
                barRadius: const Radius.circular(0),
                progressColor: duration >= 30
                    ? Palette.lightGreen
                    : duration <= 15
                        ? Palette.red
                        : Palette.orange,
                backgroundColor: Theme.of(context).shadowColor,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: BubbleMessage(
                  widget: countdown > 0
                      ? Text(
                          "Trouvez l'animal dans : $countdown",
                          style: const TextStyle(
                              color: Color(0xFF0E57AC), fontSize: 15),
                        )
                      : Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 10),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.volume_up,
                                  color: Color(0xFF0E57AC),
                                  size: 35,
                                ),
                              ),
                            ),
                            Text(
                              "Un chien",
                              style: const TextStyle(
                                  color: Color(0xFF0E57AC), fontSize: 25),
                            ),
                          ],
                        ),
                  // widget:
                ),
              ),
            ]),
          ),
          Stack(
            children: [
              Container(
                width: width * 0.9,
                height: height > 800 ? height * 0.65 : height * 0.6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/games/backgrounds/ferme.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(children: [
                  //tortue
                  Positioned(
                    top: height > 800 ? height - 580 : height - 520,
                    right: width > 550 ? width - 500 : width - 300,
                    child: GestureDetector(
                        onTap: () {
                          _isTorClicked = true;
                          print("tortue");
                        },
                        child: Image.asset(
                          'assets/images/pics/156.png',
                          width: 50,
                          height: 50,
                        )),
                  ),

                  //cheval
                  Positioned(
                      top: height > 800 ? height - 1000 : height - 820,
                      right: width > 550 ? width - 500 : width - 300,
                      bottom: 1,
                      child: GestureDetector(
                        onTap: () {
                          _isHorClicked = true;
                          print("horse");
                        },
                        child: Image.asset(
                          'assets/images/pics/133.png',
                          height: 80,
                          width: 80,
                        ),
                      )),

                  //niche
                  Positioned(
                      top: height > 800 ? height - 920 : height - 785,
                      right: width > 500 ? width - 180 : width - 120,
                      bottom: 1,
                      child: Image.asset(
                        'assets/images/pics/145.png',
                        height: 80,
                        width: 80,
                      )),

                  //arbre
                  Positioned(
                      top: height > 800 ? height - 1200 : height - 1050,
                      right: width > 550 ? width - 350 : width - 250,
                      bottom: -180,
                      child: GestureDetector(
                        onTap: () {
                          _isTreeClicked = true;
                          print("tree");
                        },
                        child: Image.asset(
                          'assets/images/pics/2.png',
                          height: 200,
                          width: 200,
                        ),
                      )),

                  //vache
                  Positioned(
                    top: height > 800 ? height - 1050 : height - 900,
                    right: width > 550 ? width - 360 : width - 250,
                    bottom: -180,
                    child: GestureDetector(
                        onTap: () {
                          _isPouClicked = true;
                          print("cow");
                        },
                        child: Image.asset(
                          'assets/images/pics/148.png',
                          height: 110,
                          width: 110,
                        )),
                  ),
                  //mouton
                  Positioned(
                      top: height > 800 ? height - 990 : height - 800,
                      right: width > 550 ? width - 380 : width - 250,
                      bottom: -180,
                      child: Image.asset(
                        'assets/images/pics/144.png',
                        height: 80,
                        width: 80,
                      )),

                  //Poulailler
                  Positioned(
                      top: height > 800 ? height - 850 : height - 700,
                      right: width > 550 ? width - 220 : width - 150,
                      bottom: -180,
                      child: Image.asset(
                        'assets/images/pics/126.png',
                        height: 80,
                        width: 80,
                      )),

                  //poule
                  Positioned(
                      top: height > 800 ? height - 800 : height - 650,
                      right: width > 550 ? width - 340 : width - 250,
                      bottom: -180,
                      child: GestureDetector(
                        onTap: () {
                          _isChiClicked = true;
                          print("chicken");
                        },
                        child: Image.asset(
                          'assets/images/pics/127.png',
                          height: 60,
                          width: 60,
                        ),
                      )),

                  //coq
                  Positioned(
                      top: height > 800 ? height - 750 : height - 600,
                      right: width > 550 ? width - 300 : width - 230,
                      bottom: -180,
                      child: Image.asset(
                        'assets/images/pics/121.png',
                        height: 70,
                        width: 70,
                      )),

                  //chien
                  Positioned(
                      top: height > 800 ? height - 1050 : height - 915,
                      right: width > 550 ? width - 150 : width - 90,
                      bottom: -180,
                      child: Image.asset(
                        'assets/images/pics/135.png',
                        width: 30,
                        height: 30,
                      )),

                  // //poussin1
                  // Positioned(
                  //     top: height > 800 ? height - 700 : height - 610,
                  //     right: width > 550 ? width - 350 : width - 290,
                  //     bottom: -180,
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         print("poussin");
                  //         _isTreeClicked = true;
                  //       },
                  //       child: Image.asset(
                  //         'assets/images/pics/128.png',
                  //         height: 30,
                  //         width: 30,
                  //       ),
                  //     )),
                ]),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'assets/images/pics/156.png',
                  height: 40,
                  width: 40,
                  color: _isTorClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/148.png',
                  height: 75,
                  width: 75,
                  color: _isCowClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/133.png',
                  height: 75,
                  width: 75,
                  color: _isHorClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/127.png',
                  height: 50,
                  width: 50,
                  color: _isChiClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/128.png',
                  height: 45,
                  width: 45,
                  color: _isPouClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/2.png',
                  height: 75,
                  width: 75,
                  color: _isTreeClicked ? null : Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
