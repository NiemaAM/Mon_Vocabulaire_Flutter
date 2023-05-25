import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/message_mascotte.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class cuizine extends StatefulWidget {
  const cuizine({super.key});

  @override
  State<cuizine> createState() => _cuizineState();
}

class _cuizineState extends State<cuizine> {
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
                image: AssetImage('assets/images/games/backgrounds/cuizine.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            right: 1,
            top: -25,
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
          Positioned(
            top: height * 0.08, // Adjust the percentage as needed
            right: width * 0.372,
            child: IconButton(
                iconSize: width * 0.12,
                onPressed: () {},
                icon: new Image.asset('assets/images/pics/7.png')),
          ),
          
        ],
      ),
    );
  }
}
