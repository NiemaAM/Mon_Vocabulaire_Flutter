import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../Model/user.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class AppBarHome extends StatefulWidget {
  final User user;
  const AppBarHome({super.key, required this.user});

  @override
  State<AppBarHome> createState() => _AppBarHomeState();
}

class _AppBarHomeState extends State<AppBarHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.transparent,
          child: Image.asset(
            "assets/themes_images/level1.png",
          ),
        ),
        LinearPercentIndicator(
          width: width - 120,
          animation: true,
          lineHeight: 25.0,
          animationDuration: 1000,
          percent:
              widget.user.words_per_level[widget.user.current_level]! / 240,
          barRadius: const Radius.circular(100),
          progressColor: Palette.lightGreen,
          backgroundColor: Theme.of(context).shadowColor,
          center: Text(
            "${widget.user.words_per_level[widget.user.current_level]}/240 mots",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Text(
          widget.user.coins.toString(),
          style: const TextStyle(
              color: Palette.indigo, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Expanded(child: SizedBox()),
        Image.asset(
          'assets/themes_images/coin.png',
          scale: 20,
        ),
      ],
    );
  }
}
