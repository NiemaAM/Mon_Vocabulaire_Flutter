import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'button.dart';

class Bubble extends StatefulWidget {
  final String image;
  final String text;
  final int stage;
  final bool isStart;
  final Color color;
  final Widget callback;
  const Bubble(
      {super.key,
      required this.image,
      required this.stage,
      required this.isStart,
      required this.text,
      required this.callback,
      required this.color});

  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                Align(
                  alignment: Alignment.center,
                  child: CircularPercentIndicator(
                    animation: true,
                    radius: width >= 500 ? 90 : 68,
                    lineWidth: 10,
                    percent: widget.stage / 100,
                    progressColor: widget.color,
                    backgroundColor: Palette.lightGrey,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
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
                        scale: width >= 500 ? 4 : 6,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                    bottom: -10,
                    right: 0,
                    child: Icon(
                      Icons.star_border_rounded,
                      color: Palette.white,
                      size: 60,
                    )),
                Positioned(
                    bottom: 0,
                    right: 10,
                    child: Icon(
                      Icons.star_rounded,
                      color:
                          widget.isStart ? Palette.yellow : Palette.lightGrey,
                      size: 40,
                    ))
              ],
            ),
          ),
          heigth: width >= 500 ? 200 : 155,
          width: width >= 500 ? 200 : 155,
          color: Colors.white,
          radius: 100,
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
