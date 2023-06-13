// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

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
  int wordsSubTheme1 = 0;
  int wordsSubTheme2 = 0;
  int wordsSubTheme3 = 0;
  int wordsSubTheme4 = 0;
  int wordsSubTheme5 = 0;
  int wordsSubTheme6 = 0;
  int wordsSubTheme7 = 0;
  int wordsSubTheme8 = 0;
  int wordsSubTheme9 = 0;
  int wordsSubTheme10 = 0;
  int wordsSubTheme11 = 0;
  int wordsSubTheme12 = 0;
  int starsSubTheme1 = 0;
  int starsSubTheme2 = 0;
  int starsSubTheme3 = 0;
  int starsSubTheme4 = 0;
  int starsSubTheme5 = 0;
  int starsSubTheme6 = 0;
  int starsSubTheme7 = 0;
  int starsSubTheme8 = 0;
  int starsSubTheme9 = 0;
  int starsSubTheme10 = 0;
  int starsSubTheme11 = 0;
  int starsSubTheme12 = 0;

  Future<void> getResult() async {
    DatabaseHelper();
    Progression _result1 =
        await DatabaseHelper().getProgression(widget.user.id!, 1);
    Progression _result2 =
        await DatabaseHelper().getProgression(widget.user.id!, 2);
    Progression _result3 =
        await DatabaseHelper().getProgression(widget.user.id!, 3);
    Progression _result4 =
        await DatabaseHelper().getProgression(widget.user.id!, 4);
    Progression _result5 =
        await DatabaseHelper().getProgression(widget.user.id!, 5);
    Progression _result6 =
        await DatabaseHelper().getProgression(widget.user.id!, 6);
    Progression _result7 =
        await DatabaseHelper().getProgression(widget.user.id!, 7);
    Progression _result8 =
        await DatabaseHelper().getProgression(widget.user.id!, 8);
    Progression _result9 =
        await DatabaseHelper().getProgression(widget.user.id!, 9);
    Progression _result10 =
        await DatabaseHelper().getProgression(widget.user.id!, 10);
    Progression _result11 =
        await DatabaseHelper().getProgression(widget.user.id!, 11);
    Progression _result12 =
        await DatabaseHelper().getProgression(widget.user.id!, 12);
    setState(() {
      wordsSubTheme1 = _result1.mots;
      wordsSubTheme2 = _result2.mots;
      wordsSubTheme3 = _result3.mots;
      wordsSubTheme4 = _result4.mots;
      wordsSubTheme5 = _result5.mots;
      wordsSubTheme6 = _result6.mots;
      wordsSubTheme7 = _result7.mots;
      wordsSubTheme8 = _result8.mots;
      wordsSubTheme9 = _result9.mots;
      wordsSubTheme10 = _result10.mots;
      wordsSubTheme11 = _result11.mots;
      wordsSubTheme12 = _result12.mots;
      starsSubTheme1 = _result1.stars;
      starsSubTheme2 = _result2.stars;
      starsSubTheme3 = _result3.stars;
      starsSubTheme4 = _result4.stars;
      starsSubTheme5 = _result5.stars;
      starsSubTheme6 = _result6.stars;
      starsSubTheme7 = _result7.stars;
      starsSubTheme8 = _result8.stars;
      starsSubTheme9 = _result9.stars;
      starsSubTheme10 = _result10.stars;
      starsSubTheme11 = _result11.stars;
      starsSubTheme12 = _result12.stars;
    });
  }

  @override
  void initState() {
    super.initState();
    getResult();
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
    getResult();
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
                  totalWords: widget.theme == 1
                      ? 35
                      : widget.theme == 2
                          ? 29
                          : widget.theme == 3
                              ? 13
                              : widget.theme == 4
                                  ? 22
                                  : widget.theme == 5
                                      ? 17
                                      : widget.theme == 6
                                          ? 10
                                          : 0,
                  nbStars: widget.theme == 1
                      ? starsSubTheme1
                      : widget.theme == 2
                          ? starsSubTheme3
                          : widget.theme == 3
                              ? starsSubTheme5
                              : widget.theme == 4
                                  ? starsSubTheme7
                                  : widget.theme == 5
                                      ? starsSubTheme9
                                      : widget.theme == 6
                                          ? starsSubTheme11
                                          : 0,
                  stage: widget.theme == 1
                      ? wordsSubTheme1
                      : widget.theme == 2
                          ? wordsSubTheme3
                          : widget.theme == 3
                              ? wordsSubTheme5
                              : widget.theme == 4
                                  ? wordsSubTheme7
                                  : widget.theme == 5
                                      ? wordsSubTheme9
                                      : widget.theme == 6
                                          ? wordsSubTheme11
                                          : 0,
                  text: titles[0],
                  callback: LessonPath(
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
                  totalWords: widget.theme == 1
                      ? 5
                      : widget.theme == 2
                          ? 11
                          : widget.theme == 3
                              ? 27
                              : widget.theme == 4
                                  ? 18
                                  : widget.theme == 5
                                      ? 23
                                      : widget.theme == 6
                                          ? 30
                                          : 0,
                  nbStars: widget.theme == 1
                      ? starsSubTheme2
                      : widget.theme == 2
                          ? starsSubTheme4
                          : widget.theme == 3
                              ? starsSubTheme6
                              : widget.theme == 4
                                  ? starsSubTheme8
                                  : widget.theme == 5
                                      ? starsSubTheme10
                                      : widget.theme == 6
                                          ? starsSubTheme12
                                          : 0,
                  stage: widget.theme == 1
                      ? wordsSubTheme2
                      : widget.theme == 2
                          ? wordsSubTheme4
                          : widget.theme == 3
                              ? wordsSubTheme6
                              : widget.theme == 4
                                  ? wordsSubTheme8
                                  : widget.theme == 5
                                      ? wordsSubTheme10
                                      : widget.theme == 6
                                          ? wordsSubTheme12
                                          : 0,
                  text: titles[1],
                  callback: LessonPath(
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
