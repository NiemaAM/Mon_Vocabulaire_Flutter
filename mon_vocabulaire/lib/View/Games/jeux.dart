import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/TicTacToe/choose_xo.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/TrouvailleThemes.dart';
import 'package:mon_vocabulaire/View/Games/flip_card.dart';
import 'package:mon_vocabulaire/View/Games/puzzle.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';
import '../../Model/user.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/game_bloc.dart';

class Games extends StatefulWidget {
  final User user;
  const Games({super.key, required this.user});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Palette.lightBlue,
        appBar: CustomAppBarGames(
          user: widget.user,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: GridView.count(
            primary: false,
            shrinkWrap: true,
            crossAxisCount: width > 500 ? 3 : 2,
            childAspectRatio: width > 500 ? 1.03 : 0.92,
            children: [
              GameBloc(
                image: "assets/images/games/JuMots.png",
                price: '50',
                page: FlipCardGame(
                  user: widget.user,
                ),
              ),
              GameBloc(
                image: "assets/images/games/tic-tac-toe.png",
                price: '20',
                page: ChooseXO(
                  user: widget.user,
                ),
              ),
              const GameBloc(
                image: "assets/images/games/puzzle.png",
                price: '80',
                page: Puzzle(),
              ),
              GameBloc(
                  image: "assets/images/games/search.png",
                  price: '100',
                  page: TrouvailleThemes(user: widget.user)),
              GameBloc(
                image: "assets/images/games/bubbles.png",
                price: '50',
                page: FlipCardGame(
                  user: widget.user,
                ),
                enabled: false,
              ),
              GameBloc(
                image: "assets/images/games/apple.png",
                price: '80',
                page: FlipCardGame(
                  user: widget.user,
                ),
                enabled: false,
              ),
            ],
          ),
        ));
  }
}
