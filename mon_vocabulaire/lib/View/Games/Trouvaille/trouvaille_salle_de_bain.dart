// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille.dart';
import 'package:mon_vocabulaire/Widgets/message_mascotte.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';

class SalleDeBain extends StatefulWidget {
  final User user;
  const SalleDeBain({super.key, required this.user});

  @override
  State<SalleDeBain> createState() => _SalleDeBainState();
}

class _SalleDeBainState extends State<SalleDeBain> {
  int countdown = 5;
  late Timer _timer;
  bool _isToiletClicked = false;
  bool _isSinkClicked = false;
  bool _isSoapClicked = false;
  bool _isMirorClicked = false;
  bool _isTowelClicked = false;
  bool _canTap = false;

  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  late var selectedElement;
  List<String> bathRoom = [
    'Des toilettes',
    'Une serviette',
    'Un lavabo',
    'Du savon',
    'Un miroire'
  ];
  Map<String, String> ElementsAudios = {
    'Des toilettes': "16.mp3",
    'Une serviette': "192.mp3",
    'Un lavabo': "47.mp3",
    'Du savon': "171.mp3",
    'Un miroire': "72.mp3",
  };

  String randomElementFunc() {
    bathRoom.shuffle();

    if (bathRoom.isNotEmpty) {
      randomElement = bathRoom[0];
      bathRoom.removeAt(0);
      if (bathRoom.length == 4) {
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
              if (bathRoom.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
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
                            'assets/images/games/backgrounds/bathroom.jpg'),
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
                      //toilettes
                      Positioned(
                        top: width > 500 ? height * 0.54 : height * 0.5,
                        left: width > 500 ? width * 0.735 : width * 0.6,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Des toilettes" && _canTap) {
                              setState(() {
                                _isToiletClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/16.png',
                            width: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //serviette
                      Positioned(
                        top: height * 0.5,
                        right: width > 500 ? width * 0.3 : width * 0.32,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Une serviette" && _canTap) {
                              setState(() {
                                _isTowelClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/192.png',
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // lavabo
                      Positioned(
                        top: height * 0.45,
                        right: width > 500 ? width * 0.47 : width * 0.57,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Un lavabo" && _canTap) {
                              setState(() {
                                _isSinkClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            "assets/images/games/lavabo.png",
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //savon
                      Positioned(
                        top: width > 500 ? height * 0.46 : height * 0.48,
                        right: width > 500 ? width * 0.63 : width * 0.84,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Du savon" && _canTap) {
                              setState(() {
                                _isSoapClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/171.png',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      //miroire
                      Positioned(
                        top: height * 0.26,
                        right: width > 500 ? width * 0.48 : width * 0.60,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Un miroire" && _canTap) {
                              setState(() {
                                _isMirorClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/72.png',
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
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
                        "assets/images/pics/171.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isSoapClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        "assets/images/games/lavabo.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isSinkClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        "assets/images/pics/192.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isTowelClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        "assets/images/pics/16.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isToiletClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        "assets/images/pics/72.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isMirorClicked ? null : Palette.indigo,
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
