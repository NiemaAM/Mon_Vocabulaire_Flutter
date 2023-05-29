import 'package:flutter/material.dart';

import 'Palette.dart';

class LargeContainer extends StatefulWidget {
  //la largeure du boutton
  final double width;
  //la hauteur du boutton
  final double heigth;
  //le text dans le boutton
  final String name;
  //la methode à appeler quand on click sur le boutton
  final VoidCallback callback;
  //la couleur du button
  final Color color;
  final String level;
  final String image;
  //radius des bordures
  final double radius;

  final bool enabled;
  const LargeContainer({
    super.key,
    this.width = 200,
    this.heigth = 60,
    this.level = "",
    this.name = "",
    required this.callback,
    this.color = Colors.blue,
    this.image = "",
    this.radius = 50,
    this.enabled = true,
  });

  @override
  State<LargeContainer> createState() => _LargeContainerState();
}

class _LargeContainerState extends State<LargeContainer> {
  double _position = 6;
  final double _shadowHeight = 4;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Widget content() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Image.network(
            widget.image,
            height: MediaQuery.of(context).size.height * 0.1,
          ), //TODO: change this to image.assets
        ),
        Positioned(
          right: 1,
          top: 25,
          child: Container(
            height: widget.heigth * 0.35,
            width: widget.width * 0.7,
            decoration: BoxDecoration(
              // ignore: unnecessary_const
              borderRadius: BorderRadius.all(
                Radius.circular(widget.radius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      "20",
                      style: TextStyle(
                          color: Palette.yellow,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/1490/1490850.png',
                      scale: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 1,
          top: 80,
          child: Container(
            height: widget.heigth * 0.35,
            width: widget.width * 0.7,
            decoration: BoxDecoration(
              // ignore: unnecessary_const
              borderRadius: BorderRadius.all(
                Radius.circular(widget.radius),
              ),
            ),
            child: Text(
              widget.level,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
      onTap: () {
        widget.callback;
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: widget.heigth + _shadowHeight + 10,
          width: widget.width,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: widget.heigth,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: darken(widget.color, .2),
                    // ignore: unnecessary_const
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.radius),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.easeIn,
                bottom: _position,
                duration: const Duration(milliseconds: 70),
                child: Container(
                  height: widget.heigth,
                  width: widget.width,
                  decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.radius),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: content(),
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
