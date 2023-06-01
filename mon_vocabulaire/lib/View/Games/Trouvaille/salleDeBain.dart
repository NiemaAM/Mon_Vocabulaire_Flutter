import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/message_mascotte.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../../Model/user.dart';
import '../../../Services/audio_background.dart';
import '../../../Services/sfx.dart';
import '../../../Services/voice.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/Popups/game_popup.dart';

class SalleDeBain extends StatefulWidget {
  final User user;
  const SalleDeBain({super.key, required this.user});

  @override
  State<SalleDeBain> createState() => _SalleDeBainState();
}

class _SalleDeBainState extends State<SalleDeBain> {
  int countdown = 5;
  late Timer _timer;
  bool _isToiletClicked = false;
  bool _isSinkClicked = false;
  bool _isSoapClicked = false;
  bool _isMirorClicked = false;
  bool _isTowelClicked = false;
  bool _canTap = false;

  int duration = 60;
  bool isGameFinish = false;
  late ConfettiController _controllerConfetti;
  late var randomElement;
  late var selectedElement;
  List<String> bathRoom = [
    'Des toilettes',
    'Une serviette',
    'Un lavabo',
    'Du savon',
    'Un miroire'
  ];
  Map<String, String> ElementsAudios = {
    'Des toilettes': "16.mp3",
    'Une serviette': "192.mp3",
    'Un lavabo': "47.mp3",
    'Du savon': "171.mp3",
    'Un miroire': "72.mp3",
  };

  String randomElementFunc() {
    bathRoom.shuffle();

    if (bathRoom.isNotEmpty) {
      randomElement = bathRoom[0];
      bathRoom.removeAt(0);
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
            duration--;
            _canTap = true;
            if (duration == 0) {
              timer.cancel();
              if (bathRoom.isNotEmpty) {
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
                            builder: (context) =>
                                SalleDeBain(user: widget.user),
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
                builder: (context) => SalleDeBain(user: widget.user),
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
    randomElementFunc();
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
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBarGames(
            user: widget.user,
            background: true,
          ),
          body: Stack(children: [
            Center(
              child: Container(
                height: height * 0.6,
                width: width * 0.9,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/games/backgrounds/bathroom.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Stack(
                  children: [
                    //toilettes
                    Positioned(
                      bottom: width > 450 ? height * 0.1 : height * 0.07,
                      right: width > 450 ? width * 0.05 : -60,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Des toilettes" && _canTap) {
                            _isToiletClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);

                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/16.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    //serviette
                    Positioned(
                      bottom: width > 450 ? height * 0.21 : height * 0.2,
                      right: width > 450 ? (width / 2) - 100 : 100,
                      child: GestureDetector(
                        onTap: () {
                          print("serviette");
                          if (randomElement == "Une serviette" && _canTap) {
                            _isTowelClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/192.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    // lavabo
                    Positioned(
                      bottom: width > 450 ? height * 0.25 : height * 0.23,
                      left: width > 450 ? (width / 3) - 100 : width * 0.05,
                      child: GestureDetector(
                        onTap: () {
                          print("lavabo");
                          if (randomElement == "Un lavabo" && _canTap) {
                            _isSinkClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          "assets/images/games/lavabo.png",
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    //savon
                    Positioned(
                      bottom: height * 0.33,
                      left: width > 500 ? (width / 2.9) : width * 0.3,
                      child: GestureDetector(
                        onTap: () {
                          print("savon");
                          if (randomElement == "Du savon" && _canTap) {
                            _isSoapClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            print("You win");
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/171.png',
                          width: 40,
                          height: 40,
                          color: Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //miroire
                    Positioned(
                      bottom: height * 0.4,
                      left: width > 500 ? (width / 5.8) : width * 0.07,
                      child: GestureDetector(
                        onTap: () {
                          print("miroire");
                          if (randomElement == "Un miroire" && _canTap) {
                            _isMirorClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/72.png',
                          width: 130,
                          height: 130,
                          color: Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        "assets/images/pics/171.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isSoapClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        "assets/images/games/lavabo.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isSinkClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        "assets/images/pics/192.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isTowelClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        "assets/images/pics/16.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isToiletClicked ? null : Colors.black,
                      ),
                      Image.asset(
                        "assets/images/pics/72.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isMirorClicked ? null : Colors.black,
                      ),
                    ],
                  ),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: BubbleMessage(
                widget: countdown > 0
                    ? Text(
                        "Trouvez l'élément dans : $countdown",
                        style: TextStyle(
                            color: const Color(0xFF0E57AC),
                            fontSize: width > 450 ? 25 : 18),
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Voice.play(
                                  'audios/voices/${ElementsAudios['$randomElement']}',
                                  1);
                            },
                            icon: const Icon(
                              Icons.volume_up,
                              color: Color(0xFF0E57AC),
                              size: 35,
                            ),
                          ),
                          Text(
                            "$randomElement",
                            style: TextStyle(
                                color: const Color(0xFF0E57AC),
                                fontSize: width > 450 ? 25 : 18),
                          ),
                        ],
                      ),
              ),
            ),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 23),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 15,
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
