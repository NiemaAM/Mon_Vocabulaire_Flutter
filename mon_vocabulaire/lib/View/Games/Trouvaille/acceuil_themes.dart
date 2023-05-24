import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/ferme.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/bubble2.dart';
import 'acceuil_subTheme.dart';

class TrouvailleThemes extends StatefulWidget {
  const TrouvailleThemes({super.key});

  @override
  State<TrouvailleThemes> createState() => _TrouvailleThemesState();
}

class _TrouvailleThemesState extends State<TrouvailleThemes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/search.png",
              width: 40,
            ),
            const Text(
              "  Trouvaille",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Bubble2(
                    image: "assets/images/themes/ecole.png",
                    text: 'L’école',
                    callback: TrouvailleSubThemes(),
                    color: Palette.ecole,
                    type: "theme",
                  ),
                  const Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Bubble2(
                    image: "assets/images/themes/maison.png",
                    text: 'Maison et famille',
                    callback: TrouvailleSubThemes(),
                    color: Palette.maison,
                    type: "theme",
                  ),
                ],
              ),
              Row(
                children: [
                  Bubble2(
                    image: "assets/images/themes/cuisine_et_aliments.png",
                    text: 'cuisine_et_aliments',
                    callback: TrouvailleSubThemes(),
                    color: Palette.cuisine,
                    type: "theme",
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Bubble2(
                    image: "assets/images/themes/animaux.png",
                    text: 'animaux',
                    callback: TrouvailleSubThemes(),
                    color: Palette.animaux,
                    type: "theme",
                  ),
                ],
              ),
              Row(
                children: [
                  Bubble2(
                    image: "assets/images/themes/mes_habits.png",
                    text: 'mes_habits',
                    callback: TrouvailleSubThemes(),
                    color: Palette.corps,
                    type: "theme",
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Bubble2(
                    image: "assets/images/themes/sports.png",
                    text: 'sports',
                    callback: TrouvailleSubThemes(),
                    color: Palette.sports,
                    type: "theme",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
