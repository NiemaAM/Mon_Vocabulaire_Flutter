import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Table_Classe.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Cuisine.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'package:animator/animator.dart';

import 'package:mon_vocabulaire/Model/user.dart';
import '../../../Services/animation_route.dart';
import '../../../Services/sfx.dart';
import '../../../Widgets/Appbars/game_app_bar.dart';
import '../../../Widgets/BubbleThemes_Trouvaille.dart';
import 'Trouvaille_Bureau_Classe.dart';
import 'Trouvaille_Ferme.dart';
import 'Trouvaille_Foret.dart';
import 'Trouvaille_Habits.dart';
import 'Trouvaille_SalleDeBain.dart';
import 'Trouvaille_Salon.dart';

class TrouvailleThemes extends StatefulWidget {
  final User user;
  const TrouvailleThemes({super.key, required this.user});

  @override
  State<TrouvailleThemes> createState() => _TrouvailleThemesState();
}

class _TrouvailleThemesState extends State<TrouvailleThemes> {
  bool israndom = true;
  @override
  Widget build(BuildContext context) {
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
          childAspectRatio: width > 500 ? 0.9 : 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 25),
          children: [
            BubbleTrouvaille(
              image: "assets/images/themes/ecole.png",
              text: 'L’école',
              callback: () {
                if (israndom == true) {
                  print("Cas 1");
                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(
                      page: Bureau(
                    user: widget.user,
                  )));
                  setState(() {
                    israndom = false;
                  });
                } else {
                  print("Cas 2");
                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context)
                      .push(SizedSlide(page: ClassRoom(user: widget.user)));
                  setState(() {
                    israndom = true;
                  });
                }
              },
              color: Palette.ecole,
            ),

            BubbleTrouvaille(
              image: "assets/images/themes/maison.png",
              text: 'Maison et famille',
              callback: () {
                if (israndom == true) {
                  print("Cas 1");
                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(
                      page: SalleDeBain(
                    user: widget.user,
                  )));
                  setState(() {
                    israndom = false;
                  });
                } else {
                  print("Cas 2");
                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(
                      page: Salon(
                    user: widget.user,
                  )));
                  setState(() {
                    israndom = true;
                  });
                }
              },
              color: Palette.maison,
            ),

            BubbleTrouvaille(
              image: "assets/images/themes/cuisine_et_aliments.png",
              text: 'Cuisine et aliments',
              callback: () {
                Sfx.play("audios/sfx/plip.mp3", 1);
                Navigator.of(context).push(SizedSlide(
                    page: cuisine(
                  user: widget.user,
                )));
              },
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
                  Navigator.of(context).push(SizedSlide(
                      page: Foret(
                    user: widget.user,
                  )));
                } else {
                  setState(() {
                    israndom = true;
                  });

                  Sfx.play("audios/sfx/plip.mp3", 1);
                  Navigator.of(context).push(SizedSlide(
                      page: Ferme(
                    user: widget.user,
                  )));
                }
              },
              color: Palette.animaux,
            ),

            BubbleTrouvaille(
              image: "assets/images/themes/mes_habits.png",
              text: 'Mon corps et mes habits',
              callback: () {
                Sfx.play("audios/sfx/plip.mp3", 1);
                Navigator.of(context).push(SizedSlide(
                    page: DressingRoom(
                  user: widget.user,
                )));
              },
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
