import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';

import '../../Controllers/UserController.dart';
import '../../DataBase/db.dart';
import '../../Model/user.dart';

class Themes extends StatefulWidget {
  final User user;
  const Themes({super.key, required this.user});

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  int result = 0;

  int calculateResult(theme_id) {
    DatabaseHelper();
    //DatabaseHelper().insertData_subtheme_quiz();
    DatabaseHelper()
        .getStarsPerTheme(widget.user.id, theme_id);
    return result; 
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: width > 500 ? 1 : 0.89,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        Bubble(
          image: "assets/images/themes/ecole.png",
          nbStars: calculateResult(6) + calculateResult(7),
          stage: calculateResult(6) + calculateResult(7),
          text: 'L’école',
          callback: SubThemes(
            title: 'L’école',
            theme: 1,
            user: widget.user,
          ),
          color: Palette.ecole,
          type: "theme",
        ),
        Bubble(
          image: "assets/images/themes/maison.png",
          nbStars: calculateResult(8) + calculateResult(9),
          stage:calculateResult(8) + calculateResult(9),
          text: 'Maison et famille',
          callback: SubThemes(
            title: 'Maison et famille',
            theme: 2,
            user: widget.user,
          ),
          color: Palette.maison,
          type: "theme",
        ),
        Bubble(
          image: "assets/images/themes/cuisine_et_aliments.png",
          nbStars: calculateResult(4) + calculateResult(5) ,
          stage: calculateResult(4) + calculateResult(5),
          text: 'Cuisine et aliments',
          callback: SubThemes(
            title: 'Cuisine et aliments',
            theme: 3,
            user: widget.user,
          ),
          color: Palette.cuisine,
          type: "theme",
        ),
        Bubble(
          image: "assets/images/themes/animaux.png",
          nbStars: calculateResult(2) + calculateResult(3),
          stage: calculateResult(2) + calculateResult(3),
          text: 'Animaux',
          callback: SubThemes(
            title: 'Animaux',
            theme: 4,
            user: widget.user,
          ),
          color: Palette.animaux,
          type: "theme",
        ),
        Bubble(
          image: "assets/images/themes/mes_habits.png",
          nbStars: calculateResult(10) + calculateResult(11),
          stage: calculateResult(10) + calculateResult(11),
          text: 'Mon corps et mes habits',
          callback: SubThemes(
            title: 'Mon corps et mes habits',
            theme: 5,
            user: widget.user,
          ),
          color: Palette.corps,
          type: "theme",
        ),
        Bubble(
          image: "assets/images/themes/sports.png",
          nbStars: calculateResult(0) + calculateResult(1),
          stage: calculateResult(0) + calculateResult(1),
          text: 'Sports et loisirs',
          callback: SubThemes(
            title: 'Sports et loisirs',
            theme: 6,
            user: widget.user,
          ),
          color: Palette.sports,
          type: "theme",
        ),
      ],
    ));
  }
}
