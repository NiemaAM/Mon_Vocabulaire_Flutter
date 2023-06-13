// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import '../../Services/sfx.dart';
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
  String background = "";
  Color color = Palette.blue;
  Color color2 = Palette.blue;
  List<String> titles = ["", ""];

  int result = 0;
  int words = 0;

  Future<void> calculateResult(themeId) async {
    DatabaseHelper();
    Progression _result =
        await DatabaseHelper().getProgression(widget.user.id!, themeId);
    setState(() {
      result = _result.stars;
      words = _result.mots;
    });
  }

  int getResult(subThemeId) {
    calculateResult(subThemeId);
    return result;
  }

  int getWords(subThemeId) {
    calculateResult(subThemeId);
    return words;
  }

  @override
  void initState() {
    super.initState();
    if (widget.theme == 1) {
      setState(() {
        images[1] = "assets/images/themes/personnes.png";
        images[0] = "assets/images/themes/elements.png";
        titles[1] = "Personnes";
        titles[0] = "Éléments";
        background = "school";
        color = Palette.ecole;
        color2 = Palette.ecole2;
      });
    } else if (widget.theme == 2) {
      setState(() {
        images[0] = "assets/images/themes/maison.png";
        images[1] = "assets/images/themes/famille.png";
        titles[0] = "Maison";
        titles[1] = "Famille";
        background = "home";
        color = Palette.maison;
        color2 = Palette.maison2;
      });
    } else if (widget.theme == 3) {
      setState(() {
        images[0] = "assets/images/themes/cuisine.png";
        images[1] = "assets/images/themes/aliments.png";
        titles[0] = "Cuisine";
        titles[1] = "Aliments";
        background = "kitchen";
        color = Palette.cuisine;
        color2 = Palette.cuisine2;
      });
    } else if (widget.theme == 4) {
      setState(() {
        images[0] = "assets/images/themes/ferme.png";
        images[1] = "assets/images/themes/foret.png";
        titles[0] = "Ferme";
        titles[1] = "Forêt";
        background = "forest";
        color = Palette.animaux;
        color2 = Palette.animaux2;
      });
    } else if (widget.theme == 5) {
      setState(() {
        images[0] = "assets/images/themes/mon_corps.png";
        images[1] = "assets/images/themes/mes_habits.png";
        titles[0] = "Mon corps";
        titles[1] = "Mes habits";
        background = "cloths";
        color = Palette.corps;
        color2 = Palette.corps2;
      });
    } else if (widget.theme == 6) {
      setState(() {
        images[0] = "assets/images/themes/sports.png";
        images[1] = "assets/images/themes/loisirs.png";
        titles[0] = "Sports";
        titles[1] = "Loisirs";
        background = "sports";
        color = Palette.sports;
        color2 = Palette.sports2;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.play("audios/sfx/pop.mp3", 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset('assets/images/themes/backgrounds/$background.svg',
              alignment: Alignment.center,
              fit: BoxFit.cover,
              color: Palette.white.withOpacity(0.65),
              colorBlendMode: BlendMode.modulate),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
                Bubble(
                  hasShadow: true,
                  image: images[0],
                  nbStars: widget.theme == 1
                      ? getResult(1)
                      : widget.theme == 2
                          ? getResult(3)
                          : widget.theme == 3
                              ? getResult(5)
                              : widget.theme == 4
                                  ? getResult(7)
                                  : widget.theme == 5
                                      ? getResult(9)
                                      : widget.theme == 6
                                          ? getResult(11)
                                          : 0,
                  stage: widget.theme == 1
                      ? getWords(1)
                      : widget.theme == 2
                          ? getWords(3)
                          : widget.theme == 3
                              ? getWords(5)
                              : widget.theme == 4
                                  ? getWords(7)
                                  : widget.theme == 5
                                      ? getWords(9)
                                      : widget.theme == 6
                                          ? getWords(11)
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
                  color: color,
                  type: "subtheme",
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Bubble(
                  hasShadow: true,
                  image: images[1],
                  nbStars: widget.theme == 1
                      ? getResult(2)
                      : widget.theme == 2
                          ? getResult(4)
                          : widget.theme == 3
                              ? getResult(6)
                              : widget.theme == 4
                                  ? getResult(8)
                                  : widget.theme == 5
                                      ? getResult(10)
                                      : widget.theme == 6
                                          ? getResult(12)
                                          : 0,
                  stage: widget.theme == 1
                      ? getWords(2)
                      : widget.theme == 2
                          ? getWords(4)
                          : widget.theme == 3
                              ? getWords(6)
                              : widget.theme == 4
                                  ? getWords(8)
                                  : widget.theme == 5
                                      ? getWords(10)
                                      : widget.theme == 6
                                          ? getWords(12)
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
                  color: color2,
                  type: "subtheme",
                ),
                const Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          CustomAppBar(
            title: widget.title.toUpperCase(),
            color: color,
            automaticallyImplyLeading: true,
          ),
        ],
      ),
    );
  }
}
