import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Quiz/quiz_text_images.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/dot.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class LessonPath extends StatefulWidget {
  final String title;
  const LessonPath({super.key, required this.title});

  @override
  State<LessonPath> createState() => _LessonPathState();
}

class _LessonPathState extends State<LessonPath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -160,
              child: Opacity(
                opacity: 0.5,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3222/3222798.png",
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: -130,
              child: Opacity(
                opacity: 0.9,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/892/892300.png",
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: 0,
              child: Opacity(
                opacity: 0.2,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3222/3222798.png",
                  scale: 3,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: -130,
              child: Opacity(
                opacity: 0.7,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/892/892300.png",
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -120,
              child: Opacity(
                opacity: 0.6,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3222/3222798.png",
                  scale: 1.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 170, left: 20),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 190, left: 45),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 210, left: 60),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 370, left: 60),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 390, left: 60),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 410, left: 45),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 430, left: 20),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 610, right: 20),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 630, right: 35),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 650, right: 60),
                    child: Align(alignment: Alignment.center, child: Dot()),
                  ),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Button(
                            callback: () {},
                            content: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/5832/5832416.png",
                              scale: 4,
                            ),
                            heigth: 150,
                            width: 150,
                            radius: 20,
                            color: Palette.blue),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50, top: 220),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Button(
                                callback: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const QuizTextImages(),
                                    ),
                                  );
                                },
                                content: Image.network(
                                  "https://cdn-icons-png.flaticon.com/512/1025/1025648.png",
                                  scale: 4,
                                ),
                                heigth: 150,
                                width: 150,
                                radius: 20,
                                color: Palette.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 440),
                        child: Align(
                          alignment: Alignment.center,
                          child: Button(
                            callback: () {},
                            content: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/2659/2659360.png",
                              scale: 4,
                            ),
                            heigth: 150,
                            width: 150,
                            radius: 20,
                            color: Palette.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 660),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Button(
                            callback: () {},
                            content: Image.network(
                              "https://cdn-icons-png.flaticon.com/512/1916/1916058.png",
                              scale: 4,
                            ),
                            heigth: 150,
                            width: 150,
                            radius: 20,
                            color: Palette.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Button(
        callback: () {},
        content: const Icon(
          Icons.play_arrow,
          color: Palette.white,
          size: 40,
        ),
        width: 70,
        heigth: 70,
        color: Colors.pink,
      ),
    );
  }
}
