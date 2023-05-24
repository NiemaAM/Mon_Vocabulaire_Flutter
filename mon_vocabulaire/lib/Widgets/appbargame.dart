import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class QuizAppBar1 extends StatefulWidget {
  const QuizAppBar1({super.key});

  @override
  State<QuizAppBar1> createState() => _QuizAppBarState();
}

class _QuizAppBarState extends State<QuizAppBar1> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      const Text(
                        "20",
                        style: TextStyle(
                            color: Palette.indigo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/themes_images/coin.png',
                        scale: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
