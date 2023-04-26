import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Quiz/lesson.dart';
import 'package:mon_vocabulaire/View/Quiz/quiz_text_images.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import '../../Services/sfx.dart';
import '../Quiz/drag_and_drop.dart';
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
  List<String> images = ["", ""];
  String background = "";
  Color color = Palette.blue;
  List<String> titles = ["", ""];
  @override
  void initState() {
    super.initState();
    if (widget.subTheme == 1 || widget.subTheme == 2) {
      setState(() {
        images[1] = "assets/themes_images/personnes.png";
        images[0] = "assets/themes_images/elements.png";
        titles[1] = "Personnes";
        titles[0] = "Éléments";
        background = "school";
        color = Palette.ecole;
      });
    } else if (widget.subTheme == 3 || widget.subTheme == 4) {
      setState(() {
        images[0] = "assets/themes_images/maison.png";
        images[1] = "assets/themes_images/famille.png";
        titles[0] = "Maison";
        titles[1] = "Famille";
        background = "home";
        color = Palette.maison;
      });
    } else if (widget.subTheme == 5 || widget.subTheme == 6) {
      setState(() {
        images[0] = "assets/themes_images/cuisine.png";
        images[1] = "assets/themes_images/aliments.png";
        titles[0] = "Cuisine";
        titles[1] = "Aliments";
        background = "kitchen";
        color = Palette.cuisine;
      });
    } else if (widget.subTheme == 7 || widget.subTheme == 8) {
      setState(() {
        images[0] = "assets/themes_images/mammiferes.png";
        images[1] = "assets/themes_images/oiseaux.png";
        titles[0] = "Mammifères";
        titles[1] = "Oiseaux et autres";
        background = "forest";
        color = Palette.animaux;
      });
    } else if (widget.subTheme == 9 || widget.subTheme == 10) {
      setState(() {
        images[0] = "assets/themes_images/mon_corps.png";
        images[1] = "assets/themes_images/mes_habits.png";
        titles[0] = "Mon corps";
        titles[1] = "Mes habits";
        background = "cloths";
        color = Palette.corps;
      });
    } else if (widget.subTheme == 11 || widget.subTheme == 12) {
      setState(() {
        images[0] = "assets/themes_images/sports.png";
        images[1] = "assets/themes_images/loisirs.png";
        titles[0] = "Sports";
        titles[1] = "Loisirs";
        background = "sports";
        color = Palette.sports;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.play("sfx/pop.mp3", 1);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
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
      body: Stack(
        children: [
          SvgPicture.asset(
            'assets/themes_images/$background.svg',
            alignment: Alignment.center,
            fit: BoxFit.cover,
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
                          Sfx.play("sfx/plip.mp3", 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonPage(
                                subTheme: widget.subTheme,
                                user: widget.user,
                              ),
                            ),
                          );
                        },
                        content: Image.asset(
                          "assets/themes_images/lesson.png",
                          scale: width > 500 ? 4 : 5,
                        ),
                        heigth: width > 500 ? 200 : 150,
                        width: width > 500 ? 200 : 150,
                        radius: 200,
                        color: color),
                  ),
                ),
                Positioned(
                    top: height / 6,
                    right: 0,
                    child: Button(
                        callback: () {
                          Sfx.play("sfx/plip.mp3", 1);
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
                            scale: width > 500 ? 4 : 5,
                          ),
                        ),
                        heigth: width > 500 ? 200 : 150,
                        width: width > 500 ? 200 : 150,
                        radius: 200,
                        color: Palette.white)),
                Positioned(
                  top: height / 3.2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Button(
                        callback: () {
                          Sfx.play("sfx/plip.mp3", 1);
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
                            scale: width > 500 ? 4 : 5,
                          ),
                        ),
                        heigth: width > 500 ? 200 : 150,
                        width: width > 500 ? 200 : 150,
                        radius: 200,
                        color: Palette.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: height / 2,
                  right: 0,
                  child: Button(
                    callback: () {
                      Sfx.play("sfx/plip.mp3", 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DragAndDrop(
                            subTheme: widget.subTheme,
                            user: widget.user,
                          ),
                        ),
                      );
                    },
                    content: Opacity(
                      opacity: 0.8,
                      child: Image.asset(
                        "assets/themes_images/drag_and_drop.png",
                        scale: width > 500 ? 5 : 6,
                      ),
                    ),
                    heigth: width > 500 ? 200 : 150,
                    width: width > 500 ? 200 : 150,
                    radius: 200,
                    color: Palette.white,
                  ),
                ),
                Positioned(
                  left: 20,
                  top: height / 1.6,
                  child: Button(
                    callback: () {
                      Sfx.play("sfx/plip.mp3", 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DragAndDrop(
                            user: widget.user,
                            subTheme: widget.subTheme,
                          ),
                        ),
                      );
                    },
                    content: Opacity(
                      opacity: 0.8,
                      child: Image.asset(
                        "assets/themes_images/lock.png",
                        scale: width > 500 ? 6 : 7,
                      ),
                    ),
                    heigth: width > 500 ? 200 : 150,
                    width: width > 500 ? 200 : 150,
                    radius: 200,
                    color: Palette.white,
                    enabled: false,
                  ),
                ),
              ],
            ),
          ),
        ],
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
