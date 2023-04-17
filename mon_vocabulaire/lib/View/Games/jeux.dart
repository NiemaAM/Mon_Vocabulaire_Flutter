import 'package:flutter/material.dart';
import '../../Model/user.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/game_bloc.dart';

import '../../Widgets/Palette.dart';
import '../../Widgets/appbargame.dart';
import '../../Widgets/buttongame.dart';

class Games extends StatefulWidget {
  final User user;
  const Games({super.key, required this.user});

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  int chances = 3;
  void song() async {}
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Games"),
    );
  }
}
