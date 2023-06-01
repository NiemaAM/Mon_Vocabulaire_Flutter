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

class DressingRoom extends StatefulWidget {
  final User user;
  const DressingRoom({super.key, required this.user});

  @override
  State<DressingRoom> createState() => _DressingRoomState();
}

class _DressingRoomState extends State<DressingRoom> {
  int countdown = 5;
  late Timer _timer;
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
              if (dressing.isNotEmpty) {
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
                                DressingRoom(user: widget.user),
                          ),
                        );
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
                builder: (context) => DressingRoom(user: widget.user),
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
                        'assets/images/games/backgrounds/dressing.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Stack(
                  children: [
                    //Robe
                    Positioned(
                      bottom: height * 0.2,
                      right: width > 450 ? width * 0.15 : width * 0.08,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Une robe" && _canTap) {
                            _isDressClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);

                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/190.png',
                          width: width > 450 ? 180 : 140,
                          height: width > 450 ? 180 : 140,
                          fit: BoxFit.cover,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    //Manteau
                    Positioned(
                      bottom: width > 450 ? height * 0.24 : height * 0.23,
                      right: width > 450 ? (width / 2) - 10 : width * 0.48,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Un manteau" && _canTap) {
                            _isCoatClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/187.png',
                          width: width > 450 ? 160 : 120,
                          height: width > 450 ? 160 : 120,
                          fit: BoxFit.cover,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    // Bottes
                    Positioned(
                      bottom: height * 0.02,
                      left: width > 450 ? width * 0.3 : width * 0.27,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Des bottes" && _canTap) {
                            _isBootsClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          "assets/images/pics/175.png",
                          scale: width > 450 ? 5 : 7,
                          fit: BoxFit.cover,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    //Espadrilles
                    Positioned(
                      bottom: height * 0.01,
                      left: width > 500 ? width * 0.15 : width * 0.05,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Des espadrilles" && _canTap) {
                            _isSneakersClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);

                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/183.png',
                          scale: width > 450 ? 5 : 7,
                          color: Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //Tricot
                    Positioned(
                      bottom: height * 0.3,
                      left: width * 0.35,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Un tricot" && _canTap) {
                            _isSweatherClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/193.png',
                          scale: width > 450 ? 5 : 7,
                          color: Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    //Lunettes
                    Positioned(
                      bottom: height * 0.11,
                      left: width > 500 ? width * 0.56 : width * 0.6,
                      child: GestureDetector(
                        onTap: () {
                          if (randomElement == "Des lunettes" && _canTap) {
                            _isGlassesClicked = true;
                            Voice.play(
                                "audios/voices/${ElementsAudios['$randomElement']}",
                                1);
                            randomElementFunc();
                          }
                        },
                        child: Image.asset(
                          'assets/images/pics/186.png',
                          scale: width > 450 ? 7 : 10,
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
                      //robe
                      Image.asset(
                        "assets/images/pics/190.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isDressClicked ? null : Colors.black,
                      ),
                      //manteau
                      Image.asset(
                        "assets/images/pics/187.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isCoatClicked ? null : Colors.black,
                      ),
                      //bottes
                      Image.asset(
                        "assets/images/pics/175.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isBootsClicked ? null : Colors.black,
                      ),
                      //espadrilles
                      Image.asset(
                        "assets/images/pics/183.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isSneakersClicked ? null : Colors.black,
                      ),
                      //tricot
                      Image.asset(
                        "assets/images/pics/193.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isSweatherClicked ? null : Colors.black,
                      ),
                      //lunettes
                      Image.asset(
                        "assets/images/pics/186.png",
                        scale: width > 450 ? 8 : 10,
                        color: _isGlassesClicked ? null : Colors.black,
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
