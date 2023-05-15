import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import '../../Widgets/Palette.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<StatefulWidget> createState() => TicTacToe_state();
}

class TicTacToe_state extends State<TicTacToe> {
  Game game = Game();
  bool gameover = false;
  int randomNumber = 0;
  bool variswin = false;
  bool isTie = false;
  bool isEnd = false;
  int win = 0;
  int loose = 0;
  int tie = 0;
  int tour = 1;

  @override
  void initState() {
    super.initState();
    game.board = Game.initGameBoard();
  }

  bool Win() {
    if (game.board![0] == game.board![1] &&
        game.board![0] == game.board![2] &&
        game.board![0] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![3] == game.board![4] &&
        game.board![3] == game.board![5] &&
        game.board![3] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![6] == game.board![7] &&
        game.board![6] == game.board![8] &&
        game.board![6] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![0] == game.board![3] &&
        game.board![0] == game.board![6] &&
        game.board![0] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![1] == game.board![4] &&
        game.board![1] == game.board![7] &&
        game.board![1] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![2] == game.board![5] &&
        game.board![2] == game.board![8] &&
        game.board![2] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![0] == game.board![4] &&
        game.board![0] == game.board![8] &&
        game.board![0] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![2] == game.board![4] &&
        game.board![2] == game.board![6] &&
        game.board![2] == "assets/images/games/O.png") {
      setState(() {
        isEnd = true;
      });
      return true;
    } else if (game.board![0] == game.board![1] &&
        game.board![0] == game.board![2] &&
        game.board![0] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![3] == game.board![4] &&
        game.board![3] == game.board![5] &&
        game.board![3] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![6] == game.board![7] &&
        game.board![6] == game.board![8] &&
        game.board![6] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![0] == game.board![3] &&
        game.board![0] == game.board![6] &&
        game.board![0] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![1] == game.board![4] &&
        game.board![1] == game.board![7] &&
        game.board![1] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![2] == game.board![5] &&
        game.board![2] == game.board![8] &&
        game.board![2] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![0] == game.board![4] &&
        game.board![0] == game.board![8] &&
        game.board![0] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (game.board![2] == game.board![4] &&
        game.board![2] == game.board![6] &&
        game.board![2] == "assets/images/games/X.png") {
      setState(() {
        isEnd = true;
      });
      return false;
    } else if (isEnd) {
      setState(() {
        isTie = true;
      });
      return false;
    } else {
      return false;
    }
  }

  void voidgame() {
    if (Win() && !isTie && isEnd && tour <= 10) {
      setState(() {
        tour += 1;
        win += 1;
        gameover = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        if (tour < 10) {
          Sfx.play("audios/sfx/done.mp3", 1);
          AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Resultat',
                  desc: 'Tu as gagner',
                  btnOkText: "Tour suivant",
                  btnOkOnPress: () {})
              .show();
          setState(() {
            game.board = Game.initGameBoard();
            isEnd = false;
            gameover = false;
          });
        }
      });
    }
    if (!Win() && !isTie && isEnd && tour <= 10) {
      setState(() {
        tour += 1;
        loose += 1;
        gameover = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        if (tour < 10) {
          Sfx.play("audios/sfx/lose.mp3", 1);
          AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Resultat',
                  desc: 'Tu as perdu',
                  btnOkText: "Tour suivant",
                  btnOkOnPress: () {})
              .show();
          setState(() {
            game.board = Game.initGameBoard();
            isEnd = false;
            gameover = false;
          });
        }
      });
    }
    if (!Win() && isTie && tour <= 10) {
      setState(() {
        isTie = false;
        tour += 1;
        tie += 1;
        gameover = true;
      });
      Timer(const Duration(milliseconds: 500), () {
        if (tour < 10) {
          Sfx.play("audios/sfx/tw.mp3", 1);
          AwesomeDialog(
                  context: context,
                  headerAnimationLoop: false,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Resultat',
                  desc: 'Égalité',
                  btnOkText: "Tour suivant",
                  btnOkOnPress: () {})
              .show();
          setState(() {
            game.board = Game.initGameBoard();
            isEnd = false;
            gameover = false;
          });
        }
      });
    }
    if (tour >= 10) {
      setState(() {
        gameover = true;
      });
      if (win > loose) {
        Sfx.play("audios/sfx/win.mp3", 1);
      }
      if (win == loose) {
        Sfx.play("audios/sfx/tw.mp3", 1);
      }
      if (win < loose) {
        Sfx.play("audios/sfx/lose.mp3", 1);
      }
      AwesomeDialog(
        context: context,
        headerAnimationLoop: false,
        customHeader: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              color: win > loose ? Palette.yellow : Palette.red,
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Icon(
            win > loose ? Icons.star_rounded : Icons.heart_broken,
            color: Palette.white,
            size: 80,
          ),
        ),
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Fin de la partie !",
              style: TextStyle(
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
              win > loose
                  ? "Bravo, Tu as gagner !"
                  : win == loose
                      ? "Égalité !"
                      : "Dommage, Tu as perdue.",
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(
            win > loose
                ? "assets/images/mascotte/win2.gif"
                : win == loose
                    ? "assets/images/mascotte/win3.gif"
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
              builder: (context) => const TicTacToe(),
            ),
          );
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    double boardwidth = MediaQuery.of(context).size.width;
    double boardheight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.white,
          elevation: 1,
          iconTheme: const IconThemeData(color: Palette.black),
          title: Row(
            children: [
              Image.asset(
                "assets/images/games/tic-tac-toe.png",
                width: 40,
              ),
              const Text(
                " Tic-Tac-Toe",
                style: TextStyle(color: Palette.black),
              ),
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(flex: 6, child: SizedBox()),
                  const Text(
                    "Tour",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Expanded(child: SizedBox()),
                  Text(
                    tour > 10 ? "10" : tour.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Palette.red),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "sur",
                    style: TextStyle(fontSize: 16),
                  ),
                  const Expanded(child: SizedBox()),
                  const Text(
                    "10",
                    style: TextStyle(fontSize: 20, color: Palette.blue),
                  ),
                  const Expanded(flex: 6, child: SizedBox()),
                ],
              ),
            ),
            SizedBox(
              width: boardwidth,
              height: boardheight / 2,
              child: GridView.count(
                crossAxisCount: Game.boardlenth ~/ 3,
                padding: const EdgeInsets.all(20.0),
                children: List.generate(Game.boardlenth, (index) {
                  return InkWell(
                    onTap: gameover
                        ? null
                        : () {
                            Sfx.play("audios/sfx/zew.mp3", 1);
                            setState(() {
                              if (game.board![index] == "") {
                                game.board![index] =
                                    "assets/images/games/O.png";
                                Random random = Random();
                                List<int> casenum = [];
                                for (int j = 0; j < 9; j++) {
                                  if (game.board![j] == "") {
                                    casenum.add(j);
                                  }
                                }
                                int randomIndex =
                                    random.nextInt(casenum.length);
                                randomNumber = casenum[randomIndex];
                                game.board![randomNumber] =
                                    "assets/images/games/X.png";
                              }
                              int count = 0;
                              for (int i = 0; i < 9; i++) {
                                if (game.board![i] != "") {
                                  count++;
                                }
                              }
                              if (count == 9) {
                                isEnd = true;
                              }
                              voidgame();
                            });
                          },
                    child: Container(
                      width: Game.blocsize,
                      height: Game.blocsize,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: index == 0
                            ? const Border(
                                top: BorderSide(
                                    color: Colors.transparent, width: 3),
                                left: BorderSide(
                                    color: Colors.transparent, width: 3),
                                right: BorderSide(
                                    color: Palette.darkGrey, width: 3),
                                bottom: BorderSide(
                                    color: Palette.darkGrey, width: 3),
                              )
                            : index == 1
                                ? const Border(
                                    top: BorderSide(
                                        color: Colors.transparent, width: 3),
                                    left: BorderSide(
                                        color: Palette.darkGrey, width: 3),
                                    right: BorderSide(
                                        color: Palette.darkGrey, width: 3),
                                    bottom: BorderSide(
                                        color: Palette.darkGrey, width: 3),
                                  )
                                : index == 2
                                    ? const Border(
                                        top: BorderSide(
                                            color: Colors.transparent,
                                            width: 3),
                                        left: BorderSide(
                                            color: Palette.darkGrey, width: 3),
                                        right: BorderSide(
                                            color: Colors.transparent,
                                            width: 3),
                                        bottom: BorderSide(
                                            color: Palette.darkGrey, width: 3),
                                      )
                                    : index == 3
                                        ? const Border(
                                            top: BorderSide(
                                                color: Palette.darkGrey,
                                                width: 3),
                                            left: BorderSide(
                                                color: Colors.transparent,
                                                width: 3),
                                            right: BorderSide(
                                                color: Palette.darkGrey,
                                                width: 3),
                                            bottom: BorderSide(
                                                color: Palette.darkGrey,
                                                width: 3),
                                          )
                                        : index == 5
                                            ? const Border(
                                                top: BorderSide(
                                                    color: Palette.darkGrey,
                                                    width: 3),
                                                left: BorderSide(
                                                    color: Palette.darkGrey,
                                                    width: 3),
                                                right: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 3),
                                                bottom: BorderSide(
                                                    color: Palette.darkGrey,
                                                    width: 3),
                                              )
                                            : index == 6
                                                ? const Border(
                                                    top: BorderSide(
                                                        color: Palette.darkGrey,
                                                        width: 3),
                                                    left: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 3),
                                                    right: BorderSide(
                                                        color: Palette.darkGrey,
                                                        width: 3),
                                                    bottom: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 3),
                                                  )
                                                : index == 7
                                                    ? const Border(
                                                        top: BorderSide(
                                                            color: Palette
                                                                .darkGrey,
                                                            width: 3),
                                                        left: BorderSide(
                                                            color: Palette
                                                                .darkGrey,
                                                            width: 3),
                                                        right: BorderSide(
                                                            color: Palette
                                                                .darkGrey,
                                                            width: 3),
                                                        bottom: BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 3),
                                                      )
                                                    : index == 8
                                                        ? const Border(
                                                            top: BorderSide(
                                                                color: Palette
                                                                    .darkGrey,
                                                                width: 3),
                                                            left: BorderSide(
                                                                color: Palette
                                                                    .darkGrey,
                                                                width: 3),
                                                            right: BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 3),
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .transparent,
                                                                width: 3),
                                                          )
                                                        : const Border(
                                                            top: BorderSide(
                                                                color: Palette
                                                                    .darkGrey,
                                                                width: 3),
                                                            left: BorderSide(
                                                                color: Palette
                                                                    .darkGrey,
                                                                width: 3),
                                                            right: BorderSide(
                                                                color: Palette
                                                                    .darkGrey,
                                                                width: 3),
                                                            bottom: BorderSide(
                                                                color: Palette
                                                                    .darkGrey,
                                                                width: 3),
                                                          ),
                      ),
                      child: Center(
                        child: game.board![index].isEmpty
                            ? const Text("")
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  game.board![index],
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Row(
              children: const [
                Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
                Image(
                  image: AssetImage('assets/images/games/O.png'),
                  width: 24,
                  height: 24,
                ),
                Expanded(child: SizedBox()),
                Text(
                  "Égalités",
                  style: TextStyle(
                      color: Palette.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: SizedBox()),
                Image(
                  image: AssetImage('assets/images/games/X.png'),
                  width: 24,
                  height: 24,
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: boardwidth / 4,
                      height: boardwidth / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image.asset(
                          "assets/images/avatars/avatar_girl.png",
                        ),
                      ),
                    ),
                    const Text(
                      "SALMA",
                      style: TextStyle(
                        color: Palette.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Text(
                  win.toString(),
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 24,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Text(
                  tie.toString(),
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 24,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Text(
                  loose.toString(),
                  style: const TextStyle(
                    color: Colors.black45,
                    fontSize: 24,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  children: [
                    SizedBox(
                      width: boardwidth / 4,
                      height: boardwidth / 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/logo.png",
                        ),
                      ),
                    ),
                    const Text(
                      "BUBBLE",
                      style: TextStyle(
                        color: Palette.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ));
  }
}

class Player {
  static const x = "X";
  static const o = "O";
  static const empty = "";
}

class Game {
  static const boardlenth = 9;
  static const blocsize = 100.0;

  List<String>? board;
  static List<String>? initGameBoard() =>
      List.generate(boardlenth, (index) => Player.empty);
}
