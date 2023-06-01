import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Foret.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../Model/user.dart';
import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';

class Bureau extends StatefulWidget {
  final User user;
  const Bureau({super.key, required this.user});

  @override
  State<Bureau> createState() => _BureauState();
}

class _BureauState extends State<Bureau> {
  bool _isCoClicked = false;
  bool _isGoClicked = false;
  bool _isLiClicked = false;
  bool _isReClicked = false;
  bool _isTrClicked = false;
  bool _isBrClicked = false;
  bool _isCaClicked = false;
  bool _canTap = false;
  int countdown = 10;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomSchool;
  List<String> School = [
    'Une gomme',
    'Une colle',
    'Une trousse',
    'Une règle',
    'Un livre',
    'Un cartable',
    'Une brosse'
  ];
  Map<String, String> ElementsAudios = {
    'Une gomme': "25.mp3",
    'Une colle': "23.mp3",
    'Une trousse': "32.mp3",
    'Une règle': "30.mp3",
    'Un livre': "27.mp3",
    'Un cartable': "20.mp3",
    'Une brosse': "18.mp3"
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
                            builder: (context) => Bureau(user: widget.user),
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
                builder: (context) => Bureau(user: widget.user),
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
    return Stack(
      children: [
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
                            style: const TextStyle(
                                color: Color(0xFF0E57AC), fontSize: 15),
                          )
                        : Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Voice.play(
                                      'audios/voices/${ElementsAudios['$randomSchool']}',
                                      1);
                                },
                                icon: Icon(
                                  Icons.volume_up,
                                  color: Color(0xFF0E57AC),
                                  size: 35,
                                ),
                              ),
                              Text(
                                "$randomSchool",
                                style: const TextStyle(
                                    color: Color(0xFF0E57AC), fontSize: 25),
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
                          'assets/images/games/backgrounds/class.jpg'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                //Cartable
                Positioned(
                  bottom: height * 0.001,
                  left: width * 0.35,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Un cartable";
                        if (element == randomSchool && _canTap) {
                          _isCaClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Un cartable']}",
                              1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/20.png',
                        height: 65,
                        width: 65,
                      )),
                ),
                //Brosse
                Positioned(
                  bottom: height * 0.25,
                  left: width * 0.32,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Une brosse";
                        if (element == randomSchool && _canTap) {
                          _isBrClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une brosse']}",
                              1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/18.png',
                        height: 50,
                        width: 50,
                      )),
                ),
                //Livre
                Positioned(
                  bottom: height * 0.15,
                  left: width > 500 ? width * 0.35 : width * 0.38,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Un livre";
                        if (element == randomSchool && _canTap) {
                          _isLiClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Un livre']}", 1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/27.png',
                        height: 50,
                        width: 50,
                      )),
                ),
                //Trousse
                Positioned(
                  bottom: height * 0.18,
                  right: width > 500 ? width * 0.65 : width * 0.75,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Une trousse";
                        if (element == randomSchool && _canTap) {
                          _isTrClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une trousse']}",
                              1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/32.png',
                        height: 50,
                        width: 50,
                      )),
                ),
                //Règle
                Positioned(
                  bottom: height * 0.17,
                  right: width > 500 ? width * 0.48 : width * 0.3,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Une règle";
                        if (element == randomSchool && _canTap) {
                          _isReClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une règle']}",
                              1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/30.png',
                        height: 35,
                        width: 35,
                      )),
                ),
                //colle
                Positioned(
                  bottom: height * 0.18,
                  right: width > 500 ? width * 0.3 : width * 0.52,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Une colle";
                        if (element == randomSchool && _canTap) {
                          _isCoClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une colle']}",
                              1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/23.png',
                        height: 35,
                        width: 35,
                      )),
                ),
                //Gomme
                Positioned(
                  bottom: height * 0.16,
                  right: width > 500 ? width * 0.1 : width * 0.02,
                  child: GestureDetector(
                      onTap: () {
                        var element = "Une gomme";
                        if (element == randomSchool && _canTap) {
                          _isGoClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une gomme']}",
                              1);
                          randomSchoolFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/pics/25.png',
                        height: 30,
                        width: 30,
                      )),
                ),
              ]),

              //élements à trouver
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/pics/20.png',
                      height: 50,
                      width: 50,
                      color: _isCaClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/18.png',
                      height: 50,
                      width: 50,
                      color: _isBrClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/27.png',
                      height: 50,
                      width: 50,
                      color: _isLiClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/32.png',
                      height: 50,
                      width: 50,
                      color: _isTrClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/30.png',
                      height: 50,
                      width: 50,
                      color: _isReClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/23.png',
                      height: 50,
                      width: 50,
                      color: _isCoClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/25.png',
                      height: 50,
                      width: 50,
                      color: _isGoClicked ? null : Colors.black,
                    ),
                  ],
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
