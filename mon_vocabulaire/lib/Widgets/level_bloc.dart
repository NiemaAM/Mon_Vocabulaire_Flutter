import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Palette.dart';
import 'button.dart';

class LevelBloc extends StatefulWidget {
  final String image;
  final String text;
  final int words;
  final bool locked;
  const LevelBloc(
      {super.key,
      required this.image,
      required this.text,
      required this.words,
      required this.locked});

  @override
  State<LevelBloc> createState() => _LevelBlocState();
}

class _LevelBlocState extends State<LevelBloc> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Button(
            width: width - 20,
            heigth: width / 4,
            radius: 10,
            enabled: !widget.locked,
            color: widget.locked ? Palette.white : Palette.pink,
            callback: () {},
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  widget.locked
                      ? Opacity(
                          opacity: 0.5,
                          child: Image.asset("assets/themes_images/lock.png"),
                        )
                      : Image.asset(widget.image),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(child: SizedBox()),
                        Text(
                          widget.text,
                          style: TextStyle(
                              color: widget.locked
                                  ? const Color.fromARGB(143, 0, 0, 0)
                                  : Palette.white,
                              fontSize: 20),
                        ),
                        const Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                        LinearPercentIndicator(
                          width: width / 1.5,
                          animation: true,
                          lineHeight: width / 15,
                          animationDuration: 1000,
                          percent: widget.words.toDouble() / 240,
                          barRadius: const Radius.circular(100),
                          progressColor: Palette.lightGreen,
                          backgroundColor: widget.locked
                              ? const Color.fromARGB(68, 232, 232, 232)
                              : Palette.lightGrey,
                          center: Text(
                            "${widget.words}/240 mots",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: widget.locked
                                  ? const Color.fromARGB(255, 173, 173, 173)
                                  : Palette.white,
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
