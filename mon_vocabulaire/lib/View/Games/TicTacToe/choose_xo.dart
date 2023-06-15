import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/View/Games/TicTacToe/tic_tac_toe.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';

class ChooseXO extends StatelessWidget {
  final User user;
  const ChooseXO({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBarGames(
        user: user,
        background: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            ClipOval(
              child: user.image.startsWith("assets")
                  ? Image.asset(
                      user.image,
                      fit: BoxFit.cover,
                      width: width / 2.5,
                      height: width / 2.5,
                    )
                  : Image.file(
                      File(user.image),
                      fit: BoxFit.cover,
                      width: width / 2.5,
                      height: width / 2.5,
                    ),
            ),
            const Expanded(child: SizedBox()),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicTacToe(
                            user: user,
                            player: 'X',
                            AIplayer: 'O',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 255, 34, 0),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Image.asset(
                          "assets/images/games/X.png",
                          scale: width > 500 ? 4 : 6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicTacToe(
                            user: user,
                            player: 'O',
                            AIplayer: 'X',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(100, 10, 202, 10),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Image.asset(
                          "assets/images/games/O.png",
                          scale: width > 500 ? 4 : 6,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
