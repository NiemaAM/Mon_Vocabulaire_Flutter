import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/View/Games/jeux.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../../Widgets/Appbars/home_app_bar.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({super.key, required this.user});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  late ScrollController _hideButtonController;
  bool _isVisible = true;
  int result = 0;
  int words = 0;

  Future<void> calculateResult(themeId) async {
    DatabaseHelper();
    Progression _result =
        await DatabaseHelper().getProgression(widget.user.id!, themeId);
    setState(() {
      result = _result.stars;
      words = _result.mots;
    });
  }

  int getResult(subThemeId) {
    calculateResult(subThemeId);
    return result;
  }

  int getWords(subThemeId) {
    calculateResult(subThemeId);
    return words;
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.addObserver(this);
    AudioBK.pauseBK();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AudioBK.pauseBK();
    } else {
      AudioBK.playBK();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AudioBK.playBK();
    _isVisible = true;
    _hideButtonController = ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: GridView.count(
              controller: _hideButtonController,
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: width > 500 ? 1 : 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              children: [
                Bubble(
                  image: "assets/images/themes/ecole.png",
                  nbStars: getResult(1) + getResult(2),
                  stage: getWords(1) + getWords(2),
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
                  image: "assets/images/themes/maison_et_famille.png",
                  nbStars: getResult(3) + getResult(4),
                  stage: getWords(3) + getWords(4),
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
                  nbStars: getResult(5) + getResult(6),
                  stage: getWords(5) + getWords(6),
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
                  nbStars: getResult(7) + getResult(8),
                  stage: getWords(7) + getWords(8),
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
                  nbStars: getResult(9) + getResult(10),
                  stage: getWords(9) + getWords(10),
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
                  image: "assets/images/themes/sports_et_loisirs.png",
                  nbStars: getResult(11) + getResult(12),
                  stage: getWords(11) + getWords(12),
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
            ),
          ),
          CustomAppBarHome(user: widget.user),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1 : 0,
        duration: const Duration(seconds: 1),
        child: Button(
          callback: () {
            Navigator.of(context).push(
              SlideButtom(page: Games(user: widget.user)),
            );
          },
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "JOUER  ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width > 500 ? 20 : 18,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Ionicons.game_controller,
                color: Palette.white,
                size: width > 500 ? 35 : 30,
              ),
            ],
          ),
          width: width > 500 ? 170 : 150,
          heigth: width > 500 ? 70 : 60,
          color: Palette.pink,
        ),
      ),
    );
  }
}
