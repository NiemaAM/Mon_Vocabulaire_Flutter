import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../Widgets/Palette.dart';
import '../../../Widgets/message_mascotte.dart';

class TrouvailleBureau extends StatefulWidget {
  const TrouvailleBureau({super.key});

  @override
  State<TrouvailleBureau> createState() => _TrouvailleBureauState();
}

class _TrouvailleBureauState extends State<TrouvailleBureau> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/search.png",
              width: 40,
            ),
            const Text(
              "  Trouvaille",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //Mot à trouver mascotte
          Positioned(
            right: 1,
            top: -55,
            child: BubbleMessage(
              widget: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 20, bottom: 8),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.volume_up,
                        color: Color(0xFF0E57AC),
                        size: 35,
                      ),
                    ),
                  ),
                  Text(
                    "Une colle",
                    style: const TextStyle(
                        color: Color(0xFF0E57AC),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Stack(children: [
            Container(
              height: height * 0.6,
              width: width * 0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/games/backgrounds/class.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            //Cartable
            Positioned(
              bottom: height * 0.001,
              left: width * 0.35,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 82,
                      onPressed: () {
                        print("Cartable");
                      },
                      icon: new Image.asset('assets/images/pics/20.png')),
                ],
              ),
            ),
            //Brosse
            Positioned(
              bottom: height * 0.14,
              left: width * 0.32,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 50,
                      onPressed: () {
                        print("Brosse");
                      },
                      icon: new Image.asset('assets/images/pics/18.png')),
                ],
              ),
            ),
            //Livre
            Positioned(
              bottom: height * 0.14,
              left: width * 0.32,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 50,
                      onPressed: () {
                        print("Livre");
                      },
                      icon: new Image.asset('assets/images/pics/27.png')),
                ],
              ),
            ),
            //Trousse
            Positioned(
              bottom: height * 0.15,
              right: width * 0.55,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 40,
                      onPressed: () {
                        print("Colle");
                      },
                      icon: new Image.asset('assets/images/pics/23.png')),
                ],
              ),
            ),
            //Règle
            Positioned(
              bottom: height * 0.14,
              right: width * 0.35,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 40,
                      onPressed: () {
                        print("Règle");
                      },
                      icon: new Image.asset('assets/images/pics/30.png')),
                ],
              ),
            ),
            //colle
            Positioned(
              bottom: height * 0.16,
              right: width * 0.38,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 50,
                      onPressed: () {
                        print("Trousse");
                      },
                      icon: new Image.asset('assets/images/pics/32.png')),
                ],
              ),
            ),
            //Gomme
            Positioned(
              bottom: height * 0.16,
              right: width * 0.02,
              child: Row(
                children: [
                  IconButton(
                      iconSize: 25,
                      onPressed: () {
                        print("Gomme");
                      },
                      icon: new Image.asset('assets/images/pics/25.png')),
                ],
              ),
            ),
          ]),

          //élements à trouver
        ],
      ),
    );
  }
}
