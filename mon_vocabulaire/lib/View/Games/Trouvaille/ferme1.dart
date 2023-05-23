import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class Ferme1 extends StatefulWidget {
  const Ferme1({super.key});

  @override
  State<Ferme1> createState() => _Ferme1State();
}

class _Ferme1State extends State<Ferme1> {
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/games/backgrounds/ferme.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 150),
            child: IconButton(
                iconSize: 250,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/2.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 300),
            child: IconButton(
                iconSize: 80,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/145.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 355),
            child: IconButton(
                iconSize: 20,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/135.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 300, top: 245),
            child: IconButton(
                iconSize: 100,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/133.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 320, top: 350),
            child: IconButton(
                iconSize: 40,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/156.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 250, top: 500),
            child: IconButton(
                iconSize: 50,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/128.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 220, top: 485),
            child: IconButton(
                iconSize: 50,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/128.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200, top: 500),
            child: IconButton(
                iconSize: 50,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/128.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140, top: 450),
            child: IconButton(
                iconSize: 80,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/127.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140, top: 450),
            child: IconButton(
                iconSize: 80,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/127.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 130, top: 490),
            child: IconButton(
                iconSize: 80,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/121.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 420),
            child: IconButton(
                iconSize: 120,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/126.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140, top: 300),
            child: IconButton(
                iconSize: 120,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/148.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200, top: 350),
            child: IconButton(
                iconSize: 90,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/144.png')),
          ),
          Positioned(
            right: 1,
            top: -60,
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
                    "Un chien",
                    style:
                        const TextStyle(color: Color(0xFF0E57AC), fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
