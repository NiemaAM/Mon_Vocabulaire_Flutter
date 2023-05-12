import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final double width;
  final double heigth;
  final Color color;
  final double radius;
  final IconData iconname;
  const RoundedButton(
      {Key? key,
      required this.width,
      required this.heigth,
      required this.color,
      required this.radius,
      required this.iconname})
      : super(key: key);
  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    double _position = 6;
    final double _shadowHeight = 4;
    return Center(
        child: GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: heigth + _shadowHeight + 10,
          width: width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: heigth,
                  width: width,
                  decoration: BoxDecoration(
                    color: darken(color, .2),
                    // ignore: unnecessary_const
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: const Duration(milliseconds: 70),
                child: Container(
                  height: heigth,
                  width: width,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(radius),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      iconname,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
