import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mon_vocabulaire/Model/user.dart';
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
                  image: "assets/images/themes/maison_et_famille.png",
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
                  image: "assets/images/themes/sports_et_loisirs.png",
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
