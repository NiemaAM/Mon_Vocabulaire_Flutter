import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';

class cuisine extends StatefulWidget {
  const cuisine({super.key, required this.user});

  final User user;

  @override
  State<cuisine> createState() => _cuisineState();
}

class _cuisineState extends State<cuisine> {
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
  late var randomCuisine;
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
      randomCuisine = cuisine_[0];
      print(randomCuisine);
      cuisine_.removeAt(0);
    } else {
      endGame();
    }
    return randomCuisine;
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
                // showDialog(
                //   context: context,
                //   barrierDismissible: false,
                //   builder: (BuildContext context) {
                //     return GamePopup(
                //       onButton1Pressed: () {
                //         Navigator.pop(context);
                //         Navigator.pop(context);
                //       },
                //       onButton2Pressed: () {
                //         Navigator.pop(context);
                //         Navigator.pushReplacement(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => cuisine(user: widget.user),
                //           ),
                //         );
                //       },
                //       oneButton: false,
                //       win: false,
                //     );
                //   },
                // );
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
                builder: (context) => cuisine(user: widget.user),
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
    AudioBK.pauseBK();
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
          body: Stack(
            children: [
              Center(
                child: Container(
                  height: height * 0.6,
                  width: width * 0.9,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/games/backgrounds/cuisine.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Stack(children: [
                    Positioned(
                      bottom: width > 550 ? height * 0.13 : height * 0.11,
                      left: width > 550 ? width * 0.32 : width * 0.27,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un four";
                          if (name == randomCuisine && _canTap) {
                            _isfoeClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un four']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/83.png',
                          scale: width > 450 ? 3.3 : 4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: width > 450 ? height * 0.27 : height * 0.27,
                      left: width > 450 ? width * 0.57 : width * 0.64,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un verre";
                          if (name == randomCuisine && _canTap) {
                            _isveClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un verre']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/89.png',
                          scale: width > 450 ? 10 : 12,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: width > 450 ? height * 0.24 : height * 0.24,
                      left: width > 450 ? width * 0.7 : width * 0.75,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Une pastèque";
                          if (name == randomCuisine && _canTap) {
                            _ispaClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Une pastèque']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/106.png',
                          scale: width > 450 ? 5 : 7,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.42,
                      left: width > 450 ? width * 0.66 : width * 0.75,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un tajine";
                          if (name == randomCuisine && _canTap) {
                            _iscaClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un tajine']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/113.png',
                          scale: width > 450 ? 9 : 12,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: width > 450 ? height * 0.27 : height * 0.27,
                      left: width > 450 ? width * 0.34 : width * 0.3,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Une casserole";
                          if (name == randomCuisine && _canTap) {
                            _isCasseroleClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Une casserole']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/78.png',
                          scale: width > 450 ? 5 : 7,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: width > 450 ? height * 0.01 : height * 0.04,
                      left: width > 450 ? -50 : -30,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un balai";
                          if (name == randomCuisine && _canTap) {
                            _isBalaiClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un balai']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/38.png',
                          scale: width > 450 ? 2.5 : 4,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/83.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isfoeClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/89.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isveClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/106.png',
                        scale: width > 450 ? 8 : 10,
                        color: _ispaClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/113.png',
                        scale: width > 450 ? 8 : 10,
                        color: _iscaClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/78.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isCasseroleClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/38.png',
                        scale: width > 450 ? 8 : 10,
                        color: _isBalaiClicked ? null : Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: BubbleMessage(
                  widget: countdown > 0
                      ? Text(
                          "Trouvez les mots dans : $countdown",
                          style: TextStyle(
                              color: const Color(0xFF0E57AC),
                              fontSize: width > 450 ? 25 : 18),
                        )
                      : Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Voice.play(
                                    'audios/voices/${ElementsAudios['$randomCuisine']}',
                                    1);
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: Color(0xFF0E57AC),
                                size: 35,
                              ),
                            ),
                            Text(
                              '$randomCuisine',
                              style: TextStyle(
                                  color: const Color(0xFF0E57AC),
                                  fontSize: width > 450 ? 25 : 18),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 23),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 15,
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
