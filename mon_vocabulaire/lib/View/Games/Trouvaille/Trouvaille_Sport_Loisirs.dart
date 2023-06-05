import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
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

class sport_loisir extends StatefulWidget {
  const sport_loisir({super.key, required this.user});
  final User user;

  @override
  State<sport_loisir> createState() => _sport_loisirState();
}

class _sport_loisirState extends State<sport_loisir> {
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  int fermeObject = 0;
  bool _isfoeClicked = false;
  bool _isveClicked = false;
  bool _ispaClicked = false;
  bool _iscaClicked = false;
  bool _isbalClicked = false;
  late ConfettiController _controllerConfetti;
  late var randomCuisine;
  Map<String, String> ElementsAudios = {
    'Un balançoire': "205.mp3",
    'Un football': "197.mp3",
    'Un cirque': "209.mp3",
    'Un toboggan': "223.mp3",
    "Un ballon": "226.mp3"
  };

  List<String> cuisine_ = [
    'Un toboggan',
    'Un football',
    'Un cirque',
    'Un ballon',
    'Une balançoire'
  ];
  String randomcuisineFunc() {
    cuisine_.shuffle();

    if (cuisine_.isNotEmpty) {
      randomCuisine = cuisine_[0];
      print(randomCuisine);
      cuisine_.removeAt(0);
    } else {
      print("Fin du jeu");
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
                            builder: (context) =>
                                sport_loisir(user: widget.user),
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
                builder: (context) => sport_loisir(user: widget.user),
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
                  width: width * 0.9,
                  height: height > 800 ? height * 0.65 : height * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/games/backgrounds/sport.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Stack(children: [
                    //monkey

                    Positioned(
                      bottom: width > 550 ? height * 0.1 : height * 0.11,
                      left: width > 550 ? width * 0 : width * 0.01,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un cirque";
                          if (name == randomCuisine && _canTap) {
                            _isfoeClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un cirque']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/209.png',
                          scale: width > 450 ? 2 : 2.5,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: height > 800 ? height * 0.1 : height * 0.12,
                      left: width > 550 ? width * 0.38 : width * 0.65,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Une balançoire";
                          if (name == randomCuisine && _canTap) {
                            _isbalClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Une balançoire']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/205.png',
                          height: 120,
                          width: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: height > 800 ? height * 0 : height * 0.05,
                      left: width > 550 ? width * 0.35 : width * 0.5,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un football";
                          if (name == randomCuisine && _canTap) {
                            _isveClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un football']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/197.png',
                          scale: width > 450 ? 4 : 2.5,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: height > 550 ? height * 0 : height * 0.21,
                      left: width > 550 ? width * 0.5 : width * 0.75,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un toboggan";
                          if (name == randomCuisine && _canTap) {
                            _ispaClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un toboggan']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/223.png',
                          scale: width > 450 ? 1.99 : 2.5,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: height > 800 ? height * 0.5 : height * 0.42,
                      left: width > 550 ? width * 0.25 : width * 0.75,
                      child: GestureDetector(
                        onTap: () {
                          String name = "Un ballon";
                          if (name == randomCuisine && _canTap) {
                            _iscaClicked = true;
                            randomcuisineFunc();
                            Voice.play(
                                "audios/voices/${ElementsAudios['Un ballon']}",
                                1);
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/226.png',
                          height: width > 550 ? 70 : 40,
                          width: width > 550 ? 70 : 40,
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/209.png',
                        height: 75,
                        width: 75,
                        color: _isfoeClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/197.png',
                        height: 75,
                        width: 75,
                        color: _isveClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/223.png',
                        height: 75,
                        width: 75,
                        color: _ispaClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/226.png',
                        height: 60,
                        width: 60,
                        color: _iscaClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        'assets/images/pics/205.png',
                        height: 75,
                        width: 75,
                        color: _isbalClicked ? null : Colors.black,
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
                          "Trouvez les élements dans : $countdown",
                          style: const TextStyle(
                              color: Color(0xFF0E57AC), fontSize: 15),
                        )
                      : Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 10),
                              child: IconButton(
                                onPressed: () {
                                  Voice.play(
                                      'audios/voices/${ElementsAudios['$randomCuisine']}',
                                      1);
                                },
                                icon: Icon(
                                  Icons.volume_up,
                                  color: Color(0xFF0E57AC),
                                  size: 35,
                                ),
                              ),
                            ),
                            Text(
                              '$randomCuisine',
                              style: const TextStyle(
                                  color: Color(0xFF0E57AC), fontSize: 20),
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
