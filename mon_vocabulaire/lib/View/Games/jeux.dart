import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/flip_card.dart';
import 'package:mon_vocabulaire/View/Games/math_game.dart';
import 'package:mon_vocabulaire/View/Games/puzzle.dart';
import 'package:mon_vocabulaire/View/Games/tic_tac_toe.dart';
import '../../Model/user.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/game_bloc.dart';

class Games extends StatefulWidget {
  final User user;
  const Games({super.key, required this.user});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: const [
          GameBloc(
            color: Palette.lightGreen,
            image: "assets/images/games/JuMots.png",
            price: '50',
            text: "JuMots",
            page: FlipCardGame(),
          ),
          GameBloc(
            color: Palette.orange,
            image: "assets/images/games/tic-tac-toe.png",
            price: '20',
            text: "Tic Tac Toe",
            page: TicTacToe(),
          ),
          GameBloc(
            color: Palette.pink,
            image: "assets/images/games/puzzle.png",
            price: '80',
            text: "Puzzle",
            page: Puzzle(),
          ),
          GameBloc(
            color: Palette.red,
            image: "assets/images/games/search.png",
            price: '100',
            text: "Trouvailles",
            page: FlipCardGame(),
            enabled: false,
          ),
          GameBloc(
            color: Palette.blue,
            image: "assets/images/games/bubbles.png",
            price: '50',
            text: "NinjaBubbles",
            page: FlipCardGame(),
            enabled: false,
          ),
          GameBloc(
            color: Color.fromARGB(255, 30, 173, 173),
            image: "assets/images/games/apple.png",
            price: '80',
            text: "Recoltte",
            page: FlipCardGame(),
            enabled: false,
          ),
          GameBloc(
            color: Color.fromARGB(255, 206, 89, 227),
            image: "assets/images/games/math_game.png",
            price: '80',
            text: "FruityMaths",
            page: MathGame(),
            enabled: false,
          ),
          GameBloc(
            color: Color.fromARGB(255, 171, 131, 85),
            image: "assets/images/games/chess.png",
            price: '100',
            text: "Dames",
            page: FlipCardGame(),
            enabled: false,
          ),
        ],
      ),
    ));
  }
}
