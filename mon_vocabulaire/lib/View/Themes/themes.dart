import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Themes/sub_themes.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Themes extends StatefulWidget {
  const Themes({super.key});

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              LinearPercentIndicator(
                width: width - 100,
                animation: true,
                lineHeight: 25.0,
                animationDuration: 1000,
                percent: 0.7,
                barRadius: const Radius.circular(100),
                progressColor: Palette.lightGreen,
                backgroundColor: Palette.lightGrey,
                center: const Text(
                  "150/240 mots",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Text(
                "20",
                style: TextStyle(
                    color: Palette.indigo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(child: SizedBox()),
              Image.asset(
                'assets/themes_images/coin.png',
                scale: 20,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
                child: Column(
              children: [
                const Bubble(
                  image: "assets/themes_images/animaux.png",
                  isStart: true,
                  stage: 20,
                  text: 'Animaux',
                  callback: SubThemes(
                    title: 'Animaux',
                    theme: 1,
                  ),
                  color: Palette.pink,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(child: SizedBox()),
                    Bubble(
                      image: "assets/themes_images/mes_habits.png",
                      isStart: false,
                      stage: 60,
                      text: 'Mon corps et mes habits',
                      callback: SubThemes(
                        title: 'Mon corps et mes habits',
                        theme: 2,
                      ),
                      color: Palette.purple,
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Bubble(
                      image: "assets/themes_images/ecole.png",
                      isStart: true,
                      stage: 100,
                      text: 'L’école',
                      callback: SubThemes(
                        title: 'L’école',
                        theme: 3,
                      ),
                      color: Palette.orange,
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Expanded(child: SizedBox()),
                    Bubble(
                      image: "assets/themes_images/sports.png",
                      isStart: false,
                      stage: 30,
                      text: 'Sports et loisirs',
                      callback: SubThemes(
                        title: 'Sports et loisirs',
                        theme: 4,
                      ),
                      color: Palette.indigo,
                    ),
                    Expanded(
                      flex: 20,
                      child: SizedBox(),
                    ),
                    Bubble(
                      image: "assets/themes_images/maison.png",
                      isStart: false,
                      stage: 80,
                      text: 'Maison et famille',
                      callback: SubThemes(
                        title: 'Maison et famille',
                        theme: 5,
                      ),
                      color: Palette.lightGreen,
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
                const Bubble(
                  image: "assets/themes_images/cuisine_et_aliments.png",
                  isStart: false,
                  stage: 20,
                  text: 'Cuisine et aliments',
                  callback: SubThemes(
                    title: 'Cuisine et aliments',
                    theme: 6,
                  ),
                  color: Palette.yellow,
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            )),
          ),
        ));
  }
}
