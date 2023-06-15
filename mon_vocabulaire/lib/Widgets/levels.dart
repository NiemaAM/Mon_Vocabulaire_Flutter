import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'level_bloc.dart';

class Levels extends StatefulWidget {
  final User user;
  const Levels({super.key, required this.user});

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  int result = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int calculateResult() {
    DatabaseHelper();
    DatabaseHelper().getAllWords(widget.user.id);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LevelBloc(
          text: "Niveau 1 - 1AEP",
          image: "assets/images/levels/level1.png",
          words: calculateResult(),
          locked: false,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 2 - 2AEP",
          image: "assets/images/levels/level2.png",
          words: 0,
          locked: widget.user.currentLevel >= 2 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 3 - 3AEP",
          image: "assets/images/levels/level3.png",
          words: 0,
          locked: widget.user.currentLevel >= 3 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 4 - 4AEP",
          image: "assets/images/levels/level4.png",
          words: 0,
          locked: widget.user.currentLevel >= 4 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 5 - 5AEP",
          image: "assets/images/levels/level5.png",
          words: 0,
          locked: widget.user.currentLevel >= 5 ? false : true,
          user: widget.user,
        ),
        LevelBloc(
          text: "Niveau 6 - 6AEP",
          image: "assets/images/levels/level6.png",
          words: 0,
          locked: widget.user.currentLevel >= 6 ? false : true,
          user: widget.user,
        ),
      ],
    );
  }
}
