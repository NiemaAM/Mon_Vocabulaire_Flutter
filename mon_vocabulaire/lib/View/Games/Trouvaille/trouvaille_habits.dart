// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille.dart';
import 'package:mon_vocabulaire/Widgets/message_mascotte.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';

class Habits extends StatefulWidget {
  final User user;
  const Habits({super.key, required this.user});

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> with WidgetsBindingObserver {
  int countdown = 5;
  late Timer _timer;
  late Timer _timer2;
  bool _isDressClicked = false;
  bool _isCoatClicked = false;
  bool _isBootsClicked = false;
  bool _isSneakersClicked = false;
  bool _isSweatherClicked = false;
  bool _isGlassesClicked = false;
  bool _canTap = false;

  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  late var selectedElement;
  List<String> dressing = [
    'Une robe',
    'Un manteau',
    'Des bottes',
    'Des espadrilles',
    'Un tricot',
    'Des lunettes'
  ];
  Map<String, String> ElementsAudios = {
    'Une robe': "190.mp3",
    'Un manteau': "187.mp3",
    'Des bottes': "175.mp3",
    'Des espadrilles': "183.mp3",
    'Un tricot': "193.mp3",
    'Des lunettes': "186.mp3",
  };

  String randomElementFunc() {
    dressing.shuffle();

    if (dressing.isNotEmpty) {
      randomElement = dressing[0];
      dressing.removeAt(0);
      if (dressing.length == 5 && duration > 0) {
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
              if (dressing.isNotEmpty) {
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
                            'assets/images/games/backgrounds/dressing.png'),
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
                                      "Trouvez l'habit dans : $countdown",
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

                      //Robe
                      Positioned(
                        top: width > 500 ? height * 0.29 : height * 0.285,
                        left: width > 500 ? width * 0.5 : width * 0.5,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Une robe" && _canTap) {
                              setState(() {
                                _isDressClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/190.png',
                            width: width > 500 ? 270 : 220,
                            fit: BoxFit.cover,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      //Manteau
                      Positioned(
                        top: height * 0.27,
                        right: width > 500 ? width * 0.52 : width * 0.55,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Un manteau" && _canTap) {
                              setState(() {
                                _isCoatClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/187.png',
                            width: width > 500 ? 250 : 200,
                            fit: BoxFit.cover,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      // Bottes
                      Positioned(
                        top: width > 500 ? height * 0.7 : height * 0.68,
                        left: width * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Des bottes" && _canTap) {
                              setState(() {
                                _isBootsClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            "assets/images/pics/175.png",
                            width: 130,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //Espadrilles
                      Positioned(
                        top: height * 0.75,
                        left: width * 0.6,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Des espadrilles" && _canTap) {
                              setState(() {
                                _isSneakersClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/183.png',
                            width: width > 500 ? 120 : 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      //Tricot
                      Positioned(
                        top: width > 500 ? height * 0.28 : height * 0.27,
                        left: width > 500 ? width * 0.38 : width * 0.33,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Un tricot" && _canTap) {
                              setState(() {
                                _isSweatherClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/193.png',
                            width: width > 500 ? 150 : 120,
                            fit: BoxFit.cover,
                            color: Colors.transparent,
                          ),
                        ),
                      ),

                      //Lunettes
                      Positioned(
                        top: width > 500 ? height * 0.63 : height * 0.6,
                        left: width * 0.65,
                        child: GestureDetector(
                          onTap: () {
                            if (randomElement == "Des lunettes" && _canTap) {
                              setState(() {
                                _isGlassesClicked = true;
                              });

                              randomElementFunc();
                            }
                          },
                          child: Image.asset(
                            'assets/images/pics/186.png',
                            width: 80,
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
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //robe
                        Image.asset(
                          "assets/images/pics/190.png",
                          scale: width > 450 ? 8 : 10,
                          color: _isDressClicked ? null : Palette.indigo,
                        ),
                        //manteau
                        Image.asset(
                          "assets/images/pics/187.png",
                          scale: width > 450 ? 8 : 10,
                          color: _isCoatClicked ? null : Palette.indigo,
                        ),
                        //bottes
                        Image.asset(
                          "assets/images/pics/175.png",
                          scale: width > 450 ? 8 : 10,
                          color: _isBootsClicked ? null : Palette.indigo,
                        ),
                        //espadrilles
                        Image.asset(
                          "assets/images/pics/183.png",
                          scale: width > 450 ? 8 : 10,
                          color: _isSneakersClicked ? null : Palette.indigo,
                        ),
                        //tricot
                        Image.asset(
                          "assets/images/pics/193.png",
                          scale: width > 450 ? 8 : 10,
                          color: _isSweatherClicked ? null : Palette.indigo,
                        ),
                        //lunettes
                        Image.asset(
                          "assets/images/pics/186.png",
                          scale: width > 450 ? 8 : 10,
                          color: _isGlassesClicked ? null : Palette.indigo,
                        ),
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
      ],
    );
  }
}
