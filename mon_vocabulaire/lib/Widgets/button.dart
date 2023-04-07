import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  //la largeure du boutton
  final double width;
  //la hauteur du boutton
  final double heigth;
  //si le boutton contien une icon ou un text
  final bool label;
  //l'icon dans le boutton
  final Icon icon;
  //le text dans le boutton
  final String text;
  //la methode à appeler quand on click sur le boutton
  final VoidCallback callback;
  //la couleur du button
  final Color color;
  //cas d'une image
  final bool isImage;
  //l'image dans le boutton
  final String image;
  //radius des bordures
  final double radius;
  //si le boutton est actif
  final bool enabled;
  const Button(
      {super.key,
      this.width = 200,
      this.heigth = 60,
      required this.label,
      this.icon = const Icon(Icons.abc),
      this.text = "",
      required this.callback,
      this.color = Colors.blue,
      required this.isImage,
      this.image = "",
      this.radius = 50,
      this.enabled = true});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  double _position = 6;
  final double _shadowHeight = 4;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Widget content() {
    if (widget.label && !widget.isImage) {
      return Center(
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      );
    } else if (!widget.label && widget.isImage) {
      return Center(
        child: Image.network(widget.image), //TODO: change this to image.assets
      );
    } else if (!widget.label && !widget.isImage) {
      return Center(
        child: widget.icon,
      );
    } else {
      return const Center();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? widget.callback : () {},
      onTapUp: (_) {
        if (widget.enabled) {
          setState(() {
            _position = 6;
          });
        }
      },
      onTapDown: (_) {
        if (widget.enabled) {
          setState(() {
            _position = 0;
          });
        }
      },
      onTapCancel: () {
        if (widget.enabled) {
          setState(() {
            _position = 6;
          });
        }
      },
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
                  padding: const EdgeInsets.all(8.0),
                  child: content(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
