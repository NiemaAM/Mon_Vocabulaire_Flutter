import 'package:flutter/material.dart';

class Level extends StatefulWidget {
  //la largeure du boutton
  final double width;
  //la hauteur du boutton
  final double heigth;
  //si le boutton contien une icon ou un text
  final bool label;
  //le nombre de mots
  final String mot;
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
  //les coins
  final int coins;
  //si le boutton est actif
  final bool enabled;
  const Level(
      {super.key,
      this.width = 200,
      this.heigth = 60,
      required this.label,
      this.mot = " ",
      this.icon = const Icon(Icons.abc),
      this.text = "",
      required this.callback,
      this.color = Colors.blue,
      required this.isImage,
      this.image = "",
      this.radius = 50,
      this.coins = 0,
      this.enabled = true});

  @override
  State<Level> createState() => _LevelState();
}

class _LevelState extends State<Level> {
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
// Trophy Icon if the level is unlocked and lock Icon if the level is Locked
        Align(
          alignment: Alignment.centerLeft,
          child: Image.network(
            widget.image,
            height: MediaQuery.of(context).size.height * 0.1,
          ), //TODO: change this to image.assets
        ),

        Positioned(
          right: 2,
          child: Container(
            height: widget.heigth * 0.4,
            width: widget.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, bottom: 0, right: 12, top: 0),
                          child: Text(
                            "${widget.coins}",
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, bottom: 0, right: 12, top: 0),
                          child: Image.network(
                            'https://cdn-icons-png.flaticon.com/512/1490/1490850.png',
                            scale: 20,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        Positioned(
          right: 2,
          bottom: 2,
          child: Container(
            height: widget.heigth * 0.4,
            width: widget.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mots",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 0, bottom: 0, right: 12, top: 0),
                          child: Text(
                            widget.mot,
                            style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
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
        ),
      ),
    );
  }
}
