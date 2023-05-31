import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Bureau.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';

class Foret extends StatefulWidget {
  const Foret({super.key});

  @override
  State<Foret> createState() => _ForetState();
}

class _ForetState extends State<Foret> {
  bool _isEleClicked = false;
  bool _isGiClicked = false;
  bool _isLiClicked = false;
  int countdown = 10;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
    int fermeObject = 0;

  late ConfettiController _controllerConfetti;
  late var randomAnimal;
  List<String> animals = ['Un lion', 'Un éléphant', 'Une giraffe'];
  String randomAnimalFunc() {
    animals.shuffle();

    if (animals.isNotEmpty) {
      randomAnimal = animals[0];
      print(randomAnimal);
      animals.removeAt(0);
    } else {
      print("Fin du jeu");
      endGame();
    }

    return randomAnimal;
  }
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
              AwesomeDialog(
              context: context,
              headerAnimationLoop: false,
              customHeader: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Palette.red,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Icon(
                  Icons.timer,
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
                    "Oh non, le temps est écoulé !",
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
                    "Tu y étais presque, essaye encore une fois",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(
              "assets/images/mascotte/lose.gif",
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
                    builder: (context) => const Foret(),
                  ),
                );
              },
            ).show();
          
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
            color:  Palette.yellow,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Icon(
          Icons.star_rounded,
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
             "Très bon travail !",
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
             "Bravo, tu as trouvé tous les animaux !",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
           "assets/images/mascotte/win.gif",
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
            builder: (context) => const Foret(),
          ),
        );
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    randomAnimalFunc();
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
                              "$randomAnimal",
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
                        AssetImage('assets/images/games/backgrounds/foret.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                    top: height > 800 ? height - 610 : height - 550,
                    right: width > 550 ? width - 500 : width - 300,
                    child: Image.asset(
                      'assets/images/games/monkey.png',
                      height: 70,
                      width: 70,
                    ),
                  ),

                  //snake
                  Positioned(
                    bottom: height > 800 ? height - 900 : height - 750,
                    right: width > 550 ? width - 300 : width - 220,
                    child: Image.asset(
                      'assets/images/games/snake.png',
                      height: 70,
                      width: 70,
                    ),
                  ),
                  //owel
                  Positioned(
                    top: height > 800 ? height - 800 : height - 750,
                    right: width > 550 ? width - 250 : width - 200,
                    child: Image.asset(
                      'assets/images/games/owel.png',
                      height: 90,
                      width: 90,
                    ),
                  ),
                  //LION
                  Positioned(
                    top: height > 800 ? height - 700 : height - 600,
                    right: width > 550 ? width - 600 : width - 400,
                    bottom: 1,
                    child: GestureDetector(
                        onTap: () {
                          var animal = "Un lion";
                          if (animal == randomAnimal) {
                            _isLiClicked = true;
                            print("You win");
                             fermeObject++;
                            setState(() {
                            if(fermeObject == 3){
                              endGame();
                            }
                          });
                            randomAnimalFunc();
                          } else {
                            print("You lose");
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/143.png',
                          height: 200,
                          width: 200,
                        )),
                  ),
                  //ELEPHANT
                  Positioned(
                    top: height > 800 ? height - 915 : height - 780,
                    right: width > 550 ? width - 350 : width - 250,
                    bottom: -180,
                    child: GestureDetector(
                        onTap: () {
                          var animal = "Un éléphant";
                          if (animal == randomAnimal) {
                            _isEleClicked = true;
                            print("You win");
                             fermeObject++;
                          setState(() {
                            if(fermeObject == 3){
                              endGame();
                            }
                          });
                            randomAnimalFunc();
                          } else {
                            print("You lose");
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/138.png',
                          height: 300,
                          width: 300,
                        )),
                  ),

                  //GIRAFF
                  Positioned(
                    top: height > 800 ? height - 800 : height - 690,
                    right: width > 500 ? width - 250 : width - 200,
                    bottom: 1,
                    child: GestureDetector(
                        onTap: () {
                          var animal = "Une giraffe";
                          if (animal == randomAnimal) {
                            _isGiClicked = true;
                            print("You win");
                            fermeObject++;
                          setState(() {
                            if(fermeObject == 3){
                              endGame();
                            }
                          });
                            randomAnimalFunc();
                          } else {
                            print("You lose");
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/140.png',
                          height: 300,
                          width: 300,
                        )),
                  ),
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
                  'assets/images/pics/138.png',
                  height: 75,
                  width: 75,
                  color: _isEleClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/140.png',
                  height: 75,
                  width: 75,
                  color: _isGiClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/143.png',
                  height: 75,
                  width: 75,
                  color: _isLiClicked ? null : Colors.black,
                ),
              ],
            ),
          )

          //monkey
        ],
      ),
    );
  }
}