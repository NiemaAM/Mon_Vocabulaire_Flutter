import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/message_mascotte.dart';

class TrouvailleBureau extends StatefulWidget {
  const TrouvailleBureau({super.key});

  @override
  State<TrouvailleBureau> createState() => _TrouvailleBureauState();
}

class _TrouvailleBureauState extends State<TrouvailleBureau> {
  bool _isCoClicked = false;
  bool _isGoClicked = false;
  bool _isLiClicked = false;
  bool _isReClicked = false;
  bool _isTrClicked = false;
  bool _isBrClicked = false;
  bool _isCaClicked = false;

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
    'Un cartable'
  ];
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
                ? "Bravo, tu as trouvé tous les animaux !"
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
            builder: (context) => const TrouvailleBureau(),
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
          Positioned(
            right: 1,
            top: -55,
            child: BubbleMessage(
              widget: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 20, bottom: 8),
                    child: IconButton(
                      onPressed: () {},
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
                        color: Color(0xFF0E57AC),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Stack(children: [
            Container(
              height: height * 0.6,
              width: width * 0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/games/backgrounds/class.jpg'),
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
                    if (element == randomSchool) {
                      _isCaClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
                    if (element == randomSchool) {
                      _isBrClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
              bottom: height * 0.14,
              left: width * 0.32,
              child: GestureDetector(
                  onTap: () {
                    var element = "Un livre";
                    if (element == randomSchool) {
                      _isLiClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
              bottom: height * 0.15,
              right: width * 0.55,
              child: GestureDetector(
                  onTap: () {
                    var element = "Une trousse";
                    if (element == randomSchool) {
                      _isTrClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
              bottom: height * 0.14,
              right: width * 0.35,
              child: GestureDetector(
                  onTap: () {
                    var element = "Une règle";
                    if (element == randomSchool) {
                      _isReClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
              bottom: height * 0.16,
              right: width * 0.38,
              child: GestureDetector(
                  onTap: () {
                    var element = "Une colle";
                    if (element == randomSchool) {
                      _isCoClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
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
                    var element = "Un cartable";
                    if (element == randomSchool) {
                      _isGoClicked = true;
                      print("You win");
                      randomSchoolFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/pics/25.png',
                    height: 25,
                    width: 25,
                  )),
            ),
          ]),

          //élements à trouver
        ],
      ),
    );
  }
}
