import 'package:flutter/material.dart';

import 'Palette.dart';

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: const BoxDecoration(
        color: Palette.lightGrey,
        // ignore: unnecessary_const
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
    );
  }
}
