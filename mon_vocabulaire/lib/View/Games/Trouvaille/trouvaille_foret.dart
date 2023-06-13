// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
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
  bool _isHirClicked = false;
  int countdown = 5;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late String selectedAnimal;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  List<String> animals = [
    'Un lion',
    'Un éléphant',
    'Une giraffe',
    'Une hyrondelle'
  ];
  Map<String, String> ElementsAudios = {
    'Un lion': "143.mp3",
    'Un éléphant': "138.mp3",
    'Une giraffe': "140.mp3",
    'Une hyrondelle': "123.mp3"
  };
  String randomElementFunc() {
    animals.shuffle();

    if (animals.isNotEmpty) {
      randomElement = animals[0];
      animals.removeAt(0);
      if (animals.length == 3) {
        Timer(const Duration(seconds: 5), () {
          Voice.play("audios/voices/${ElementsAudios[randomElement]}", 1);
        });
      } else {
        Voice.play("audios/voices/${ElementsAudios[randomElement]}", 1);
      }
    } else {
      endGame();
    }
    return randomElement;
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
                            builder: (context) => Trouvaille(user: widget.user),
                          ),
                        );
                      },
                      oneButton: false,
                      win: false,
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
    _timer.cancel();
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
                builder: (context) => Trouvaille(user: widget.user),
              ),
            );
          },
          win: duration > 0,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    randomElementFunc();

    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.pause();
    _timer.cancel();
  }

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
          backgroundColor: Palette.lightBlue,
          body: Stack(
            children: [
              Stack(
                children: [
                  Container(
                    width: width,
                    height: height - 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/games/backgrounds/foret.jpg'),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    child: Stack(children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: SizedBox(
                            width: width > 500 ? width / 2 + 50 : width - 30,
                            child: BubbleMessage(
                              widget: countdown > 0
                                  ? Text(
                                      "Trouvez l'animal dans : $countdown",
                                      style: const TextStyle(
                                          color: Palette.indigo, fontSize: 15),
                                    )
                                  : SizedBox(
                                      height: 30,
                                      child: Row(
                                        children: [
                                          const Expanded(child: SizedBox()),
                                          GestureDetector(
                                            onTap: () {
                                              Voice.play(
                                                  'audios/voices/${ElementsAudios['$randomElement']}',
                                                  1);
                                            },
                                            child: const Icon(
                                              Icons.volume_up,
                                              color: Palette.indigo,
                                              size: 25,
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Text(
                                            "$randomElement",
                                            style: const TextStyle(
                                                color: Palette.indigo,
                                                fontSize: 18),
                                          ),
                                          const Expanded(
                                              flex: 2, child: SizedBox()),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      //snake
                      Positioned(
                        bottom: height * 0.05,
                        right: width * 0.2,
                        child: Image.asset(
                          'assets/images/games/snake.png',
                          height: 70,
                          width: 70,
                        ),
                      ),

                      //hyrondelle
                      Positioned(
                        top: height * 0.22,
                        right: width * 0.2,
                        child: GestureDetector(
                          onTap: () {
                            selectedAnimal = "Une hyrondelle";
                            if (selectedAnimal == randomElement && _canTap) {
                              setState(() {
                                _isHirClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/123.png',
                            height: 70,
                            width: 70,
                          ),
                        ),
                      ),

                      //lion
                      Positioned(
                        top: height * 0.3,
                        right: width > 550 ? width * 0.2 : width * 0.04,
                        bottom: 1,
                        child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Un lion";
                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isLiClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/143.png',
                              width: height > 800 ? 200 : 180,
                            )),
                      ),

                      //giraffe
                      Positioned(
                        top: height * 0.1,
                        right: width > 500 ? width * 0.5 : width * 0.4,
                        bottom: 1,
                        child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Une giraffe";
                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isGiClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: SizedBox(
                              child: Image.asset(
                                'assets/images/pics/140.png',
                                width: height > 800 ? 400 : 300,
                              ),
                            )),
                      ),

                      //éléphant
                      Positioned(
                        top: height > 800 ? height * 0.50 : height * 0.55,
                        right: width > 550 ? width * 0.45 : width * 0.35,
                        bottom: 1,
                        child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Un éléphant";
                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isEleClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/138.png',
                              width: height > 800 ? 300 : 250,
                            )),
                      ),
                    ]),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/138.png',
                        width: 75,
                        color: _isEleClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/140.png',
                        width: 75,
                        color: _isGiClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/123.png',
                        width: 75,
                        color: _isHirClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/143.png',
                        width: 75,
                        color: _isLiClicked ? null : Palette.indigo,
                      ),
                    ],
                  ),
                ),
              ),
              CustomAppBarGames(
                user: widget.user,
                background: true,
                timer: true,
              ),
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
            backgroundColor: Palette.indigo,
          ),
        ),
      ],
    );
  }
}
