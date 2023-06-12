// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
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

class Ferme extends StatefulWidget {
  final User user;
  const Ferme({super.key, required this.user});

  @override
  State<Ferme> createState() => _FermeState();
}

class _FermeState extends State<Ferme> with WidgetsBindingObserver {
  bool _isCowClicked = false;
  bool _isHorClicked = false;
  bool _isChiClicked = false;
  bool _isCheClicked = false;
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  late Timer _timer2;
  int duration = 60;
  bool isGameFinish = false;
  late String selectedAnimal;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  List<String> animals = ['Une vache', 'Une poule', 'Un cheval', "Un mouton"];
  Map<String, String> ElementsAudios = {
    'Une vache': "148.mp3",
    'Un cheval': "133.mp3",
    'Une poule': "127.mp3",
    'Un mouton': "144.mp3"
  };

  String randomElementFunc() {
    animals.shuffle();

    if (animals.isNotEmpty) {
      randomElement = animals[0];
      animals.removeAt(0);
      if (animals.length == 3 && duration > 0) {
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
            if (duration == 0) {
              timer.cancel();
              if (animals.isNotEmpty) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return GamePopup(
                      price: 30,
                      onButton1Pressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      onButton2Pressed: () {
                        if (coins >= 30) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Trouvaille(user: widget.user),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: Palette.indigo,
                            content: Text(
                              'Tu n\'as pas assez de pièces pour jouer.',
                              style:
                                  TextStyle(color: Palette.white, fontSize: 18),
                            ),
                          ));
                        }
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GamePopup(
          price: 30,
          onButton1Pressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButton2Pressed: () {
            getCoins();
            if (coins >= 30) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Trouvaille(user: widget.user),
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
                            'assets/images/games/backgrounds/ferme.jpg'),
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
                                      "Trouvez l'animal dans : $countdown",
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

                      //Poulailler
                      Positioned(
                          top: height > 800 ? height * 0.1 : height * 0.1,
                          right: width > 550 ? width * 0.7 : width * 0.7,
                          bottom: 1,
                          child: Image.asset(
                            'assets/images/pics/126.png',
                            width: width > 500 ? 120 : 80,
                          )),

                      //coq
                      Positioned(
                          top: height > 800 ? height * 0.30 : height * 0.35,
                          right: width > 550 ? width * 0.65 : width * 0.65,
                          bottom: 1,
                          child: Image.asset(
                            'assets/images/pics/121.png',
                            width: width > 500 ? 100 : 70,
                          )),

                      //vache
                      Positioned(
                        top: height > 800 ? height * 0.35 : height * 0.35,
                        right: width > 550 ? width * 0.2 : width * 0.1,
                        child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Une vache";
                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isCowClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/148.png',
                              width: width > 500 ? 180 : 120,
                            )),
                      ),

                      //cheval
                      Positioned(
                          top: height > 800 ? height * 0.55 : height * 0.5,
                          left: width > 500 ? width * 0.55 : width * 0.4,
                          child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Un cheval";

                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isHorClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/133.png',
                              width: width > 500 ? 200 : 180,
                            ),
                          )),

                      //mouton
                      Positioned(
                          top: height > 800 ? height * 0.6 : height * 0.6,
                          right: width > 550 ? width * 0.6 : width * 0.6,
                          bottom: 1,
                          child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Un mouton";
                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isCheClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/144.png',
                              width: width > 500 ? 150 : 110,
                            ),
                          )),

                      // Poule
                      Positioned(
                          top: height > 800 ? height * 0.2 : height * 0.2,
                          right: width > 550 ? width * 0.55 : width * 0.5,
                          bottom: 1,
                          child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Une poule";
                              if (selectedAnimal == randomElement && _canTap) {
                                setState(() {
                                  _isChiClicked = true;
                                });

                                randomElementFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/127.png',
                              width: width > 500 ? 80 : 60,
                            ),
                          )),
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
                        'assets/images/pics/148.png',
                        width: 75,
                        color: _isCowClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/133.png',
                        width: 75,
                        color: _isHorClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/127.png',
                        width: 65,
                        color: _isChiClicked ? null : Palette.indigo,
                      ),
                      Image.asset(
                        'assets/images/pics/144.png',
                        width: 75,
                        color: _isCheClicked ? null : Palette.indigo,
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
