import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'package:mon_vocabulaire/View/Settings/settingsPage2.dart';

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
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsPage2(),
                        ),
                      );
                    },
                    icon: Icon(Icons.settings)),
              ),
              Bubble(
                image: "assets/themes_images/ecole.png",
                isStart: widget.user.stars_per_subtheme[5]! &&
                    widget.user.stars_per_subtheme[6]!,
                stage: widget.user.words_per_subtheme[5]! +
                    widget.user.words_per_subtheme[6]!,
                text: 'L’école',
                callback: SubThemes(
                  title: 'L’école',
                  theme: 1,
                  user: widget.user,
                ),
                color: Palette.orange,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Bubble(
                    image: "assets/themes_images/maison.png",
                    isStart: widget.user.stars_per_subtheme[9]! &&
                        widget.user.stars_per_subtheme[10]!,
                    stage: widget.user.words_per_subtheme[9]! +
                        widget.user.words_per_subtheme[10]!,
                    text: 'Maison et famille',
                    callback: SubThemes(
                      title: 'Maison et famille',
                      theme: 2,
                      user: widget.user,
                    ),
                    color: Palette.lightGreen,
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Bubble(
                    image: "assets/themes_images/cuisine_et_aliments.png",
                    isStart: widget.user.stars_per_subtheme[11]! &&
                        widget.user.stars_per_subtheme[12]!,
                    stage: widget.user.words_per_subtheme[11]! +
                        widget.user.words_per_subtheme[12]!,
                    text: 'Cuisine et aliments',
                    callback: SubThemes(
                      title: 'Cuisine et aliments',
                      theme: 3,
                      user: widget.user,
                    ),
                    color: Palette.yellow,
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              CircleAvatar(
                radius: width >= 500 ? 90 : 0,
                backgroundColor: Colors.transparent,
                child: Image.asset(
                  "assets/logo.png",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: SizedBox()),
                  Bubble(
                    image: "assets/themes_images/animaux.png",
                    isStart: widget.user.stars_per_subtheme[1]! &&
                        widget.user.stars_per_subtheme[2]!,
                    stage: widget.user.words_per_subtheme[1]! +
                        widget.user.words_per_subtheme[2]!,
                    text: 'Animaux',
                    callback: SubThemes(
                      title: 'Animaux',
                      theme: 4,
                      user: widget.user,
                    ),
                    color: Palette.pink,
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Bubble(
                    image: "assets/themes_images/mes_habits.png",
                    isStart: widget.user.stars_per_subtheme[3]! &&
                        widget.user.stars_per_subtheme[4]!,
                    stage: widget.user.words_per_subtheme[3]! +
                        widget.user.words_per_subtheme[4]!,
                    text: 'Mon corps et mes habits',
                    callback: SubThemes(
                      title: 'Mon corps et mes habits',
                      theme: 5,
                      user: widget.user,
                    ),
                    color: Palette.purple,
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
              Bubble(
                image: "assets/themes_images/sports.png",
                isStart: widget.user.stars_per_subtheme[7]! &&
                    widget.user.stars_per_subtheme[8]!,
                stage: widget.user.words_per_subtheme[7]! +
                    widget.user.words_per_subtheme[8]!,
                text: 'Sports et loisirs',
                callback: SubThemes(
                  title: 'Sports et loisirs',
                  theme: 6,
                  user: widget.user,
                ),
                color: Palette.indigo,
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
