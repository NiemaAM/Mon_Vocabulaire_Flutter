import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/star.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'button.dart';

class Bubble extends StatefulWidget {
  final String image;
  final String text;
  final int stage;
  final int? nbStars;
  final Color color;
  final Widget callback;
  final String type;
  const Bubble(
      {super.key,
      required this.image,
      required this.stage,
      required this.nbStars,
      required this.text,
      required this.callback,
      required this.color,
      required this.type
      });

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
        Button(
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => widget.callback,
              ),
            );
          },
          content: SizedBox(
            height: 140,
            width: 150,
            child: Stack(
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
                    percent: widget.stage / 100,
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
                    padding: const EdgeInsets.all(18),
                    child: Container(
                      decoration: const BoxDecoration(
                        // ignore: unnecessary_const
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: Image.asset(
                        widget.image,
                        scale: width < 500 ? 6 : 3,
                      ),
                    ),
                  ),
                ),
                Star(nbStar: widget.nbStars,typebubble: widget.type,)
              ],
            ),
          ),
          heigth: width < 500 ? width / 2.7 : 205,
          width: width < 500 ? width / 2.7 : 205,
          color: Colors.white,
          radius: 1000,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ),
        )
      ],
    );
  }
}
