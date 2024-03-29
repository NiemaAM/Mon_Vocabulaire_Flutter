import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/star.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Services/animation_route.dart';
import 'button.dart';

class Bubble extends StatefulWidget {
  final String image;
  final String text;
  final int stage;
  final int? nbStars;
  final Color color;
  final Widget callback;
  final String type;
  final bool hasShadow;
  final int totalWords;
  const Bubble(
      {super.key,
      required this.image,
      required this.stage,
      required this.nbStars,
      required this.text,
      required this.callback,
      required this.color,
      required this.type,
      this.hasShadow = false,
      this.totalWords = 40});

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  double size = 0.0;
  void setsize(double width) {
    setState(() {
      size = width / 6.3;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    setsize(width);
    return Column(
      children: [
        SizedBox(
          height: width > 500 ? 230 : 155,
          width: width < 500 ? width / 2.2 : 220,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Button(
                  callback: () {
                    Sfx.play("audios/sfx/plip.mp3", 1);
                    Navigator.of(context)
                        .push(SizedSlide(page: widget.callback));
                  },
                  content: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: CircularPercentIndicator(
                          animation: true,
                          radius: width < 500 ? size : 90,
                          lineWidth: 10,
                          percent: widget.stage / widget.totalWords,
                          progressColor: widget.color,
                          backgroundColor: Palette.lightGrey,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            decoration: const BoxDecoration(
                              // ignore: unnecessary_const
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(width > 500 ? 15 : 5),
                              child: Image.asset(
                                widget.image,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  heigth: width < 500 ? width / 2.7 : 205,
                  width: width < 500 ? width / 2.7 : 205,
                  color: Colors.white,
                  radius: 1000,
                ),
              ),
              Star(
                nbStar: widget.nbStars,
                typebubble: widget.type,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(19)),
              boxShadow: [
                BoxShadow(
                  color: widget.hasShadow ? Colors.white : Colors.transparent,
                  blurRadius: 25.0,
                  spreadRadius: 5.0,
                )
              ],
            ),
            width: width > 500 ? 150 : 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width > 500 ? 18 : 14,
                    color: widget.hasShadow
                        ? Colors.black
                        : Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
