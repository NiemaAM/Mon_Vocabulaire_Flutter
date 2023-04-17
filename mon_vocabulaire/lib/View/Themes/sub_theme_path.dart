import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Quiz/lesson.dart';
import 'package:mon_vocabulaire/View/Quiz/quiz_text_images.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../Quiz/drag_and_drop.dart';
import '../Quiz/quiz_articles.dart';
import '../Quiz/quiz_image_texts.dart';

class LessonPath extends StatefulWidget {
  final String title;
  final int subTheme;
  final String image;
  final User user;
  const LessonPath(
      {super.key,
      required this.title,
      required this.subTheme,
      required this.image,
      required this.user});

  @override
  State<LessonPath> createState() => _LessonPathState();
}

class _LessonPathState extends State<LessonPath> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 83, 146, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 83, 146, 255),
        elevation: 2,
        title: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.transparent,
              child: Image.asset(
                widget.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.title,
              ),
            ),
          ],
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
                child: Image.asset(
                  'assets/themes_images/cloud.png',
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              top: 80,
              left: -130,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset(
                  'assets/themes_images/clouds.png',
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: 0,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/themes_images/cloud.png',
                  scale: 3,
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              right: -130,
              child: Opacity(
                opacity: 0.7,
                child: Image.asset(
                  'assets/themes_images/clouds.png',
                  scale: 2,
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -120,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/themes_images/cloud.png',
                  scale: 1.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Button(
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LessonPage(),
                              ),
                            );
                          },
                          content: Image.asset(
                            "assets/themes_images/lesson.png",
                            scale: 5,
                          ),
                          heigth: 150,
                          width: 150,
                          radius: 200,
                          color: Palette.pink),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 120),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Button(
                            callback: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => QuizTextImages(
                                    subTheme: widget.subTheme,
                                    user: widget.user,
                                  ),
                                ),
                              );
                            },
                            content: Opacity(
                              opacity: 0.8,
                              child: Image.asset(
                                "assets/themes_images/song.png",
                                scale: 5,
                              ),
                            ),
                            heigth: 150,
                            width: 150,
                            radius: 200,
                            color: Palette.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 250, left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Button(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizImageTexts(
                                subTheme: widget.subTheme,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                        content: Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            "assets/themes_images/images.png",
                            scale: 5,
                          ),
                        ),
                        heigth: 150,
                        width: 150,
                        radius: 200,
                        color: Palette.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 380),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Button(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DragAndDrop(
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                        content: Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            "assets/themes_images/drag_and_drop.png",
                            scale: 6,
                          ),
                        ),
                        heigth: 150,
                        width: 150,
                        radius: 200,
                        color: Palette.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 500, bottom: 25),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Button(
                        callback: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizArticles(
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                        content: Opacity(
                          opacity: 0.8,
                          child: Image.asset(
                            "assets/themes_images/articles.png",
                            scale: 7,
                          ),
                        ),
                        heigth: 150,
                        width: 150,
                        radius: 200,
                        color: Palette.white,
                      ),
                    ),
                  )
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
