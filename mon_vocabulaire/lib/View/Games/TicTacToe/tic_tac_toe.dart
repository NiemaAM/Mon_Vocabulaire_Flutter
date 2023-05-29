// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/Popups/game_popup.dart';

class TicTacToe extends StatefulWidget {
  final User user;
  final String player;
  final String AIplayer;
  const TicTacToe(
      {super.key,
      required this.user,
      required this.player,
      required this.AIplayer});

  @override
  State<StatefulWidget> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  late List<List<String>> board;
  late String currentPlayer;
  late String computerPlayer;
  late bool gameOver;
  int partie = 1;
  int win = 0;
  int lose = 0;
  late ConfettiController _controllerConfetti;

  @override
  void initState() {
    super.initState();
    startNewGame();
    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  void startNewGame() {
    setState(() {
      board = List<List<String>>.generate(3, (_) => List<String>.filled(3, ''));
      currentPlayer = widget.player;
      computerPlayer = widget.AIplayer;
      gameOver = false;
    });
  }

  Future<void> autoPlay() async {
    if (currentPlayer == computerPlayer) {
      // If it's "O" player's turn, make a move automatically after a small delay
      Timer(const Duration(milliseconds: 100), () {
        makeAutoMove();
        checkWin(currentPlayer);
      });
    }
  }

  void makeMove(int row, int col) {
    if (!gameOver && board[row][col] == '') {
      setState(() {
        board[row][col] = currentPlayer;
        if (checkWin(currentPlayer)) {
          gameOver = true;
          showAlertDialog();
        } else if (checkDraw()) {
          gameOver = true;
          showAlertDialog();
        } else {
          currentPlayer =
              (currentPlayer == widget.player) ? computerPlayer : widget.player;
        }
      });
    }
  }

  void makeAutoMove() {
    // Check if AI can win in the next move
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          // Simulate the move
          board[row][col] = computerPlayer;
          if (checkWin(computerPlayer)) {
            setState(() {
              board[row][col] = computerPlayer;
              currentPlayer = widget.player;
            });
            showAlertDialog();
            return;
          }
          // Undo the move
          board[row][col] = '';
        }
      }
    }

    // Check if player can win in the next move and block the winning move
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          // Simulate the move
          board[row][col] = widget.player;
          if (checkWin(widget.player)) {
            setState(() {
              board[row][col] = computerPlayer;
              currentPlayer = widget.player;
            });
            return;
          }
          // Undo the move
          board[row][col] = '';
        }
      }
    }

    // Make a random move
    List<int> emptyCells = [];
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          emptyCells.add(row * 3 + col);
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      // Randomly select a cell from the available ones
      final random = Random();
      int randomIndex = random.nextInt(emptyCells.length);
      int row = emptyCells[randomIndex] ~/ 3;
      int col = emptyCells[randomIndex] % 3;
      setState(() {
        board[row][col] = computerPlayer;
        currentPlayer = widget.player;
      });
    }
  }

  bool checkWin(String player) {
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == player &&
          board[i][1] == player &&
          board[i][2] == player) {
        return true; // horizontal win
      }
      if (board[0][i] == player &&
          board[1][i] == player &&
          board[2][i] == player) {
        return true; // vertical win
      }
    }
    if (board[0][0] == player &&
        board[1][1] == player &&
        board[2][2] == player) {
      return true; // diagonal win (top-left to bottom-right)
    }
    if (board[0][2] == player &&
        board[1][1] == player &&
        board[2][0] == player) {
      return true; // diagonal win (top-right to bottom-left)
    }
    return false;
  }

  bool checkDraw() {
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (board[row][col] == '') {
          return false; // game is not a draw yet
        }
      }
    }
    return true; // game is a draw
  }

  bool endGame = false;
  void showAlertDialog() {
    if (checkWin(widget.player)) {
      setState(() {
        win++;
      });
    }
    if (checkWin(computerPlayer)) {
      setState(() {
        lose++;
      });
    }
    if (partie < 5) {
      if (!checkDraw()) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return GamePopup(
              oneButton: true,
              onButton1Pressed: () {
                Navigator.pop(context);
                setState(() {
                  partie++;
                  board.clear();
                  startNewGame();
                });
                if (partie == 5) {
                  setState(() {
                    endGame = true;
                  });
                }
              },
              onButton2Pressed: () {},
              win: checkWin(widget.player),
            );
          },
        );
      }
      if (checkDraw()) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return GamePopup(
              oneButton: true,
              onButton1Pressed: () {
                Navigator.pop(context);
                setState(() {
                  partie++;
                  board.clear();
                  startNewGame();
                });
              },
              onButton2Pressed: () {},
              win: false,
              tie: true,
            );
          },
        );
      }
    } else {
      if (win > lose) {
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
                  builder: (context) => TicTacToe(
                    user: widget.user,
                    player: widget.player,
                    AIplayer: widget.AIplayer,
                  ),
                ),
              );
            },
            win: win > lose,
            tie: win == lose,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    autoPlay();
    return Scaffold(
      backgroundColor: Palette.lightBlue,
      body: Stack(
        children: [
          Center(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                      color: Palette.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 1, 152, 240),
                            offset: Offset(0, 10))
                      ],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: SizedBox(),
                          ),
                          Image(
                            image: AssetImage(
                                'assets/images/games/${widget.player}.png'),
                            width: 30,
                            height: 30,
                          ),
                          const Expanded(flex: 2, child: SizedBox()),
                          Image(
                            image: AssetImage(
                                'assets/images/games/${widget.AIplayer}.png'),
                            width: 30,
                            height: 30,
                          ),
                          const Expanded(
                            flex: 4,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(left: width > 500 ? 50 : 0),
                            child: Image.asset(
                              widget.user.image,
                              width: 100,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Text(
                            win.toString(),
                            style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const Expanded(
                            flex: 2,
                            child: SizedBox(),
                          ),
                          Text(
                            lose.toString(),
                            style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const Expanded(child: SizedBox()),
                          Padding(
                            padding:
                                EdgeInsets.only(right: width > 500 ? 50 : 0),
                            child: Image.asset(
                              "assets/images/logo.png",
                              width: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomAppBarGames(
                  user: widget.user,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Partie $partie sur 5',
                      style: const TextStyle(
                          fontSize: 24,
                          color: Palette.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.only(
                      left: width > 500 ? 100 : 20,
                      right: width > 500 ? 100 : 20,
                      top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 1, 152, 240),
                              offset: Offset(0, 10))
                        ],
                        border: Border.all(
                          color: Palette.lightBlue,
                          width: 8.0,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(38),
                        )),
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext context, int index) {
                        int row = index ~/ 3;
                        int col = index % 3;
                        return GestureDetector(
                          onTap: () => makeMove(row, col),
                          child: Container(
                            decoration: BoxDecoration(
                                color: index % 2 == 1
                                    ? const Color.fromARGB(255, 218, 242, 255)
                                    : const Color.fromARGB(255, 200, 235, 255),
                                border: Border.all(
                                  color: Palette.lightBlue,
                                  width: 3.0,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(index == 0 ? 30 : 0),
                                    topRight:
                                        Radius.circular(index == 2 ? 30 : 0),
                                    bottomLeft:
                                        Radius.circular(index == 6 ? 30 : 0),
                                    bottomRight:
                                        Radius.circular(index == 8 ? 30 : 0))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: board[row][col].isEmpty
                                      ? const SizedBox()
                                      : Image.asset(
                                          "assets/images/games/${board[row][col]}.png")),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
      ),
    );
  }
}
