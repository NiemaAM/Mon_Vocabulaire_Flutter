// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';

class Cuisine extends StatefulWidget {
  const Cuisine({super.key, required this.user});

  final User user;

  @override
  State<Cuisine> createState() => _CuisineState();
}

class _CuisineState extends State<Cuisine> {
  int countdown = 5;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  int fermeObject = 0;
  bool _isfoeClicked = false;
  bool _isveClicked = false;
  bool _ispaClicked = false;
  bool _iscaClicked = false;
  bool _isCasseroleClicked = false;
  bool _isBalaiClicked = false;
  bool _canTap = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  Map<String, String> ElementsAudios = {
    'Une pastèque': "106.mp3",
    'Un verre': "89.mp3",
    'Un four': "83.mp3",
    'Un tajine': "113.mp3",
    'Une casserole': "78.mp3",
    'Un balai': "38.mp3"
  };

  List<String> cuisine_ = [
    'Une pastèque',
    'Un verre',
    'Un four',
    'Un tajine',
    'Une casserole',
    'Un balai'
  ];
  String randomcuisineFunc() {
    cuisine_.shuffle();

    if (cuisine_.isNotEmpty) {
      randomElement = cuisine_[0];
      cuisine_.removeAt(0);
      if (cuisine_.length == 5) {
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
              if (cuisine_.isNotEmpty) {
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
    randomcuisineFunc();
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
                            'assets/images/games/backgrounds/cuisine.jpg'),
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
                                      "Trouvez l'objet dans : $countdown",
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
                      Positioned(
                        top: width > 500 ? height * 0.46 : height * 0.46,
                        left: width > 500 ? width * 0.32 : width * 0.25,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un four";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isfoeClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/83.png',
                            width: width > 500 ? 220 : 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.31 : height * 0.36,
                        right: width > 500 ? width * 0.77 : width * 0.77,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Une pastèque";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _ispaClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/106.png',
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.375 : height * 0.37,
                        right: width > 500 ? width * 0.1 : width * 0.05,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un tajine";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _iscaClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/113.png',
                            width: width > 500 ? 100 : 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.45 : height * 0.44,
                        left: width > 500 ? width * 0.83 : width * 0.86,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un verre";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isveClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/89.png',
                            width: width > 500 ? 60 : 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.355 : height * 0.35,
                        left: width > 500 ? width * 0.335 : width * 0.27,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Une casserole";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isCasseroleClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/78.png',
                            width: width > 500 ? 140 : 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.5,
                        left: width > 500 ? -width * 0.1 : -width * 0.25,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un balai";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isBalaiClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/38.png',
                            width: 250,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/83.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isfoeClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/89.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isveClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/106.png',
                        scale: width > 450 ? 8 : 10,
                        color: _ispaClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/113.png',
                        scale: width > 450 ? 8 : 10,
                        color: _iscaClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/78.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isCasseroleClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/38.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isBalaiClicked ? null : Palette.indigo,
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
