import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizAppBar extends StatefulWidget {
  final int chances;
  final int duration;
  final User user;
  final int question;
  final int size;
  const QuizAppBar(
      {super.key,
      required this.chances,
      this.duration = 0,
      required this.user,
      required this.question,
      required this.size});

  @override
  State<QuizAppBar> createState() => _QuizAppBarState();
}

class _QuizAppBarState extends State<QuizAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "${widget.question} sur ${widget.size} questions",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface, fontSize: 16),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                animation: true,
                lineHeight: 14.0,
                animationDuration: 0,
                percent: widget.duration / 30,
                barRadius: const Radius.circular(100),
                progressColor: widget.duration >= 20
                    ? Palette.lightGreen
                    : widget.duration <= 10
                        ? Palette.red
                        : Palette.orange,
                backgroundColor: Theme.of(context).shadowColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                              right: 5), // add right margin of 10 pixels
                          child: widget.chances >= 1
                              ? const Icon(
                                  Icons.favorite,
                                  color: Palette.red,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Palette.grey,
                                )),
                      Container(
                          margin: const EdgeInsets.only(
                              right: 5), // add right margin of 10 pixels
                          child: widget.chances >= 2
                              ? const Icon(
                                  Icons.favorite,
                                  color: Palette.red,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Palette.grey,
                                )),
                      Container(
                          margin: const EdgeInsets.only(
                              right: 5), // add right margin of 10 pixels
                          child: widget.chances == 3
                              ? const Icon(
                                  Icons.favorite,
                                  color: Palette.red,
                                )
                              : const Icon(
                                  Icons.favorite,
                                  color: Palette.grey,
                                )),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Text(
                        widget.user.coins.toString(),
                        style: const TextStyle(
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
