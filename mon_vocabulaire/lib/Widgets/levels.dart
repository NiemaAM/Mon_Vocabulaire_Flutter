import 'package:flutter/material.dart';

import '../Model/user.dart';
import 'level_bloc.dart';

class Levels extends StatefulWidget {
  final User user;
  const Levels({super.key, required this.user});

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LevelBloc(
          text: "Niveau 1 - 1AEP",
          image: "assets/themes_images/level1.png",
          words: widget.user.words_per_level[widget.user.current_level]!,
          locked: false,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 2 - 2AEP",
          image: "assets/themes_images/level2.png",
          words: 0,
          locked: widget.user.current_level >= 2 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 3 - 3AEP",
          image: "assets/themes_images/level3.png",
          words: 0,
          locked: widget.user.current_level >= 3 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 4 - 4AEP",
          image: "assets/themes_images/level4.png",
          words: 0,
          locked: widget.user.current_level >= 4 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 5 - 5AEP",
          image: "assets/themes_images/level5.png",
          words: 0,
          locked: widget.user.current_level >= 5 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 6 - 6AEP",
          image: "assets/themes_images/level6.png",
          words: 0,
          locked: widget.user.current_level >= 6 ? false : true,
          user: widget.user,
        ),
      ],
    );
  }
}
