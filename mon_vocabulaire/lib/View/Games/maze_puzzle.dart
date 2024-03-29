// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:maze/maze.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/Popups/game_popup.dart';

class MazePuzzle extends StatefulWidget {
  final User user;
  final int partie;
  const MazePuzzle({super.key, required this.user, this.partie = 1});
  @override
  State<MazePuzzle> createState() => _MazePuzzleState();
}

class _MazePuzzleState extends State<MazePuzzle> {
  int checkpoints = 0;
  late ConfettiController _controllerConfetti;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper().substractCoins(widget.user.id!, 20);
    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  int coins = -1;
  RealtimeDataController controller = RealtimeDataController();
  Future<void> getUser() async {
    await controller.getUser(widget.user.id!);
    User? user = controller.user;
    setState(() {
      coins = user!.coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBarGames(
          user: widget.user,
          background: true,
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Partie ${widget.partie} sur 5',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Maze(
                  player: MazeItem('assets/images/logo.png', ImageType.asset),
                  columns: 8,
                  rows: 14,
                  wallThickness: 4.0,
                  wallColor: Palette.lightBlue,
                  checkpoints: [
                    MazeItem('assets/images/games/apple.png', ImageType.asset),
                    MazeItem('assets/images/games/apple.png', ImageType.asset),
                    MazeItem('assets/images/games/apple.png', ImageType.asset),
                    MazeItem('assets/images/games/apple.png', ImageType.asset),
                  ],
                  onCheckpoint: (int i) {
                    setState(() {
                      checkpoints++;
                    });
                    Sfx.play("audios/sfx/gotit.mp3", 1);
                  },
                  finish:
                      MazeItem('assets/images/games/flag.png', ImageType.asset),
                  onFinish: () {
                    if (checkpoints == 4 && widget.partie + 1 != 6) {
                      Sfx.play("audios/sfx/next.mp3", 1);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MazePuzzle(
                            user: widget.user,
                            partie: widget.partie + 1,
                          ),
                        ),
                      );
                    }
                    if (widget.partie + 1 == 6 && checkpoints == 4) {
                      _controllerConfetti.play();
                      bool isClicked = false;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return GamePopup(
                            isClicked: isClicked,
                            price: 20,
                            onButton1Pressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            onButton2Pressed: () {
                              getUser();
                              isClicked = true;
                              Timer(const Duration(seconds: 1), () {
                                if (coins >= 20) {
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MazePuzzle(
                                        user: widget.user,
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Palette.indigo,
                                    content: Text(
                                      'Tu n\'as pas assez de pièces pour jouer.',
                                      style: TextStyle(
                                          color: Palette.white, fontSize: 18),
                                    ),
                                  ));
                                }
                              });
                            },
                            win: true,
                          );
                        },
                      );
                    }
                  }),
            ),
            ConfettiWidget(
              gravity: 0,
              confettiController: _controllerConfetti,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              numberOfParticles: 20,
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Palette.lightGreen,
                Palette.blue,
                Palette.pink,
                Palette.orange,
                Palette.purple
              ], // manually specify the colors to be used
            ),
          ],
        )));
  }
}
