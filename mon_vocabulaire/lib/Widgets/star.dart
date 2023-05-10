import 'package:flutter/material.dart';

import 'Palette.dart';

class Star extends StatelessWidget {
  final int? nbStar;
  final String typebubble;
  const Star({super.key, required this.nbStar, required this.typebubble});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (typebubble == "subtheme") {
      return Stack(
        children: [
          Positioned(
              bottom: width > 500 ? -150 : -80,
              left: width > 500 ? -50 : -35,
              top: 0,
              right: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              left: width > 500 ? -50 : -35,
              top: 0,
              right: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar! >= 1 ? Palette.yellow : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              right: width > 500 ? -50 : -35,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              right: width > 500 ? -50 : -35,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar! >= 2 ? Palette.yellow : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              )),
        ],
      );
    } else {
      return Stack(
        children: [
          Positioned(
              bottom: width > 500 ? -100 : -40,
              left: width > 500 ? -150 : -85,
              top: 0,
              right: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
          Positioned(
              bottom: width > 500 ? -100 : -40,
              left: width > 500 ? -150 : -85,
              top: 0,
              right: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar! >= 1 ? Palette.yellow : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              left: width > 500 ? -50 : -35,
              top: 0,
              right: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              left: width > 500 ? -50 : -35,
              top: 0,
              right: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar! >= 2 ? Palette.yellow : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              right: width > 500 ? -50 : -35,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
          Positioned(
              bottom: width > 500 ? -150 : -80,
              right: width > 500 ? -50 : -35,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar! >= 3 ? Palette.yellow : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              )),
          Positioned(
              bottom: width > 500 ? -100 : -40,
              right: width > 500 ? -150 : -85,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: Palette.white,
                size: width < 500 ? width / 7.5 : 65,
              )),
          Positioned(
              bottom: width > 500 ? -100 : -40,
              right: width > 500 ? -150 : -85,
              top: 0,
              left: 0,
              child: Icon(
                Icons.star_rounded,
                color: nbStar! >= 4 ? Palette.yellow : Palette.lightGrey,
                size: width < 500 ? width / 9.5 : 50,
              )),
        ],
      );
    }
  }
}
