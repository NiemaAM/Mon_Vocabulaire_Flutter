import 'package:flutter/material.dart';

import 'Palette.dart';

class Star extends StatelessWidget {
  final bool isStar;
  const Star({super.key, required this.isStar});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned(
            bottom: width < 500 ? -width / 4 : -130,
            right: width < 500 ? -width / 5 : -130,
            top: 0,
            left: 0,
            child: Icon(
              Icons.star_rounded,
              color: Palette.white,
              size: width < 500 ? width / 7.5 : 65,
            )),
        Positioned(
            bottom: width < 500 ? -width / 4 : -130,
            right: width < 500 ? -width / 5 : -130,
            top: 0,
            left: 0,
            child: Icon(
              Icons.star_rounded,
              color: isStar ? Palette.yellow : Palette.lightGrey,
              size: width < 500 ? width / 9.5 : 50,
            ))
      ],
    );
  }
}
