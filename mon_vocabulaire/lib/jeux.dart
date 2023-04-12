import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/appbargame.dart';

import 'package:mon_vocabulaire/Widgets/palette.dart';

import 'Widgets/containergame.dart';

class Jeux extends StatefulWidget {
  const Jeux({Key? key}) : super(key: key);

  @override
  State<Jeux> createState() => _JeuxState();
}

class _JeuxState extends State<Jeux> {
  int chances = 3;
  void song() async {}
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: QuizAppBar1()),
      body: Center(
          child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(35),
        crossAxisSpacing: 5,
        mainAxisSpacing: 15,
        crossAxisCount: 2,
        children: [
          Button(
            content: Image.asset(
              "assets/mushroom.png",
              height: height * 0.1,
              width: width * 0.3,
            ),
            color: Colors.pink,
            callback: song,
            heigth: height * 0.20,
            width: width * 0.40,
            text: 'Niveau 1',
            coin: '20',
          ),
          Button(
            content: Image.asset(
              "assets/game-console (1).png",
              height: height * 0.1,
              width: width * 0.3,
            ),
            color: Colors.green,
            callback: song,
            heigth: height * 0.20,
            width: width * 0.40,
            text: 'Niveau 2',
            coin: '50',
          ),
          Button(
            content: Image.asset(
              "assets/puzzle.png",
              height: height * 0.1,
              width: width * 0.3,
            ),
            color: Colors.blueAccent,
            callback: song,
            heigth: height * 0.20,
            width: width * 0.40,
            text: 'Niveau 3',
            coin: '45',
          ),
          Button(
            content: Image.asset(
              "assets/mushroom.png",
              height: height * 0.1,
              width: width * 0.3,
            ),
            color: Colors.purpleAccent,
            callback: song,
            heigth: height * 0.20,
            width: width * 0.40,
            text: 'Niveau 4',
            coin: '60',
          ),
          Button(
            content: Image.asset(
              "assets/puzzle.png",
              height: height * 0.1,
              width: width * 0.3,
            ),
            color: Colors.greenAccent,
            callback: song,
            heigth: height * 0.20,
            width: width * 0.40,
            text: 'Niveau 5',
            coin: '80',
          ),
          Button(
            content: Image.asset(
              "assets/game-console (1).png",
              height: height * 0.1,
              width: width * 0.3,
            ),
            color: Colors.redAccent,
            callback: song,
            heigth: height * 0.20,
            width: width * 0.40,
            text: 'Niveau 6',
            coin: '100',
          ),
        ],
      )),
    );
  }
}
