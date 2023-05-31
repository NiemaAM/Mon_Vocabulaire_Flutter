import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/acceuil_themes.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/ferme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:confetti/confetti.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';

class cuisine extends StatefulWidget {
  const cuisine({super.key});

  @override
  State<cuisine> createState() => _cuisineState();
}

class _cuisineState extends State<cuisine> {
  int countdown = 10;
  late Timer _timer;
  int duration = 60;
  bool isGameFinish = false;
  int fermeObject = 0;
  bool _isfoeClicked = false;
  bool _isveClicked = false;
  bool _ispaClicked = false;  
  bool _iscaClicked = false;
  late ConfettiController _controllerConfetti;
  late var randomCuisine;
   Map<String, String> ElementsAudios = {
    'Une pastèque': "106.mp3",
    'Un verre': "89.mp3",
    'Un four': "83.mp3",
    'Un tajine': "113.mp3"
  };

  List<String> cuisine_ = ['Une pastèque', 'Un verre', 'Un four', 'Un tajine'];
  String randomcuisineFunc() {
    cuisine_.shuffle();

    if (cuisine_.isNotEmpty) {
      randomCuisine = cuisine_[0];
      print(randomCuisine);
      cuisine_.removeAt(0);
    } else {
      print("Fin du jeu");
      endGame();
    }

    return randomCuisine;
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
          if(duration == 0){
          AwesomeDialog(
              context: context,
              headerAnimationLoop: false,
              customHeader: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Palette.red,
                    borderRadius: const BorderRadius.all(Radius.circular(50))),
                child: Icon(
                  Icons.timer,
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
                    "Oh non, le temps est écoulé !",
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
                    "Tu y étais presque, essaye encore une fois",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Image.asset(
              "assets/images/mascotte/lose.gif",
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
                    builder: (context) => const cuisine(),
                  ),
                );
              },
            ).show();
          
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
            color:  Palette.yellow,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Icon(
          Icons.star_rounded,
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
             "Très bon travail !",
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
             "Bravo, tu as trouvé tous les mots !",
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
           "assets/images/mascotte/win.gif",
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
            builder: (context) => const cuisine(),
          ),
        );
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    AudioBK.pauseBK();
randomcuisineFunc();
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
      backgroundColor: Palette.white,
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
                          "Trouvez les mots dans : $countdown",
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
                                      'audios/voices/${ElementsAudios['$randomCuisine']}',
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
                              '$randomCuisine',
                              style: const TextStyle(
                                  color: Color(0xFF0E57AC), fontSize: 20),
                            ),
                          ],
                        ),
                  // widget:
                ),
              ),
            ]),
          ),
          Stack(
            children: [
              Container(
                width: width * 0.9,
                height: height > 800 ? height * 0.65 : height * 0.6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/games/backgrounds/cuizine.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Stack(children: [
                  //monkey
                  

                  Positioned(
                    bottom: width > 550 ? height * 0.13 : height * 0.11,
                    left: width > 550 ? width * 0.32 : width * 0.22 ,
                    child: GestureDetector(
                        onTap: () {
                        String name ="Un four";
                         if(name == randomCuisine){
                        _isfoeClicked=true;
                        randomcuisineFunc();
                        Voice.play(
                          "audios/voices/${ElementsAudios['Un four']}", 1);
                         }                        
                       },
                          child: Image.asset(
                            'assets/images/pics/83.png',
                            height: 140,
                            width: 160,
                            fit: BoxFit.fill,
                          ),
                        ),
                  ),

                  Positioned(
                    bottom: height > 800 ? height * 0.3 : height * 0.27,
                    left: width > 550 ? width * 0.57 : width * 0.62 ,
                    child: GestureDetector(
                        onTap: () {
                        String name = "Un verre";
                         if(name == randomCuisine){
                        _isveClicked=true;
                        randomcuisineFunc();
                        Voice.play(
                          "audios/voices/${ElementsAudios['Un verre']}", 1);
                         }                        },
                          child: Image.asset(
                            'assets/images/pics/89.png',
                            height: 60,
                            width:  60 ,
                            fit: BoxFit.fill,
                          ),
                        ),
                  ),

                  Positioned(
                    bottom: height > 550 ? height * 0.26 : height * 0.21,
                    left: width > 550 ? width * 0.7 : width * 0.75 ,
                    child: GestureDetector(
                        onTap: () {
                         String name = "Une pastèque";
                         if(name == randomCuisine){
                         _ispaClicked=true;
                          randomcuisineFunc();
                          Voice.play(
                          "audios/voices/${ElementsAudios['Une pastèque']}", 1);
                         }
                        },
                          child: Image.asset(
                            'assets/images/pics/106.png',
                            height: 50,
                            width:  90 ,
                            fit: BoxFit.fill,
                          ),
                        ),
                  ),

                   Positioned(
                    bottom: height > 800 ? height * 0.46 : height * 0.42,
                    left: width > 550 ? width * 0.66 : width * 0.75 ,
                    child: GestureDetector(
                        onTap: () {
                         String name = "Un tajine";
                         if(name == randomCuisine){
                         _iscaClicked=true;
                          randomcuisineFunc();
                          Voice.play(
                          "audios/voices/${ElementsAudios['Un tajine']}", 1);
                         }
                        },
                          child: Image.asset(
                            'assets/images/pics/113.png',
                            height: 50,
                            width: width > 550 ? 80 : 40,
                            fit: BoxFit.fill,
                          ),
                        ),
                  ),
                  
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
                  'assets/images/pics/83.png',
                  height: 75,
                  width: 75,
                  color: _isfoeClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/89.png',
                  height: 75,
                  width: 75,
                  color: _isveClicked ? null : Colors.black,
                ),
                Image.asset(
                  'assets/images/pics/106.png',
                  height: 75,
                  width: 75,
                  color: _ispaClicked ? null : Colors.black,
                ),
                 Image.asset(
                  'assets/images/pics/113.png',
                  height: 75,
                  width: 75,
                  color: _iscaClicked ? null : Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
