import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/ferme.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/foret.dart';
import '../../../Widgets/Palette.dart';
import '../../../Widgets/bubble2.dart';

class TrouvailleSubThemes extends StatefulWidget {
  const TrouvailleSubThemes({super.key});

  @override
  State<TrouvailleSubThemes> createState() => _TrouvailleSubThemesState();
}

class _TrouvailleSubThemesState extends State<TrouvailleSubThemes> {
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
              Bubble2(
                image: "assets/images/themes/ecole.png",
                text: 'L’école',
                callback: Ferme(),
                color: Palette.ecole,
                type: "theme",
              ),
              Bubble2(
                image: "assets/images/themes/maison.png",
                text: 'Maison et famille',
                callback: Foret(),
                color: Palette.maison,
                type: "theme",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
