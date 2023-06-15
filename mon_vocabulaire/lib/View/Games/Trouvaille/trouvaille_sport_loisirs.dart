// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
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

class SportLoisirs extends StatefulWidget {
  const SportLoisirs({super.key, required this.user});
  final User user;

  @override
  State<SportLoisirs> createState() => _SportLoisirsState();
}

class _SportLoisirsState extends State<SportLoisirs>
    with WidgetsBindingObserver {
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  late Timer _timer2;
  int duration = 60;
  bool isGameFinish = false;
  int fermeObject = 0;
  bool _isbalancoireClicked = false;
  bool _isgolfClicked = false;
  bool _ispiscineClicked = false;
  bool _istobogganClicked = false;
  bool _ispingpongClicked = false;
  bool _isveloClicked = false;
  bool _isballonClicked = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  Map<String, String> ElementsAudios = {
    'Un balançoire': "205.mp3",
    'Un golf': "198.mp3",
    'Une piscine': "202.mp3",
    'Un toboggan': "223.mp3",
    "Un ballon": "226.mp3",
    "Un ping pong": "201.mp3",
    "Un vélo": "233.mp3",
  };

  List<String> sport_ = [
    'Un toboggan',
    'Un golf',
    'Une piscine',
    'Un ballon',
    'Une balançoire',
    'Un ping pong',
    'Un vélo'
  ];
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

  String randomcuisineFunc() {
    sport_.shuffle();

    if (sport_.isNotEmpty) {
      randomElement = sport_[0];
      sport_.removeAt(0);
      if (sport_.length == 6 && duration > 0) {
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
              if (sport_.isNotEmpty) {
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
    randomcuisineFunc();
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
                            'assets/images/games/backgrounds/sport.jpg'),
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
                        top: height * 0.4,
                        right: width > 500 ? width * 0.8 : width * 0.7,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un vélo";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isveloClicked = true;
                              });
                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/233.png',
                            width: width > 500 ? 150 : 120,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.33 : height * 0.36,
                        left: width > 500 ? width * 0.2 : width * 0.25,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Une balançoire";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isbalancoireClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/205.png',
                            width: width > 500 ? 260 : 180,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.55 : height * 0.58,
                        right: width > 500 ? width * 0.75 : width * 0.65,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Une piscine";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _ispiscineClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/202.png',
                            width: width > 500 ? 200 : 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.7 : height * 0.68,
                        left: width * 0.5,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un ping pong";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _ispingpongClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/201.png',
                            width: width > 500 ? 250 : 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.35 : height * 0.38,
                        left: width * 0.6,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un toboggan";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _istobogganClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/223.png',
                            width: width > 500 ? 300 : 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: width > 500 ? height * 0.65 : height * 0.6,
                        left: width > 500 ? width * 0.35 : width * 0.4,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un golf";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isgolfClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/198.png',
                            width: width > 500 ? 100 : 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height * 0.6,
                        left: width * 0.8,
                        child: GestureDetector(
                          onTap: () {
                            String name = "Un ballon";
                            if (name == randomElement && _canTap) {
                              setState(() {
                                _isballonClicked = true;
                              });

                              randomcuisineFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/226.png',
                            width: width > 500 ? 60 : 50,
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
                  padding: EdgeInsets.only(bottom: width > 500 ? 10.0 : 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/205.png',
                        width: width > 500 ? 75 : 45,
                        color: _isbalancoireClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/198.png',
                        width: width > 500 ? 60 : 35,
                        color: _isgolfClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/202.png',
                        width: width > 500 ? 60 : 40,
                        color: _ispiscineClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/223.png',
                        width: width > 500 ? 75 : 50,
                        color: _istobogganClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/226.png',
                        width: width > 500 ? 55 : 35,
                        color: _isballonClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/201.png',
                        width: width > 500 ? 75 : 40,
                        color: _ispingpongClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/233.png',
                        width: width > 500 ? 70 : 40,
                        color: _isveloClicked ? null : Palette.indigo,
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
