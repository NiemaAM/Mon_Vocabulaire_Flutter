// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/voice.dart';
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
  int wordsSubTheme1 = 0;
  int wordsSubTheme2 = 0;
  int wordsSubTheme3 = 0;
  int wordsSubTheme4 = 0;
  int wordsSubTheme5 = 0;
  int wordsSubTheme6 = 0;
  int starsSubTheme1 = 0;
  int starsSubTheme2 = 0;
  int starsSubTheme3 = 0;
  int starsSubTheme4 = 0;
  int starsSubTheme5 = 0;
  int starsSubTheme6 = 0;

  Future<void> getResult() async {
    DatabaseHelper();
    Progression _result1 =
        await DatabaseHelper().getProgression(widget.user.id!, 1);
    Progression _result2 =
        await DatabaseHelper().getProgression(widget.user.id!, 2);
    Progression _result3 =
        await DatabaseHelper().getProgression(widget.user.id!, 3);
    Progression _result4 =
        await DatabaseHelper().getProgression(widget.user.id!, 4);
    Progression _result5 =
        await DatabaseHelper().getProgression(widget.user.id!, 5);
    Progression _result6 =
        await DatabaseHelper().getProgression(widget.user.id!, 6);
    Progression _result7 =
        await DatabaseHelper().getProgression(widget.user.id!, 7);
    Progression _result8 =
        await DatabaseHelper().getProgression(widget.user.id!, 8);
    Progression _result9 =
        await DatabaseHelper().getProgression(widget.user.id!, 9);
    Progression _result10 =
        await DatabaseHelper().getProgression(widget.user.id!, 10);
    Progression _result11 =
        await DatabaseHelper().getProgression(widget.user.id!, 11);
    Progression _result12 =
        await DatabaseHelper().getProgression(widget.user.id!, 12);
    setState(() {
      wordsSubTheme1 = _result1.mots + _result2.mots;
      wordsSubTheme2 = _result3.mots + _result4.mots;
      wordsSubTheme3 = _result5.mots + _result6.mots;
      wordsSubTheme4 = _result7.mots + _result8.mots;
      wordsSubTheme5 = _result9.mots + _result10.mots;
      wordsSubTheme6 = _result11.mots + _result12.mots;
      starsSubTheme1 = _result1.stars + _result2.stars;
      starsSubTheme2 = _result3.stars + _result4.stars;
      starsSubTheme3 = _result5.stars + _result6.stars;
      starsSubTheme4 = _result7.stars + _result8.stars;
      starsSubTheme5 = _result9.stars + _result10.stars;
      starsSubTheme6 = _result11.stars + _result12.stars;
    });
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
      Voice.pause();
      Sfx.pause();
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
    getResult();
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
    getResult();
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
                  nbStars: starsSubTheme1,
                  stage: wordsSubTheme1,
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
                  nbStars: starsSubTheme2,
                  stage: wordsSubTheme2,
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
                  nbStars: starsSubTheme3,
                  stage: wordsSubTheme3,
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
                  nbStars: starsSubTheme4,
                  stage: wordsSubTheme4,
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
                  nbStars: starsSubTheme5,
                  stage: wordsSubTheme5,
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
                  nbStars: starsSubTheme6,
                  stage: wordsSubTheme6,
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
