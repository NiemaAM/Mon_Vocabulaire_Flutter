import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/classRoom.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'package:animator/animator.dart';

import 'package:mon_vocabulaire/Model/user.dart';
import '../../../Services/animation_route.dart';
import '../../../Services/sfx.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/BubbleThemes_Trouvaille.dart';
import 'Trouvaille_Bureau.dart';
import 'Trouvaille_Ferme.dart';
import 'Trouvaille_Foret.dart';

class TrouvailleThemes extends StatefulWidget {
  final User user;
  const TrouvailleThemes({super.key, required this.user});

  @override
  State<TrouvailleThemes> createState() => _TrouvailleThemesState();
}

class _TrouvailleThemesState extends State<TrouvailleThemes> {
  @override
  Widget build(BuildContext context) {
    bool israndom = true;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Palette.lightBlue,
        appBar: CustomAppBarGames(
          color: Palette.darkBlue,
          user: widget.user,
        ),
        body: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          childAspectRatio: width > 500 ? 1 : 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            BubbleTrouvaille(
              image: "assets/images/themes/ecole.png",
              text: 'L’école',
              callback: () {
                print("hhh");
                if (israndom == true) {
                  print("Cas 1");
                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(page: Bureau()));
                  setState(() {
                    israndom = false;
                  });
                } else {
                  print("Cas 2");
                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(page: ClassRoom()));
                  setState(() {
                    israndom = true;
                  });
                }
              },
              color: Palette.ecole,
            ),
            //Still no page
            BubbleTrouvaille(
              image: "assets/images/themes/maison.png",
              text: 'Maison et famille',
              callback: () {},
              color: Palette.maison,
            ),
            //Still no page
            BubbleTrouvaille(
              image: "assets/images/themes/cuisine_et_aliments.png",
              text: 'Cuisine et aliments',
              callback: () {},
              color: Palette.cuisine,
            ),
            BubbleTrouvaille(
              image: "assets/images/themes/animaux.png",
              text: 'Animaux',
              callback: () {
                if (israndom == true) {
                  setState(() {
                    israndom = false;
                  });

                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(page: Foret()));
                } else {
                  setState(() {
                    israndom = true;
                  });

                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(page: Ferme()));
                }
              },
              color: Palette.animaux,
            ),
            //still no page
            BubbleTrouvaille(
              image: "assets/images/themes/mes_habits.png",
              text: 'Mon corps et mes habits',
              callback: () {},
              color: Palette.corps,
            ),
            //Still no page
            BubbleTrouvaille(
              image: "assets/images/themes/sports.png",
              text: 'Sports et loisirs',
              callback: () {},
              color: Palette.sports,
            ),
          ],
        ));
  }
}
