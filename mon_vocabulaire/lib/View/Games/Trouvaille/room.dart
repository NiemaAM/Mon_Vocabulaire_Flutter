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

class Room extends StatefulWidget {
  const Room({super.key});

  @override
  State<Room> createState() => _RoomState();
}

class _RoomState extends State<Room> {
  bool _isTelClicked = false;
  bool _isBoyClicked = false;
  bool _isBebClicked = false;
  bool _isMomClicked = false;
  bool _isGirClicked = false;
  bool _isVasClicked = false;

  int countdown = 5;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomRoom;
  List<String> Room = [
    'Une télévision',
    'Un garcon',
    'Une maman',
    'Une fille',
    'Un vase',
    'Un bebe'
  ];
  Map<String, String> ElementsAudios = {
    'Une télévision': "75.mp3",
    'Un vase': "76.mp3",
    'Une fille': "35.mp3",
    'Un garcon': "36.mp3",
    "Une maman": "63.mp3",
    "Un bebe": "55.mp3",
  };
  String randomRoomFunc() {
    Room.shuffle();

    if (Room.isNotEmpty) {
      randomRoom = Room[0];
      print(randomRoom);
      Room.removeAt(0);
    } else {
      print("Fin du jeu");
      endGame();
    }

    return randomRoom;
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
                ? "Bravo, tu as trouvé tous les élements de la chambre !"
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Ferme(),
          ),
        );
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
    randomRoomFunc();
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
              width: 20,
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
                                      'audios/voices/${ElementsAudios['$randomRoom']}',
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
                              "$randomRoom",
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
                      AssetImage('assets/images/games/trouvaille/maison.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //vase
            Positioned(
              bottom: height * 0.23,
              left: width < 550 ? width * 0.46 : width * 0.43,
              child: GestureDetector(
                  onTap: () {
                    var element = "Un vase";
                    print("vase");
                    print("$width");
                    if (element == randomRoom) {
                      _isVasClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Un vase']}", 1);
                      print("You win");
                      randomRoomFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/pics/76.png',
                    height: height < 900 ? 50 : 65,
                    width: width < 550 ? 50 : 65,
                  )),
            ),
            //Television
            Positioned(
              bottom: height < 900 ? height * 0.06 : height * 0.054,
              left: width < 550 ? width * 0.5 : width * 0.46,
              child: GestureDetector(
                  onTap: () {
                    var element = "Une télévision";
                    print("tele");
                    print("$width");
                    if (element == randomRoom) {
                      _isTelClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Une télévision']}",
                          1);
                      print("You win");
                      randomRoomFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/pics/75.png',
                    height: height < 900 ? 95 : 130,
                    width: width < 550 ? 95 : 130,
                  )),
            ),

            //bébé
            Positioned(
              bottom: height * 0.02,
              left: width * 0.45,
              child: GestureDetector(
                  onTap: () {
                    var element = "Un bebe";
                    print("$height");
                    print("bébé");
                    if (element == randomRoom) {
                      _isBebClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Un bebe']}", 1);
                      print("You win");
                      randomRoomFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/pics/55.png',
                    height: height < 900 ? 50 : 80,
                    width: width < 550 ? 50 : 70,
                  )),
            ),

            //maman
            Positioned(
              bottom: height < 900 ? height * 0.0001 : height * 0.01,
              left: width < 550 ? width * 0.02 : width * 0.05,
              child: GestureDetector(
                  onTap: () {
                    var element = "Une maman";
                    print("$height");
                    print("maman");
                    if (element == randomRoom) {
                      _isMomClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Une maman']}", 1);
                      print("You win");
                      randomRoomFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/games/trouvaille/maman.png',
                    height: height < 900 ? 150 : 200,
                    width: width < 550 ? 150 : 200,
                  )),
            ),

            //garcon
            Positioned(
              bottom: height < 900 ? height * 0.33 : height * 0.33,
              left: width < 550 ? width * 0.05 : width * 0.12,
              child: GestureDetector(
                  onTap: () {
                    var element = "Un garcon";
                    print("$height");
                    print("garcon");
                    if (element == randomRoom) {
                      _isBoyClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Un garcon']}", 1);
                      print("You win");
                      randomRoomFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/games/trouvaille/garcon.png',
                    height: height < 900 ? 145 : 180,
                    width: width < 550 ? 145 : 180,
                  )),
            ),

            //fille
            Positioned(
              bottom: height * 0.36,
              left: width * 0.45,
              child: GestureDetector(
                  onTap: () {
                    var element = "Une fille";
                    print("$height");
                    print("fille");
                    if (element == randomRoom) {
                      _isGirClicked = true;
                      Voice.play(
                          "audios/voices/${ElementsAudios['Une fille']}", 1);
                      print("You win");
                      randomRoomFunc();
                    } else {
                      print("You lose");
                    }
                  },
                  child: Image.asset(
                    'assets/images/games/trouvaille/fille.png',
                    height: height < 900 ? 60 : 75,
                    width: width < 550 ? 60 : 75,
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
                  'assets/images/pics/76.png',
                  height: height < 900 ? 40 : 50,
                  width: width < 550 ? 40 : 50,
                  color: _isVasClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/games/trouvaille/garcon.png',
                  height: height < 900 ? 56 : 90,
                  width: width < 550 ? 56 : 90,
                  color: _isBoyClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/games/trouvaille/fille.png',
                  height: height < 900 ? 45 : 65,
                  width: width < 550 ? 45 : 65,
                  color: _isGirClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/75.png',
                  height: height < 900 ? 40 : 60,
                  width: width < 550 ? 40 : 60,
                  color: _isTelClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/games/trouvaille/maman.png',
                  height: height < 900 ? 50 : 80,
                  width: width < 550 ? 50 : 80,
                  color: _isMomClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/55.png',
                  height: height < 900 ? 40 : 80,
                  width: width < 550 ? 40 : 80,
                  color: _isBebClicked ? null : Colors.black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
