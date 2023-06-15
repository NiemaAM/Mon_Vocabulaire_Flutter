import 'package:flutter/material.dart';

import 'Palette.dart';

class Star extends StatelessWidget {
  final int? nbStar;
  final String typebubble;
  const Star({super.key, required this.nbStar, required this.typebubble});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 5),
        child: Container(
          width: width > 500 ? 60 : 50,
          height: width > 500 ? 60 : 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(width > 500 ? 25 : 20),
            ),
            color: Palette.yellow,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.star_rounded,
                  color: const Color.fromARGB(255, 241, 152, 0),
                  size: width < 500 ? 50 : 55,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    "$nbStar",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Palette.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
