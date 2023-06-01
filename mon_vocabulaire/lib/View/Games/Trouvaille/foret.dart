import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Bureau_Classe.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Model/user.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';

class Foret extends StatefulWidget {
  final User user;
  const Foret({super.key, required this.user});

  @override
  State<Foret> createState() => _ForetState();
}

class _ForetState extends State<Foret> {
  bool _isEleClicked = false;
  bool _isGiClicked = false;
  bool _isLiClicked = false;
  bool _canTap = false;
  int countdown = 10;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late String selectedAnimal;
  late ConfettiController _controllerConfetti;
  late var randomAnimal;
  List<String> animals = ['Un lion', 'Un éléphant', 'Une giraffe'];
  Map<String, String> animalsAudios = {
    'Un lion': "143.mp3",
    'Un éléphant': "138.mp3",
    'Une giraffe': "140.mp3"
  };
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
    //Voice.play("/", 1);
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
            _canTap = true;
            if (duration == 0) {
              timer.cancel();
              if (animals.isNotEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return GamePopup(
                      onButton1Pressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      onButton2Pressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Foret(user: widget.user),
                          ),
                        );
                      },
                      oneButton: true,
                      win: false,
                      tie: false,
                    );
                  },
                );
              }
            }
          }
        });
      });
    }
  }

  void endGame() {
    if (duration > 0) {
      _controllerConfetti.play();
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GamePopup(
          onButton1Pressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButton2Pressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Foret(user: widget.user),
              ),
            );
          },
          win: duration > 0 ? true : false,
        );
      },
    );
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

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Palette.white,
          appBar: CustomAppBarGames(
            user: widget.user,
            background: true,
          ),
          body: Column(
            children: [
              Stack(children: [
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
                              IconButton(
                                onPressed: () {
                                  Voice.play(
                                      'audios/voices/${animalsAudios['$randomAnimal']}',
                                      1);
                                },
                                icon: const Icon(
                                  Icons.volume_up,
                                  color: Color(0xFF0E57AC),
                                  size: 35,
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
              Stack(
                children: [
                  Container(
                    width: width * 0.9,
                    height: height > 800 ? height * 0.65 : height * 0.6,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/games/backgrounds/foret.jpg'),
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
                              selectedAnimal = "Un lion";
                              if (selectedAnimal == randomAnimal && _canTap) {
                                _isLiClicked = true;
                                Voice.play(
                                    "audios/voices/${animalsAudios['Un lion']}",
                                    1);
                                randomAnimalFunc();
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
                              selectedAnimal = "Un éléphant";
                              if (selectedAnimal == randomAnimal && _canTap) {
                                _isEleClicked = true;
                                Voice.play(
                                    "audios/voices/${animalsAudios['Un éléphant']}",
                                    1);
                                randomAnimalFunc();
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
                              selectedAnimal = "Une giraffe";
                              if (selectedAnimal == randomAnimal && _canTap) {
                                Voice.play(
                                    "audios/voices/${animalsAudios['Une giraffe']}",
                                    1);

                                _isGiClicked = true;
                                randomAnimalFunc();
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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 23),
          child: LinearPercentIndicator(
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
        ),
      ],
    );
  }
}
