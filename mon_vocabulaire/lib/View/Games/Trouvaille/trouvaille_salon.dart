// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';

class Salon extends StatefulWidget {
  final User user;
  const Salon({super.key, required this.user});

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> with WidgetsBindingObserver {
  bool _isTelClicked = false;
  bool _isBoyClicked = false;
  bool _isBebClicked = false;
  bool _isMomClicked = false;
  bool _isGirClicked = false;
  bool _isVasClicked = false;
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  late Timer _timer2;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  List<String> Room = [
    'Une télévision',
    'Un garcon',
    'Une maman',
    'Une fille',
    'Un vase',
    'Un bébé'
  ];
  Map<String, String> ElementsAudios = {
    'Une télévision': "75.mp3",
    'Un vase': "76.mp3",
    'Une fille': "35.mp3",
    'Un garcon': "36.mp3",
    "Une maman": "63.mp3",
    "Un bébé": "55.mp3",
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
    Room.shuffle();

    if (Room.isNotEmpty) {
      randomElement = Room[0];
      Room.removeAt(0);
      if (Room.length == 5 && duration > 0) {
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
              if (Room.isNotEmpty) {
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
    randomElementFunc();
    WidgetsBinding.instance.addObserver(this);
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
                            'assets/images/games/backgrounds/salon.jpg'),
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
                                      "Trouvez le mot dans : $countdown",
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
                                              color: Color(0xFF0E57AC),
                                              size: 25,
                                            ),
                                          ),
                                          const Expanded(child: SizedBox()),
                                          Text(
                                            "$randomElement",
                                            style: const TextStyle(
                                                color: Color(0xFF0E57AC),
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

                      //Television
                      Positioned(
                        top: width > 500 ? height * 0.35 : height * 0.32,
                        right: width > 500 ? width * 0.42 : width * 0.32,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une télévision";

                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isTelClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/75.png',
                              width: 220,
                            )),
                      ),

                      //garcon
                      Positioned(
                        top: width > 500 ? height * 0.55 : height * 0.45,
                        left: width > 500 ? width * 0.62 : width * 0.6,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un garcon";

                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isBoyClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/garcon.png',
                              width: 140,
                            )),
                      ),

                      //vase
                      Positioned(
                        top: width > 500 ? height * 0.75 : height * 0.7,
                        left: width > 500 ? width * 0.75 : width * 0.7,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un vase";

                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isVasClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/76.png',
                              width: width > 500 ? 120 : 100,
                            )),
                      ),

                      //fille
                      Positioned(
                        top: width > 500 ? height * 0.56 : height * 0.53,
                        left: width > 500 ? width * 0.4 : width * 0.35,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une fille";

                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isGirClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/fille.png',
                              width: 120,
                            )),
                      ),

                      //maman
                      Positioned(
                        top: width > 500 ? height * 0.5 : height * 0.45,
                        right: width * 0.65,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une maman";

                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isMomClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/games/maman.png',
                              width: 130,
                            )),
                      ),

                      //bébé
                      Positioned(
                        top: height * 0.74,
                        left: width * 0.4,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un bébé";

                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isBebClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/55.png',
                              width: 90,
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
                          'assets/images/pics/76.png',
                          width: 50,
                          color: _isVasClicked ? null : Palette.indigo,
                        ),
                        Image.asset(
                          'assets/images/games/garcon.png',
                          width: 40,
                          color: _isBoyClicked ? null : Palette.indigo,
                        ),
                        Image.asset(
                          'assets/images/games/fille.png',
                          width: 55,
                          color: _isGirClicked ? null : Palette.indigo,
                        ),
                        Image.asset(
                          'assets/images/pics/75.png',
                          width: 50,
                          color: _isTelClicked ? null : Palette.indigo,
                        ),
                        Image.asset(
                          'assets/images/games/maman.png',
                          width: 40,
                          color: _isMomClicked ? null : Palette.indigo,
                        ),
                        Image.asset(
                          'assets/images/pics/55.png',
                          width: 50,
                          color: _isBebClicked ? null : Palette.indigo,
                        )
                      ],
                    ),
                  )),
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
