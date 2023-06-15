// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';

class ClassRoom extends StatefulWidget {
  final User user;
  const ClassRoom({super.key, required this.user});

  @override
  State<ClassRoom> createState() => _ClassRoomState();
}

class _ClassRoomState extends State<ClassRoom> with WidgetsBindingObserver {
  bool _isBoaClicked = false;
  bool _isTeaClicked = false;
  bool _isWinClicked = false;
  bool _isDesClicked = false;
  bool _isCloClicked = false;
  bool _isTableClicked = false;
  bool _isChairClicked = false;
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  late Timer _timer2;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  List<String> School = [
    'Un bureau',
    'Une fenêtre',
    'Une horloge',
    'Une maîtresse',
    'Un tableau',
    'Une chaise',
    'Une table'
  ];
  Map<String, String> ElementsAudios = {
    'Un bureau': "4.mp3",
    'Une fenêtre': "9.mp3",
    'Une horloge': "10.mp3",
    'Une maîtresse': "37.mp3",
    'Un tableau': "15.mp3",
    'Une chaise': "21.mp3",
    'Une table': "14.mp3",
  };

  int coins = -1;
  RealtimeDataController controller = RealtimeDataController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getUser() async {
    await controller.getUser(widget.user.id!);
    User? user = controller.user;
    setState(() {
      coins = user!.coins;
    });
  }

  String randomElementFunc() {
    School.shuffle();

    if (School.isNotEmpty) {
      randomElement = School[0];
      School.removeAt(0);
      if (School.length == 6 && duration > 0) {
        _timer2 = Timer.periodic(const Duration(seconds: 5), (timer) {
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
            _timer2.cancel();
            duration--;
            _canTap = true;
            bool isClicked = false;
            if (duration == 0) {
              _timer2.cancel();
              timer.cancel();
              if (School.isNotEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return GamePopup(
                      isClicked: isClicked,
                      price: 30,
                      onButton1Pressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      onButton2Pressed: () {
                        isClicked = true;
                        Timer(const Duration(seconds: 1), () {
                          if (coins >= 30) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Trouvaille(
                                  user: widget.user,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Palette.indigo,
                              content: Text(
                                'Tu n\'as pas assez de pièces pour jouer.',
                                style: TextStyle(
                                    color: Palette.white, fontSize: 18),
                              ),
                            ));
                          }
                        });
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
    _timer2.cancel();
    _timer.cancel();
    if (duration > 0) {
      _controllerConfetti.play();
    }
    bool isClicked = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GamePopup(
          isClicked: isClicked,
          price: 30,
          onButton1Pressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButton2Pressed: () {
            isClicked = true;
            Timer(const Duration(seconds: 1), () {
              if (coins >= 30) {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Trouvaille(
                      user: widget.user,
                    ),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 2),
                  backgroundColor: Palette.indigo,
                  content: Text(
                    'Tu n\'as pas assez de pièces pour jouer.',
                    style: TextStyle(color: Palette.white, fontSize: 18),
                  ),
                ));
              }
            });
          },
          win: duration > 0,
        );
      },
    );
  }

  @override
  void initState() {
    getUser();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    randomElementFunc();
    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.pause();
    Voice.pause();
    _timer.cancel();
    _timer2.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioBK.pauseBK();
      Voice.pause();
      Sfx.pause();
    } else {
      AudioBK.playBK();
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
                            'assets/images/games/backgrounds/Classe.png'),
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
                                                  'audios/voices/${ElementsAudios[randomElement]}',
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
                                            randomElement,
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
                      //Tableau
                      Positioned(
                        top: width > 500 ? height * 0.25 : height * 0.3,
                        right: width > 500 ? width * 0.45 : width * 0.39,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un tableau";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isBoaClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/15.png',
                              width: width > 500 ? 350 : 250,
                            )),
                      ),
                      //Maitresse
                      Positioned(
                        top: height * 0.4,
                        left: width * 0.45,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une maîtresse";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isTeaClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/maitresse.png',
                              width: width > 500 ? 130 : 100,
                            )),
                      ),
                      //Bureau
                      Positioned(
                        top: width > 500 ? height * 0.5 : height * 0.53,
                        left: width > 500 ? width * 0.6 : width * 0.58,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un bureau";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isDesClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/desk.png',
                              width: width > 500 ? 210 : 150,
                            )),
                      ),
                      //Table
                      Positioned(
                        top: height * 0.62,
                        left: width * 0.17,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une table";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isTableClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/table.png',
                              width: width > 500 ? 180 : 150,
                            )),
                      ),
                      //Chaise
                      Positioned(
                        top: height * 0.67,
                        left: width * 0.2,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une chaise";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isChairClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/chair.png',
                              width: width > 500 ? 150 : 130,
                            )),
                      ),
                      //Fenêtre
                      Positioned(
                        bottom: height * 0.45,
                        right: width * 0.02,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une fenêtre";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isWinClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/window.png',
                              width: width > 500 ? 150 : 100,
                            )),
                      ),
                      //Horloge
                      Positioned(
                        top: height * 0.25,
                        right: width > 500 ? width * 0.36 : width * 0.42,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une horloge";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isCloClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/10.png',
                              width: width > 500 ? 80 : 60,
                            )),
                      ),
                    ]),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: width > 500 ? 10 : 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/10.png',
                        width: width > 500 ? 40 : 30,
                        color: _isCloClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/games/table.png',
                        width: width > 500 ? 50 : 40,
                        color: _isTableClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/games/maitresse.png',
                        width: width > 500 ? 40 : 30,
                        color: _isTeaClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/games/chair.png',
                        width: width > 500 ? 50 : 40,
                        color: _isChairClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/15.png',
                        width: width > 500 ? 60 : 50,
                        color: _isBoaClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/games/desk.png',
                        width: width > 500 ? 60 : 50,
                        color: _isDesClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/games/window.png',
                        width: width > 500 ? 40 : 30,
                        color: _isWinClicked ? null : Palette.indigo,
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
        ConfettiWidget(
          gravity: 0,
          confettiController: _controllerConfetti,
          blastDirectionality: BlastDirectionality
              .explosive, // don't specify a direction, blast randomly
          numberOfParticles: 20,
          shouldLoop: true, // start again as soon as the animation is finished
          colors: const [
            Palette.lightGreen,
            Palette.blue,
            Palette.pink,
            Palette.orange,
            Palette.purple
          ], // manually specify the colors to be used
        ),
      ],
    );
  }
}
