import 'package:flutter/material.dart';

import 'level_bloc.dart';

class Levels extends StatefulWidget {
  final int level;
  const Levels({super.key, required this.level});

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LevelBloc(
          text: "Niveau 1 - CE1",
          image: "assets/themes_images/level1.png",
          words: 150,
          locked: false,
        ),
        LevelBloc(
          text: "Niveau 2 - CE2",
          image: "assets/themes_images/level2.png",
          words: 0,
          locked: widget.level >= 2 ? false : true,
        ),
        LevelBloc(
          text: "Niveau 3 - CE3",
          image: "assets/themes_images/level3.png",
          words: 0,
          locked: widget.level >= 3 ? false : true,
        ),
        LevelBloc(
          text: "Niveau 4 - CE4",
          image: "assets/themes_images/level4.png",
          words: 0,
          locked: widget.level >= 4 ? false : true,
        ),
        LevelBloc(
          text: "Niveau 5 - CE5",
          image: "assets/themes_images/level5.png",
          words: 0,
          locked: widget.level >= 5 ? false : true,
        ),
        LevelBloc(
          text: "Niveau 6 - CE6",
          image: "assets/themes_images/level6.png",
          words: 0,
          locked: widget.level >= 6 ? false : true,
        ),
      ],
    );
  }
}
