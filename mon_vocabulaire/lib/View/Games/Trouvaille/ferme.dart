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

class Ferme extends StatefulWidget {
  final User user;
  Ferme({super.key, required this.user});

  @override
  State<Ferme> createState() => _FermeState();
}

class _FermeState extends State<Ferme> {
  bool _isCowClicked = false;
  bool _isHorClicked = false;
  bool _isChiClicked = false;
  bool _isCheClicked = false;
  bool _canTap = false;
  int countdown = 5;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late String selectedAnimal;
  late ConfettiController _controllerConfetti;
  late var randomAnimal;
  List<String> animals = ['Une vache', 'Une poule', 'Un cheval', "Un mouton"];
  Map<String, String> animalsAudios = {
    'Une vache': "148.mp3",
    'Un cheval': "133.mp3",
    'Une poule': "127.mp3",
    'Un mouton': "144.mp3"
  };

  String randomAnimalFunc() {
    animals.shuffle();

    if (animals.isNotEmpty) {
      randomAnimal = animals[0];

      print(randomAnimal);
      animals.removeAt(0);
    } else {
      print("Fin du jeu");
      endGame();
    }
    //Voice.play("/", 1);
    return randomAnimal;
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
              if (animals.isNotEmpty) {
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
                            builder: (context) => Ferme(user: widget.user),
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
                builder: (context) => Ferme(user: widget.user),
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
    randomAnimalFunc();
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
          backgroundColor: Palette.white,
          appBar: CustomAppBarGames(
            user: widget.user,
            background: true,
          ),
          body: Column(
            children: [
              Stack(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: BubbleMessage(
                    widget: countdown > 0
                        ? Text(
                            "Trouvez l'animal dans : $countdown",
                            style: const TextStyle(
                                color: Color(0xFF0E57AC), fontSize: 15),
                          )
                        : Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Voice.play(
                                      'audios/voices/${animalsAudios['$randomAnimal']}',
                                      1);
                                },
                                icon: Icon(
                                  Icons.volume_up,
                                  color: Color(0xFF0E57AC),
                                  size: 35,
                                ),
                              ),
                              Text(
                                "$randomAnimal",
                                style: const TextStyle(
                                    color: Color(0xFF0E57AC), fontSize: 25),
                              ),
                            ],
                          ),
                    // widget:
                  ),
                ),
              ]),
              Stack(
                children: [
                  Container(
                    width: width * 0.9,
                    height: height > 800 ? height * 0.65 : height * 0.6,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/games/backgrounds/ferme.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(children: [
                      //mouton
                      Positioned(
                          bottom: height > 800 ? height * 0.15 : height * 0.08,
                          right: width > 550 ? width * 0.2 : width * 0.2,
                          child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Un mouton";
                              if (selectedAnimal == randomAnimal && _canTap) {
                                _isCheClicked = true;
                                Voice.play(
                                    "audios/voices/${animalsAudios['Un mouton']}",
                                    1);
                                randomAnimalFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/144.png',
                              width: 110,
                              height: 110,
                            ),
                          )),

                      //vache
                      Positioned(
                        top: height > 900 ? height * 0.25 : height * 0.22,
                        left: width > 550 ? width * 0.2 : width * 0.15,
                        child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Une vache";
                              print("vache");
                              if (selectedAnimal == randomAnimal && _canTap) {
                                _isCowClicked = true;
                                Voice.play(
                                    "audios/voices/${animalsAudios['Une vache']}",
                                    1);

                                randomAnimalFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/148.png',
                              height: 120,
                              width: 120,
                            )),
                      ),
// Poule
                      Positioned(
                          right: width > 550 ? width - 300 : width - 180,
                          bottom: height > 800 ? height * 0.08 : height * 0.05,
                          child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Une poule";
                              print("poule");
                              if (selectedAnimal == randomAnimal && _canTap) {
                                _isChiClicked = true;
                                Voice.play(
                                    "audios/voices/${animalsAudios['Une poule']}",
                                    1);
                                randomAnimalFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/127.png',
                              height: 60,
                              width: 60,
                            ),
                          )),
                      //Poulailler
                      Positioned(
                          top: height > 800 ? height - 850 : height - 900,
                          right: width > 550 ? width - 220 : width - 120,
                          bottom: -180,
                          child: Image.asset(
                            'assets/images/pics/126.png',
                            height: 80,
                            width: 80,
                          )),

                      //coq
                      Positioned(
                          right: width > 550 ? width - 340 : width - 220,
                          bottom: height > 900 ? height * 0.1 : height * 0.08,
                          child: Image.asset(
                            'assets/images/pics/121.png',
                            height: 70,
                            width: 70,
                          )),

                      //cheval
                      Positioned(
                          top: height > 800 ? height * 0.23 : height * 0.2,
                          right: width > 550 ? width - 500 : width * 0.15,
                          child: GestureDetector(
                            onTap: () {
                              selectedAnimal = "Un cheval";

                              if (selectedAnimal == randomAnimal && _canTap) {
                                _isHorClicked = true;
                                Voice.play(
                                    "audios/voices/${animalsAudios['Un cheval']}",
                                    1);
                                randomAnimalFunc();
                              }
                            },
                            child: Image.asset(
                              'assets/images/pics/133.png',
                              width: 100,
                              height: 100,
                            ),
                          )),
                    ]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/images/pics/148.png',
                      height: 75,
                      width: 75,
                      color: _isCowClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/133.png',
                      height: 75,
                      width: 75,
                      color: _isHorClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/127.png',
                      height: 50,
                      width: 50,
                      color: _isChiClicked ? null : Colors.black,
                    ),
                    Image.asset(
                      'assets/images/pics/144.png',
                      height: 75,
                      width: 75,
                      color: _isCheClicked ? null : Colors.black,
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
      ],
    );
  }
}
