import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';

import '../../Model/user.dart';

class Themes extends StatefulWidget {
  final User user;
  const Themes({super.key, required this.user});

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
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
          nbStars: widget.user.stars_per_subtheme[5]! +
              widget.user.stars_per_subtheme[6]!,
          stage: widget.user.words_per_subtheme[5]! +
              widget.user.words_per_subtheme[6]!,
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
          nbStars: widget.user.stars_per_subtheme[9]! +
              widget.user.stars_per_subtheme[10]!,
          stage: widget.user.words_per_subtheme[9]! +
              widget.user.words_per_subtheme[10]!,
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
          nbStars: widget.user.stars_per_subtheme[11]! +
              widget.user.stars_per_subtheme[12]!,
          stage: widget.user.words_per_subtheme[11]! +
              widget.user.words_per_subtheme[12]!,
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
          nbStars: widget.user.stars_per_subtheme[1]! +
              widget.user.stars_per_subtheme[2]!,
          stage: widget.user.words_per_subtheme[1]! +
              widget.user.words_per_subtheme[2]!,
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
          nbStars: widget.user.stars_per_subtheme[3]! +
              widget.user.stars_per_subtheme[4]!,
          stage: widget.user.words_per_subtheme[3]! +
              widget.user.words_per_subtheme[4]!,
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
          nbStars: widget.user.stars_per_subtheme[7]! +
              widget.user.stars_per_subtheme[8]!,
          stage: widget.user.words_per_subtheme[7]! +
              widget.user.words_per_subtheme[8]!,
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
