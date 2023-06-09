import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Cuisine.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Ferme.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Foret.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Sport_Loisirs.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_bureau.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_habits.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_salle_de_bain.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_salon.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Model/user.dart';

class Trouvaille extends StatefulWidget {
  final User user;
  const Trouvaille({super.key, required this.user});

  @override
  State<Trouvaille> createState() => _TrouvailleState();
}

class _TrouvailleState extends State<Trouvaille> {
  bool israndom = true;
  List<Widget> pages = [];
  int random = 10;

  @override
  void initState() {
    super.initState();
    AudioBK.pauseBK();
    setState(() {
      Random rnd;
      int min = 0;
      int max = 8;
      rnd = Random();
      random = min + rnd.nextInt(max - min);
      pages = [
        SportLoisirs(user: widget.user),
        Bureau(user: widget.user),
        Cuisine(user: widget.user),
        Ferme(user: widget.user),
        Foret(user: widget.user),
        Habits(user: widget.user),
        SalleDeBain(user: widget.user),
        Salon(user: widget.user),
      ];
    });
  }

  @override
  void dispose() {
    super.dispose();
    AudioBK.playBK();
  }

  @override
  Widget build(BuildContext context) {
    AudioBK.pauseBK();
    return random == 10
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Palette.lightBlue,
              ),
            ),
          )
        : pages[random];
  }
}
