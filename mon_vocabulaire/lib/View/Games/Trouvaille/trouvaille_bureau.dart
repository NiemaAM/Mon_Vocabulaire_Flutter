// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
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

class Bureau extends StatefulWidget {
  final User user;
  const Bureau({super.key, required this.user});

  @override
  State<Bureau> createState() => _BureauState();
}

class _BureauState extends State<Bureau> with WidgetsBindingObserver {
  bool _isCoClicked = false;
  bool _isGoClicked = false;
  bool _isLiClicked = false;
  bool _isReClicked = false;
  bool _isTrClicked = false;
  bool _isBrClicked = false;
  bool _isCaClicked = false;
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  late Timer _timer2;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late String randomElement;
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
                        getCoins();
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

  int coins = 0;
  Future<void> getCoins() async {
    int _coins = await DatabaseHelper().getCoins(widget.user.id!);
    setState(() {
      coins = _coins;
    });
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
            getCoins();
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
                            'assets/images/games/backgrounds/classroom.jpg'),
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

                      //Livre
                      Positioned(
                        bottom: 1,
                        top: height * 0.1,
                        left: width > 500 ? width * 0.4 : width * 0.35,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un livre";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isLiClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/27.png',
                              width: width > 500 ? 120 : 100,
                            )),
                      ),

                      //Règle
                      Positioned(
                        top: width > 500 ? height * 0.44 : height * 0.41,
                        right: width > 500 ? width * 0.25 : width * 0.13,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une règle";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isReClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/30.png',
                              width: 80,
                            )),
                      ),
                      //colle
                      Positioned(
                        bottom: 1,
                        top: height * 0.15,
                        right: width * 0.7,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une colle";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isCoClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/23.png',
                              width: 50,
                            )),
                      ),
                      //Trousse
                      Positioned(
                        top: height < 778 ? height * 0.35 : height * 0.38,
                        right: width > 500 ? width * 0.6 : width * 0.65,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une trousse";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isTrClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/32.png',
                              width: width > 500 ? 100 : 80,
                            )),
                      ),
                      //Gomme
                      Positioned(
                        bottom: 1,
                        top: height * 0.16,
                        right: width > 500 ? width * 0.23 : width * 0.12,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une gomme";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isGoClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/25.png',
                              width: 40,
                            )),
                      ),
                      //Brosse
                      Positioned(
                        top: width > 500 ? height * 0.19 : height * 0.2,
                        left: width * 0.1,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Une brosse";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isBrClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/18.png',
                              width: width > 500 ? 100 : 80,
                            )),
                      ),
                      //Cartable
                      Positioned(
                        left: width > 500 ? width * 0.6 : width * 0.55,
                        bottom: 1,
                        child: GestureDetector(
                            onTap: () {
                              var element = "Un cartable";
                              if (element == randomElement && _canTap) {
                                setState(() {
                                  _isCaClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/20.png',
                              width: width > 500 ? 200 : 180,
                            )),
                      ),
                    ]),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/pics/20.png',
                        height: 50,
                        width: 50,
                        color: _isCaClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/18.png',
                        height: 50,
                        width: 50,
                        color: _isBrClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/27.png',
                        height: 50,
                        width: 50,
                        color: _isLiClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/32.png',
                        height: 50,
                        width: 50,
                        color: _isTrClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/30.png',
                        height: 50,
                        width: 50,
                        color: _isReClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/23.png',
                        height: 50,
                        width: 50,
                        color: _isCoClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/25.png',
                        height: 50,
                        width: 50,
                        color: _isGoClicked ? null : Palette.indigo,
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
