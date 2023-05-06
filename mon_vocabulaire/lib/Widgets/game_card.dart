import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class CardWidget extends StatefulWidget {
  final String frontImage;
  final String backImage;
  final double height;
  final double width;
  final CardSide cardSide;
  final Duration duration;
  final VoidCallback onFlip;
  final Function(bool)? onFlipDone;
  final FlipCardController controller;
  final bool flipOntouch;
  const CardWidget({
    Key? key,
    required this.frontImage,
    required this.backImage,
    required this.onFlip,
    required this.height,
    required this.width,
    required this.cardSide,
    required this.duration,
    this.flipOntouch = false,
    required this.controller,
    required this.onFlipDone,
  }) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      side: widget.cardSide,
      autoFlipDuration: widget.duration,
      back: Container(
        padding: const EdgeInsets.all(10),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 3,
                spreadRadius: 0.8,
                offset: Offset(2.0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(4.0),
        child: Image.asset("assets/images/${widget.backImage}.png"),
      ),
      front: Container(
        padding: const EdgeInsets.all(20),
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                //Colors.white,
                // Color.fromARGB(255, 174, 221, 237),
                Color.fromARGB(255, 150, 224, 248),
                Color.fromARGB(255, 124, 213, 255),
                Color.fromARGB(255, 52, 184, 245),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(135, 52, 184, 245),
                blurRadius: 3,
                spreadRadius: 0.8,
                offset: Offset(0, 1),
              )
            ],
            borderRadius: BorderRadius.circular(5)),
        margin: const EdgeInsets.all(4.0),
        child: Image.asset("assets/themes_images/${widget.frontImage}.png"),
      ),
      onFlip: widget.onFlip,
      onFlipDone: widget.onFlipDone,
      flipOnTouch: widget.flipOntouch,
      controller: widget.controller,
    );
  }
}
