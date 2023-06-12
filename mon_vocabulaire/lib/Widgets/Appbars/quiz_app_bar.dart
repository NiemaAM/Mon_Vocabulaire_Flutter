// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/percent_indicator.dart';

class QuizAppBar extends StatefulWidget {
  final int chances;
  final int duration;
  final int totalDuration;
  final User user;
  final int question;
  final int size;
  const QuizAppBar(
      {super.key,
      required this.chances,
      this.duration = 0,
      required this.user,
      required this.question,
      required this.size,
      required this.totalDuration});

  @override
  State<QuizAppBar> createState() => _QuizAppBarState();
}

class _QuizAppBarState extends State<QuizAppBar> {
  int coins = 0;
  Future<void> getCoins() async {
    DatabaseHelper();
    User _user = await DatabaseHelper().getUser(widget.user.id!);
    setState(() {
      coins = _user.coins;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCoins();
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 25),
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
              padding: const EdgeInsets.only(bottom: 5),
              child: LinearPercentIndicator(
                padding: const EdgeInsets.all(0),
                animation: true,
                lineHeight: 18,
                animationDuration: 0,
                percent: widget.duration / widget.totalDuration,
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
                                  Icons.favorite_rounded,
                                  color: Palette.red,
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Palette.grey,
                                )),
                      Container(
                          margin: const EdgeInsets.only(
                              right: 5), // add right margin of 10 pixels
                          child: widget.chances >= 2
                              ? const Icon(
                                  Icons.favorite_rounded,
                                  color: Palette.red,
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Palette.grey,
                                )),
                      Container(
                          margin: const EdgeInsets.only(
                              right: 5), // add right margin of 10 pixels
                          child: widget.chances == 3
                              ? const Icon(
                                  Icons.favorite_rounded,
                                  color: Palette.red,
                                )
                              : const Icon(
                                  Icons.favorite_rounded,
                                  color: Palette.grey,
                                )),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    children: [
                      Text(
                        coins.toString(),
                        style: const TextStyle(
                            color: Palette.indigo,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/images/themes/coin.png',
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
