import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

import '../Services/sfx.dart';
import 'Palette.dart';

class GameBloc extends StatefulWidget {
  final String text;
  final String price;
  final String image;
  final Color color;
  final Widget callback;
  const GameBloc(
      {super.key,
      required this.text,
      required this.price,
      required this.image,
      required this.color,
      required this.callback});

  @override
  State<GameBloc> createState() => _GameBlocState();
}

class _GameBlocState extends State<GameBloc> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Button(
        callback: () {
          Sfx.play("sfx/plip.mp3", 1);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget.callback,
            ),
          );
        },
        color: widget.color,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Image.asset(
              widget.image,
              scale: width >= 700
                  ? 2
                  : width >= 500
                      ? 4
                      : 6,
            ),
            const Expanded(child: SizedBox()),
            Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(
                    widget.price,
                    style: const TextStyle(color: Palette.yellow),
                  ),
                ),
                Image.asset(
                  "assets/themes_images/coin.png",
                  scale: width >= 700
                      ? 16
                      : width >= 500
                          ? 18
                          : 22,
                ),
              ],
            )),
            const Expanded(child: SizedBox()),
            Center(
                child: Text(
              widget.text,
              style: const TextStyle(
                  color: Palette.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
            const Expanded(child: SizedBox()),
          ],
        ),
        heigth: width / 2.15,
        width: width / 2.15,
        radius: 20,
      ),
    );
  }
}
