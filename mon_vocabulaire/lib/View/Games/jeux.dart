import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/flip_card.dart';
import 'package:mon_vocabulaire/View/Games/ninja_bubble.dart';
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
        children: [
          const GameBloc(
            color: Palette.lightBlue,
            image: "assets/themes_images/bubble.png",
            price: '20',
            text: "Jeu 1",
            game: NinjaBubble(),
          ),
          const GameBloc(
            color: Palette.orange,
            image: "assets/themes_images/drag_and_drop.png",
            price: '120',
            text: "Jeu 2",
            game: NinjaBubble(),
          ),
          GameBloc(
            color: Palette.lightGreen,
            image: "assets/themes_images/images.png",
            price: '50',
            text: "Jeu 3",
            game: FlipCardGame(user: widget.user),
          ),
          const GameBloc(
            color: Palette.pink,
            image: "assets/themes_images/cloud.png",
            price: '80',
            text: "Jeu 4",
            game: NinjaBubble(),
          ),
        ],
      ),
    ));
  }
}
