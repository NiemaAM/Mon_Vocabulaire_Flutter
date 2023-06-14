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
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width > 500 ? 100 : 80,
        height: width > 500 ? 50 : 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          color: Palette.yellow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(child: SizedBox()),
            Icon(
              Icons.star_rounded,
              color: const Color.fromARGB(255, 241, 152, 0),
              size: width < 500 ? 30 : 45,
            ),
            Text(
              " $nbStar",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 241, 152, 0)),
            ),
            const Expanded(flex: 2, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
