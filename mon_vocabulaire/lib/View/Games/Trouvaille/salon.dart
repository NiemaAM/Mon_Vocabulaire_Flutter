import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../Model/user.dart';
import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/message_mascotte.dart';
import 'TrouvailleThemes.dart';
import 'salleDeBain.dart';

class Salon extends StatefulWidget {
  final User user;
  const Salon({super.key, required this.user});

  @override
  State<Salon> createState() => _SalonState();
}

class _SalonState extends State<Salon> {
  bool _isTelClicked = false;
  bool _isBoyClicked = false;
  bool _isBebClicked = false;
  bool _isMomClicked = false;
  bool _isGirClicked = false;
  bool _isVasClicked = false;
  bool _canTap = false;
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
            _canTap = true;
            if (duration == 0) {
              timer.cancel();
              if (Room.isNotEmpty) {
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
                            builder: (context) => Salon(user: widget.user),
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
                builder: (context) => Salon(user: widget.user),
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
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBarGames(
            user: widget.user,
            background: true,
          ),
          body: Column(
            children: [
              //Mot à trouver mascotte
              SafeArea(
                child: Stack(children: [
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
                                IconButton(
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
                      image: AssetImage(
                          'assets/images/games/backgrounds/maison.png'),
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

                        if (element == randomRoom && _canTap) {
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

                        if (element == randomRoom && _canTap) {
                          _isTelClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une télévision']}",
                              1);

                          randomRoomFunc();
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
                        var element = "Un bébé";

                        if (element == randomRoom && _canTap) {
                          _isBebClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Un bébé']}", 1);

                          randomRoomFunc();
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

                        if (element == randomRoom && _canTap) {
                          _isMomClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une maman']}",
                              1);

                          randomRoomFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/games/maman.png',
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

                        if (element == randomRoom && _canTap) {
                          _isBoyClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Un garcon']}",
                              1);

                          randomRoomFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/games/garcon.png',
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

                        if (element == randomRoom && _canTap) {
                          _isGirClicked = true;
                          Voice.play(
                              "audios/voices/${ElementsAudios['Une fille']}",
                              1);

                          randomRoomFunc();
                        }
                      },
                      child: Image.asset(
                        'assets/images/games/fille.png',
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
