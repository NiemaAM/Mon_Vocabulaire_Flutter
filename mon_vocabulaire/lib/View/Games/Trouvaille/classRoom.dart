import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/ferme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/message_mascotte.dart';

class ClassRoom extends StatefulWidget {
  const ClassRoom({super.key});

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
    // 'Un cartable',
    // 'Une brosse'
  ];
  Map<String, String> ElementsAudios = {
    'Un bureau': "4.mp3",
    'Une fenêtre': "9.mp3",
    'Une horloge': "10.mp3",
    'Une maîtresse': "37.mp3",
    'Un tableau': "15.mp3",
    // 'Un cartable': "20.mp3",
    // 'Une brosse': "18.mp3"
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
            if (duration == 0) {
              timer.cancel();
            }
          }
        });
      });
    }
  }

  void endGame() {
    if (duration > 0) {
      _controllerConfetti.play();
      Sfx.play("audios/sfx/win.mp3", 1);
    } else {
      Sfx.play("audios/sfx/lose.mp3", 1);
    }

    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      customHeader: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: duration > 0 ? Palette.yellow : Palette.red,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Icon(
          duration > 0 ? Icons.star_rounded : Icons.timer,
          color: Palette.white,
          size: 80,
        ),
      ),
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            duration > 0
                ? "Très bon travail !"
                : "Oh non, le temps est écoulé !",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Palette.pink,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            duration > 0
                ? "Bravo, tu as trouvé tous les élements de la classe !"
                : "Tu y étais presque, essaye encore une fois",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          duration > 0
              ? "assets/images/mascotte/win.gif"
              : "assets/images/mascotte/lose.gif",
          scale: 4,
        ),
      ]),
      btnCancelIcon: Icons.home,
      btnCancelText: " ",
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnOkIcon: Icons.restart_alt_rounded,
      btnOkText: " ",
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Ferme(),
          ),
        );
      },
    ).show();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/search.png",
              width: 40,
            ),
            const Text(
              "  Trouvaille",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //Mot à trouver mascotte
          SafeArea(
            child: Stack(children: [
              LinearPercentIndicator(
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8, right: 10),
                              child: IconButton(
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
          ),
          Stack(children: [
            Container(
              height: height * 0.6,
              width: width * 0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/games/backgrounds/Classe.png'),
                  fit: BoxFit.fitHeight,
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
                    print("tableau");
                    if (element == randomSchool) {
                      _isBoaClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Un tableau']}", 1);
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
                    print("maitresse");

                    if (element == randomSchool) {
                      _isTeaClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Une maitresse']}",
                          1);
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
              bottom: height * 0.005,
              left: width * 0.32,
              child: GestureDetector(
                  onTap: () {
                    var element = "Un bureau";
                    print("bureau");
                    if (element == randomSchool) {
                      _isDesClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Un bureau']}", 1);
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
                    print("bureau");
                    if (element == randomSchool) {
                      _isWinClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Une fenêtre']}", 1);
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
                    print("horloge");
                    if (element == randomSchool) {
                      _isCloClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Une horloge']}", 1);
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
            padding: const EdgeInsets.only(top: 10.0),
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
                  color: _isDesClicked ? null : Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
