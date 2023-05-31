import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../Services/animation_route.dart';
import '../Services/sfx.dart';
import 'button.dart';

class BubbleTrouvaille extends StatefulWidget {
  final String image;
  final String text;

  final Color color;
  final VoidCallback callback;
  final bool hasShadow;
  const BubbleTrouvaille(
      {super.key,
      required this.image,
      required this.text,
      required this.color,
      required this.callback,
      this.hasShadow = false});

  @override
  State<BubbleTrouvaille> createState() => _BubbleTrouvailleState();
}

class _BubbleTrouvailleState extends State<BubbleTrouvaille> {
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
          callback: widget.callback,
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
                  child: Padding(
                    padding: const EdgeInsets.all(18),
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
          ),
          heigth: width < 500 ? width / 2.7 : 205,
          width: width < 500 ? width / 2.7 : 205,
          color: Colors.white,
          radius: 1000,
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
            width: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: widget.hasShadow
                        ? Colors.black
                        : Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        )
      ],
    );
  }
}
