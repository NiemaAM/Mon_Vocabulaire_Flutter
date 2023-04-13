import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Palette.dart';

class AppBarHome extends StatefulWidget {
  const AppBarHome({super.key});

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
          percent: 0.7,
          barRadius: const Radius.circular(100),
          progressColor: Palette.lightGreen,
          backgroundColor: Palette.lightGrey,
          center: const Text(
            "150/240 mots",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        const Text(
          "20",
          style: TextStyle(
              color: Palette.indigo, fontSize: 18, fontWeight: FontWeight.bold),
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
