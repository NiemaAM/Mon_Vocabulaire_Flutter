import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Quiz/quiz_text_images.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:mon_vocabulaire/View/lesson_path.dart';
import 'package:mon_vocabulaire/View/themes.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

import '../Widgets/Palette.dart';

class EndGame extends StatefulWidget {
  const EndGame({super.key, required this.titre, required this.faute});
  final String titre;
  final bool faute;

  @override
  State<EndGame> createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.blue,
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 150, 15, 100),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        color: Palette.indigo,
                        blurRadius: 5.0,
                        spreadRadius: 2.0,
                        blurStyle: BlurStyle.normal,
                        offset: Offset(4, 8)),
                  ],
                ),
                width: width,
                height: 300,
              ),
            ),
            const Align(
              //middle star
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Palette.pink,
                  size: 160,
                ),
              ),
            ),
            const Align(
              //middle star
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Palette.white,
                  size: 120,
                ),
              ),
            ),
            Align(
              //middle star
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 89),
                child: Icon(
                  Icons.star_rounded,
                  color: widget.faute == true ? Palette.grey : Palette.yellow,
                  size: 85,
                ),
              ),
            ),
            const Align(
              //left star
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(top: 85, left: 22),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Palette.pink,
                  size: 145,
                ),
              ),
            ),
            const Align(
              //left star
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(top: 102, left: 40),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Color.fromARGB(255, 250, 250, 250),
                  size: 110,
                ),
              ),
            ),
            const Align(
              //left star
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.only(top: 120, left: 58),
                child: Icon(
                  Icons.star_rounded,
                  color: Palette.yellow,
                  size: 75,
                ),
              ),
            ),
            const Align(
              //right star
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: EdgeInsets.only(top: 85, right: 22),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Palette.pink,
                  size: 145,
                ),
              ),
            ),
            const Align(
              //right star
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: EdgeInsets.only(top: 102, right: 40),
                child: Icon(
                  Icons.star_border_rounded,
                  color: Color.fromARGB(255, 250, 250, 250),
                  size: 110,
                ),
              ),
            ),
            Align(
              //right star
              alignment: AlignmentDirectional.topEnd,
              child: Padding(
                padding: const EdgeInsets.only(top: 120, right: 58),
                child: Icon(
                  Icons.star_rounded,
                  color: widget.faute == true ? Palette.grey : Palette.yellow,
                  size: 75,
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 230, bottom: 20),
                    child: Text(
                      "${widget.titre}",
                      style: const TextStyle(
                          color: Palette.pink,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Palette.yellow,
                        size: 30,
                      ),
                      Text(
                        " +15 pièces", //TODO: render it dynamic
                        style: TextStyle(
                            color: Palette.indigo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upgrade_outlined,
                        color: Palette.pink,
                        size: 30,
                      ),
                      Text(
                        " +15 mots",
                        style: TextStyle(
                            color: Palette.indigo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Button(
                            callback: () {
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizTextImages(),
                                    ));
                              });
                            },
                            color: Palette.pink,
                            heigth: 70,
                            width: 70,
                            content: const Icon(
                              Icons.replay_rounded,
                              color: Palette.white,
                              size: 45,
                            )),
                        Button(
                            callback: () {
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ));
                              });
                            },
                            color: Palette.pink,
                            heigth: 70,
                            width: 70,
                            content: const Icon(
                              Icons.home,
                              color: Palette.white,
                              size: 45,
                            )),
                        Button(
                            callback: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LessonPath(
                                        title: '',
                                      ),
                                    ));
                              });
                            },
                            color: Palette.pink,
                            heigth: 70,
                            width: 70,
                            content: const Icon(
                              Icons.arrow_forward_ios,
                              color: Palette.white,
                              size: 45,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
