import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'sub_theme_path.dart';

class SubThemes extends StatefulWidget {
  final String title;
  final int theme;
  const SubThemes({super.key, required this.title, required this.theme});

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
      images[0] = "assets/themes_images/mammiferes.png";
      images[1] = "assets/themes_images/oiseaux.png";
      titles[0] = "Mammifères";
      titles[1] = "Oiseaux et autres";
    } else if (widget.theme == 2) {
      setState(() {
        images[0] = "assets/themes_images/mon_corps.png";
        images[1] = "assets/themes_images/mes_habits.png";
        titles[0] = "Mon corps";
        titles[1] = "Mes habits";
      });
    } else if (widget.theme == 3) {
      setState(() {
        images[0] = "assets/themes_images/personnes.png";
        images[1] = "assets/themes_images/elements.png";
        titles[0] = "Personnes";
        titles[1] = "Éléments";
      });
    } else if (widget.theme == 4) {
      setState(() {
        images[0] = "assets/themes_images/sports.png";
        images[1] = "assets/themes_images/loisirs.png";
        titles[0] = "Sports";
        titles[1] = "Loisirs";
      });
    } else if (widget.theme == 5) {
      setState(() {
        images[0] = "assets/themes_images/maison.png";
        images[1] = "assets/themes_images/famille.png";
        titles[0] = "Maison";
        titles[1] = "Famille";
      });
    } else if (widget.theme == 6) {
      setState(() {
        images[0] = "assets/themes_images/cuisine.png";
        images[1] = "assets/themes_images/aliments.png";
        titles[0] = "Cuisine";
        titles[1] = "Aliments";
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
              isStart: false,
              stage: 60,
              text: titles[0],
              callback: LessonPath(
                title: titles[0],
              ),
              color: Palette.purple,
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Bubble(
              image: images[1],
              isStart: true,
              stage: 100,
              text: titles[1],
              callback: LessonPath(
                title: titles[1],
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
