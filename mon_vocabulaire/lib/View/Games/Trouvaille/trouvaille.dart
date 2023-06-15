import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/voice.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Cuisine.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Ferme.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Foret.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/Trouvaille_Sport_Loisirs.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_bureau.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_classe.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_habits.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_salle_de_bain.dart';
import 'package:mon_vocabulaire/View/Games/Trouvaille/trouvaille_salon.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';

class Trouvaille extends StatefulWidget {
  final User user;
  const Trouvaille({super.key, required this.user});

  @override
  State<Trouvaille> createState() => _TrouvailleState();
}

class _TrouvailleState extends State<Trouvaille> with WidgetsBindingObserver {
  bool israndom = true;
  List<Widget> pages = [];
  List<String> imagePaths = [
    "assets/images/themes/ecole.png",
    "assets/images/themes/maison_et_famille.png",
    "assets/images/themes/cuisine_et_aliments.png",
    "assets/images/themes/animaux.png",
    "assets/images/themes/mes_habits.png",
    "assets/images/themes/sports_et_loisirs.png",
  ];
  int random = 10;
  RealtimeDataController controller = RealtimeDataController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AudioBK.pauseBK();
    setState(() {
      pages = [
        Bureau(user: widget.user),
        ClassRoom(user: widget.user),
        Salon(user: widget.user),
        SalleDeBain(user: widget.user),
        Cuisine(user: widget.user),
        Cuisine(user: widget.user),
        Ferme(user: widget.user),
        Foret(user: widget.user),
        Habits(user: widget.user),
        Habits(user: widget.user),
        SportLoisirs(user: widget.user),
        SportLoisirs(user: widget.user),
      ];
    });
  }

  @override
  void dispose() {
    super.dispose();
    AudioBK.playBK();
    Voice.pause();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioBK.pauseBK();
      Voice.pause();
      Sfx.pause();
    } else {
      AudioBK.playBK();
    }
  }

  @override
  Widget build(BuildContext context) {
    AudioBK.pauseBK();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.lightBlue,
      appBar: CustomAppBarGames(
        user: widget.user,
      ),
      body: Center(
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: width > 500 ? 0 : 10,
          crossAxisSpacing: width > 500 ? 0 : 10,
          padding: EdgeInsets.only(
              right: width > 500 ? 80 : 20, left: width > 500 ? 80 : 20),
          crossAxisCount: 2,
          children: List.generate(imagePaths.length, (index) {
            return Center(
              child: Button(
                callback: () {
                  Random rnd = Random();
                  int random;
                  if (index == 0) {
                    random = index + rnd.nextInt(2);
                  } else {
                    random = (index * 2) + rnd.nextInt(2);
                  }
                  controller.substractCoins(widget.user.id!, 30);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => pages[random]),
                  );
                },
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                ),
                color: Palette.white,
                heigth: width > 500 ? width / 3.5 : width / 2.5,
                width: width > 500 ? width / 3.5 : width / 2.5,
                radius: 20,
              ),
            );
          }),
        ),
      ),
    );
  }
}
