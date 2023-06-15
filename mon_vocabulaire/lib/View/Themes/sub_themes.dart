// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
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
  List<Progression> progression = [];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  RealtimeDataController controller = RealtimeDataController();
  Future<void> getResult() async {
    await controller.getAllProgression(widget.user.id!);
    List<Progression>? _result = controller.allProgression;
    setState(() {
      progression = _result!;
    });
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
    getResult();
    return Scaffold(
      body: progression.isEmpty
          ? Stack(
              children: [
                SvgPicture.asset(
                    'assets/images/themes/backgrounds/$background.svg',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    color: Palette.white.withOpacity(0.65),
                    colorBlendMode: BlendMode.modulate),
                const Center(
                  child: CircularProgressIndicator(
                    color: Palette.lightBlue,
                  ),
                ),
                CustomAppBar(
                  title: widget.title.toUpperCase(),
                  color: color,
                  automaticallyImplyLeading: true,
                ),
              ],
            )
          : Stack(
              children: [
                SvgPicture.asset(
                    'assets/images/themes/backgrounds/$background.svg',
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
                            ? progression[0].stars
                            : widget.theme == 2
                                ? progression[2].stars
                                : widget.theme == 3
                                    ? progression[4].stars
                                    : widget.theme == 4
                                        ? progression[6].stars
                                        : widget.theme == 5
                                            ? progression[8].stars
                                            : widget.theme == 6
                                                ? progression[10].stars
                                                : 0,
                        stage: widget.theme == 1
                            ? progression[0].mots
                            : widget.theme == 2
                                ? progression[2].mots
                                : widget.theme == 3
                                    ? progression[4].mots
                                    : widget.theme == 4
                                        ? progression[6].mots
                                        : widget.theme == 5
                                            ? progression[8].mots
                                            : widget.theme == 6
                                                ? progression[10].mots
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
                            ? progression[1].stars
                            : widget.theme == 2
                                ? progression[3].stars
                                : widget.theme == 3
                                    ? progression[5].stars
                                    : widget.theme == 4
                                        ? progression[7].stars
                                        : widget.theme == 5
                                            ? progression[9].stars
                                            : widget.theme == 6
                                                ? progression[11].stars
                                                : 0,
                        stage: widget.theme == 1
                            ? progression[1].mots
                            : widget.theme == 2
                                ? progression[3].mots
                                : widget.theme == 3
                                    ? progression[5].mots
                                    : widget.theme == 4
                                        ? progression[7].mots
                                        : widget.theme == 5
                                            ? progression[9].mots
                                            : widget.theme == 6
                                                ? progression[11].mots
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
