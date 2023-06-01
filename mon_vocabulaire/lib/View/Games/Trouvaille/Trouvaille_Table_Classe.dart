import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../Model/user.dart';
import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';
import 'Trouvaille_Ferme.dart';

class ClassRoom extends StatefulWidget {
  final User user;
  const ClassRoom({super.key, required this.user});

  @override
  State<ClassRoom> createState() => _ClassRoomState();
}

class _ClassRoomState extends State<ClassRoom> {
  bool _isBoaClicked = false;
  bool _isTeaClicked = false;
  bool _isWinClicked = false;
  bool _isDesClicked = false;
  bool _isCloClicked = false;
  // bool _isBrClicked = false;
  // bool _isCaClicked = false;
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomSchool;
  List<String> School = [
    'Un bureau',
    'Une fenêtre',
    'Une horloge',
    'Une maîtresse',
    'Un tableau'
  ];
  Map<String, String> ElementsAudios = {
    'Un bureau': "4.mp3",
    'Une fenêtre': "9.mp3",
    'Une horloge': "10.mp3",
    'Une maîtresse': "37.mp3",
    'Un tableau': "15.mp3",
  };
  String randomSchoolFunc() {
    School.shuffle();

    if (School.isNotEmpty) {
      randomSchool = School[0];
      print(randomSchool);
      School.removeAt(0);
    } else {
      print("Fin du jeu");
      endGame();
    }

    return randomSchool;
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
              if (School.isNotEmpty) {
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
                            builder: (context) => ClassRoom(user: widget.user),
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
                builder: (context) => ClassRoom(user: widget.user),
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
    randomSchoolFunc();
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
    return Stack(children: [
      Scaffold(
        appBar: CustomAppBarGames(
          user: widget.user,
          background: true,
        ),
        body: Column(
          children: [
            //Mot à trouver mascotte
            Stack(children: [
              Align(
                alignment: Alignment.topCenter,
                child: BubbleMessage(
                  widget: countdown > 0
                      ? Text(
                          "Trouvez l'element dans : $countdown",
                          style: TextStyle(
                              color: const Color(0xFF0E57AC),
                              fontSize: width > 450 ? 25 : 18),
                        )
                      : Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Voice.play(
                                    'audios/voices/${ElementsAudios['$randomSchool']}',
                                    1);
                              },
                              icon: const Icon(
                                Icons.volume_up,
                                color: Color(0xFF0E57AC),
                                size: 35,
                              ),
                            ),
                            Text(
                              "$randomSchool",
                              style: TextStyle(
                                  color: const Color(0xFF0E57AC),
                                  fontSize: width > 450 ? 25 : 18),
                            ),
                          ],
                        ),
                  // widget:
                ),
              ),
            ]),
            Stack(children: [
              Container(
                height: height * 0.6,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/games/backgrounds/Classe.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              //Tableau
              Positioned(
                bottom: height * 0.25,
                left: width * 0.05,
                child: GestureDetector(
                    onTap: () {
                      var element = "Un tableau";
                      if (element == randomSchool && _canTap) {
                        _isBoaClicked = true;
                        Voice.play(
                            "audios/voices/${ElementsAudios['Un tableau']}", 1);

                        randomSchoolFunc();
                      }
                    },
                    child: Image.asset(
                      'assets/images/pics/15.png',
                      height: 180,
                      width: 180,
                    )),
              ),
              //Maitresse
              Positioned(
                bottom: height * 0.22,
                left: width * 0.30,
                child: GestureDetector(
                    onTap: () {
                      var element = "Une maîtresse";

                      if (element == randomSchool && _canTap) {
                        _isTeaClicked = true;
                        Voice.play(
                            "audios/voices/${ElementsAudios['Une maîtresse']}",
                            1);

                        randomSchoolFunc();
                      }
                    },
                    child: Image.asset(
                      'assets/images/games/maitresse.png',
                      height: 150,
                      width: 150,
                    )),
              ),
              //Bureau
              Positioned(
                bottom: height * 0.02,
                left: width * 0.32,
                child: GestureDetector(
                    onTap: () {
                      var element = "Un bureau";

                      if (element == randomSchool && _canTap) {
                        _isDesClicked = true;
                        Voice.play(
                            "audios/voices/${ElementsAudios['Un bureau']}", 1);

                        randomSchoolFunc();
                      }
                    },
                    child: Image.asset(
                      'assets/images/pics/4.png',
                      height: 150,
                      width: 150,
                    )),
              ),
              //Fenêtre
              Positioned(
                bottom: height * 0.45,
                right: width * 0.02,
                child: GestureDetector(
                    onTap: () {
                      var element = "Une fenêtre";
                      if (element == randomSchool && _canTap) {
                        _isWinClicked = true;
                        Voice.play(
                            "audios/voices/${ElementsAudios['Une fenêtre']}",
                            1);
                        randomSchoolFunc();
                      }
                    },
                    child: Image.asset(
                      'assets/images/games/window.png',
                      height: 80,
                      width: 80,
                    )),
              ),
              //Horloge
              Positioned(
                bottom: height * 0.52,
                right: width > 500 ? width * 0.38 : width * 0.42,
                child: GestureDetector(
                    onTap: () {
                      var element = "Une horloge";
                      if (element == randomSchool && _canTap) {
                        _isCloClicked = true;
                        Voice.play(
                            "audios/voices/${ElementsAudios['Une horloge']}",
                            1);
                        randomSchoolFunc();
                      }
                    },
                    child: Image.asset(
                      'assets/images/pics/10.png',
                      height: 40,
                      width: 40,
                    )),
              ),
            ]),

            //élements à trouver
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    'assets/images/pics/10.png',
                    height: 30,
                    width: 30,
                    color: _isCloClicked ? null : Colors.black,
                  ),
                  Image.asset(
                    'assets/images/games/maitresse.png',
                    height: 50,
                    width: 50,
                    color: _isTeaClicked ? null : Colors.black,
                  ),
                  Image.asset(
                    'assets/images/pics/15.png',
                    height: 50,
                    width: 50,
                    color: _isBoaClicked ? null : Colors.black,
                  ),
                  Image.asset(
                    'assets/images/pics/4.png',
                    height: 50,
                    width: 50,
                    color: _isDesClicked ? null : Colors.black,
                  ),
                  Image.asset(
                    'assets/images/games/window.png',
                    height: 30,
                    width: 30,
                    color: _isWinClicked ? null : Colors.black,
                  ),
                ],
              ),
            )
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
    ]);
  }
}
