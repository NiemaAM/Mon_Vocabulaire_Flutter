import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import '../../Model/user.dart';
import 'sub_theme_path.dart';

class SubThemes extends StatefulWidget {
  final String title;
  final int theme;
  final User user;
  const SubThemes(
      {super.key,
      required this.title,
      required this.theme,
      required this.user});

  @override
  State<SubThemes> createState() => _SubThemesState();
}

class _SubThemesState extends State<SubThemes> {
  List<String> images = ["", ""];
  List<String> titles = ["", ""];
  @override
  void initState() {
    super.initState();
    if (widget.theme == 1) {
      setState(() {
        images[1] = "assets/themes_images/personnes.png";
        images[0] = "assets/themes_images/elements.png";
        titles[1] = "Personnes";
        titles[0] = "Éléments";
      });
    } else if (widget.theme == 2) {
      setState(() {
        images[0] = "assets/themes_images/maison.png";
        images[1] = "assets/themes_images/famille.png";
        titles[0] = "Maison";
        titles[1] = "Famille";
      });
    } else if (widget.theme == 3) {
      setState(() {
        images[0] = "assets/themes_images/cuisine.png";
        images[1] = "assets/themes_images/aliments.png";
        titles[0] = "Cuisine";
        titles[1] = "Aliments";
      });
    } else if (widget.theme == 4) {
      setState(() {
        images[0] = "assets/themes_images/mammiferes.png";
        images[1] = "assets/themes_images/oiseaux.png";
        titles[0] = "Mammifères";
        titles[1] = "Oiseaux et autres";
      });
    } else if (widget.theme == 5) {
      setState(() {
        images[0] = "assets/themes_images/mon_corps.png";
        images[1] = "assets/themes_images/mes_habits.png";
        titles[0] = "Mon corps";
        titles[1] = "Mes habits";
      });
    } else if (widget.theme == 6) {
      setState(() {
        images[0] = "assets/themes_images/sports.png";
        images[1] = "assets/themes_images/loisirs.png";
        titles[0] = "Sports";
        titles[1] = "Loisirs";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
            Bubble(
              image: images[0],
              isStart: widget.theme == 1
                  ? widget.user.stars_per_subtheme[1]!
                  : widget.theme == 2
                      ? widget.user.stars_per_subtheme[3]!
                      : widget.theme == 3
                          ? widget.user.stars_per_subtheme[5]!
                          : widget.theme == 4
                              ? widget.user.stars_per_subtheme[7]!
                              : widget.theme == 5
                                  ? widget.user.stars_per_subtheme[9]!
                                  : widget.theme == 6
                                      ? widget.user.stars_per_subtheme[11]!
                                      : false,
              stage: widget.theme == 1
                  ? widget.user.words_per_subtheme[1]!
                  : widget.theme == 2
                      ? widget.user.words_per_subtheme[3]!
                      : widget.theme == 3
                          ? widget.user.words_per_subtheme[5]!
                          : widget.theme == 4
                              ? widget.user.words_per_subtheme[7]!
                              : widget.theme == 5
                                  ? widget.user.words_per_subtheme[9]!
                                  : widget.theme == 6
                                      ? widget.user.words_per_subtheme[11]!
                                      : 0,
              text: titles[0],
              callback: LessonPath(
                title: titles[0],
                subTheme: widget.theme == 1
                    ? 1
                    : widget.theme == 2
                        ? 3
                        : widget.theme == 3
                            ? 5
                            : widget.theme == 4
                                ? 7
                                : widget.theme == 5
                                    ? 9
                                    : widget.theme == 6
                                        ? 11
                                        : 0,
                image: images[0],
                user: widget.user,
              ),
              color: Palette.purple,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Bubble(
              image: images[1],
              isStart: widget.theme == 1
                  ? widget.user.stars_per_subtheme[1]!
                  : widget.theme == 2
                      ? widget.user.stars_per_subtheme[3]!
                      : widget.theme == 3
                          ? widget.user.stars_per_subtheme[5]!
                          : widget.theme == 4
                              ? widget.user.stars_per_subtheme[7]!
                              : widget.theme == 5
                                  ? widget.user.stars_per_subtheme[9]!
                                  : widget.theme == 6
                                      ? widget.user.stars_per_subtheme[11]!
                                      : false,
              stage: widget.theme == 1
                  ? widget.user.words_per_subtheme[2]!
                  : widget.theme == 2
                      ? widget.user.words_per_subtheme[4]!
                      : widget.theme == 3
                          ? widget.user.words_per_subtheme[6]!
                          : widget.theme == 4
                              ? widget.user.words_per_subtheme[8]!
                              : widget.theme == 5
                                  ? widget.user.words_per_subtheme[10]!
                                  : widget.theme == 6
                                      ? widget.user.words_per_subtheme[12]!
                                      : 0,
              text: titles[1],
              callback: LessonPath(
                title: titles[1],
                subTheme: widget.theme == 1
                    ? 2
                    : widget.theme == 2
                        ? 4
                        : widget.theme == 3
                            ? 6
                            : widget.theme == 4
                                ? 8
                                : widget.theme == 5
                                    ? 10
                                    : widget.theme == 6
                                        ? 12
                                        : 0,
                image: images[1],
                user: widget.user,
              ),
              color: Palette.orange,
            ),
            const Expanded(
              flex: 3,
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
