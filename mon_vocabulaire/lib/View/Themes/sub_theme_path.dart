// ignore_for_file: deprecated_member_use, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/View/Quiz/lesson.dart';
import 'package:mon_vocabulaire/View/Quiz/quiz_text_images.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/app_bar.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import '../../Services/sfx.dart';
import '../Quiz/drag_and_drop.dart';
import '../Quiz/quiz_image_texts.dart';

class LessonPath extends StatefulWidget {
  final int subTheme;
  final User user;
  const LessonPath({super.key, required this.subTheme, required this.user});

  @override
  State<LessonPath> createState() => _LessonPathState();
}

class _LessonPathState extends State<LessonPath> {
  String background = "";
  Color color = Palette.blue;
  String title = "";
  String image = "";
  int userProg = -1;
  int _currentIndex = 0;
  RealtimeDataController controller = RealtimeDataController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getQuiz() async {
    await controller.getProgression(widget.user.id!, widget.subTheme);
    Progression? progression = controller.progression;
    setState(() {
      userProg = progression!.quiz;
    });
  }

  bool finished = false;
  int part = -1;
  Future getFinished() async {
    bool _finished =
        await DatabaseHelper().getFinished(widget.user.id!, widget.subTheme);
    int _part =
        await DatabaseHelper().getPart(widget.user.id!, widget.subTheme);
    setState(() {
      finished = _finished;
      part = _part;
    });
  }

  @override
  void initState() {
    getFinished();
    super.initState();
    switch (widget.subTheme) {
      case 1:
        image = "assets/images/themes/elements.png";
        title = "Éléments";
        background = "school";
        color = Palette.ecole;
        break;
      case 2:
        image = "assets/images/themes/personnes.png";
        title = "Personnes";
        background = "school";
        color = Palette.ecole;
        break;
      case 3:
        image = "assets/images/themes/maison.png";
        title = "Maison";
        background = "home";
        color = Palette.maison;
        break;
      case 4:
        image = "assets/images/themes/famille.png";
        title = "Famille";
        background = "home";
        color = Palette.maison;
        break;
      case 5:
        image = "assets/images/themes/cuisine.png";
        title = "Cuisine";
        background = "kitchen";
        color = Palette.cuisine;
        break;
      case 6:
        image = "assets/images/themes/aliments.png";
        title = "Aliments";
        background = "kitchen";
        color = Palette.cuisine;
        break;
      case 7:
        image = "assets/images/themes/ferme.png";
        title = "Ferme";
        background = "forest";
        color = Palette.animaux;
        break;
      case 8:
        image = "assets/images/themes/foret.png";
        title = "Forêt";
        background = "forest";
        color = Palette.animaux;
        break;
      case 9:
        image = "assets/images/themes/mon_corps.png";
        title = "Mon corps";
        background = "cloths";
        color = Palette.corps;
        break;
      case 10:
        image = "assets/images/themes/mes_habits.png";
        title = "Mes habits";
        background = "cloths";
        color = Palette.corps;
        break;
      case 11:
        image = "assets/images/themes/sports.png";
        title = "Sports";
        background = "sports";
        color = Palette.sports;
        break;
      case 12:
        image = "assets/images/themes/loisirs.png";
        title = "Loisirs";
        background = "sports";
        color = Palette.sports;
        break;
      default:
    }
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.play("audios/sfx/pop.mp3", 1);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    getQuiz();
    getFinished();
    List<Widget> elements = [
      // Element 1
      Column(
        children: [
          Button(
            callback: () {
              Sfx.play("audios/sfx/plip.mp3", 1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizTextImages(
                    subTheme: widget.subTheme,
                    user: widget.user,
                    finished: finished,
                    part: part,
                  ),
                ),
              );
            },
            content: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: userProg >= 1 ? 1 : 0.5,
                      child: Image.asset(
                        "assets/images/themes/song.png",
                      ),
                    ),
                    Image.asset(
                      "assets/images/themes/lock.png",
                      color: userProg >= 1 ? Colors.transparent : Palette.black,
                    ),
                  ],
                ),
              ),
            ),
            width: width > 500 ? width / 2 : width / 1.8,
            heigth: width > 500 ? width / 2 : width / 1.8,
            color: userProg >= 1 ? Palette.white : color.withOpacity(0.6),
            radius: 500,
            enabled: userProg >= 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: width / 1.8,
              height: 60,
              decoration: const BoxDecoration(
                  color: Palette.pink,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Center(
                child: Text(
                  "ÉCOUTER",
                  style: TextStyle(
                      color: Palette.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),

      // Element 2
      Column(
        children: [
          Button(
            callback: () {
              Sfx.play("audios/sfx/plip.mp3", 1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizImageTexts(
                    subTheme: widget.subTheme,
                    user: widget.user,
                    finished: finished,
                    part: part,
                  ),
                ),
              );
            },
            content: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: userProg >= 2 ? 1 : 0.5,
                      child: Image.asset(
                        "assets/images/themes/images.png",
                      ),
                    ),
                    Image.asset(
                      "assets/images/themes/lock.png",
                      color: userProg >= 2 ? Colors.transparent : Palette.black,
                    ),
                  ],
                ),
              ),
            ),
            width: width > 500 ? width / 2 : width / 1.8,
            heigth: width > 500 ? width / 2 : width / 1.8,
            color: userProg >= 2 ? Palette.white : color.withOpacity(0.6),
            radius: 500,
            enabled: userProg >= 2,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: width / 1.8,
              height: 60,
              decoration: const BoxDecoration(
                  color: Palette.pink,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Center(
                child: Text(
                  "LIRE",
                  style: TextStyle(
                      color: Palette.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),

      // Element 3
      Column(
        children: [
          Button(
            callback: () {
              Sfx.play("audios/sfx/plip.mp3", 1);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DragAndDrop(
                    subTheme: widget.subTheme,
                    user: widget.user,
                    finished: finished,
                    part: part,
                  ),
                ),
              );
            },
            content: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Stack(
                  children: [
                    Opacity(
                      opacity: userProg >= 3 ? 1 : 0.5,
                      child: Image.asset(
                        "assets/images/themes/drag_and_drop.png",
                      ),
                    ),
                    Image.asset(
                      "assets/images/themes/lock.png",
                      color: userProg >= 3 ? Colors.transparent : Palette.black,
                    ),
                  ],
                ),
              ),
            ),
            width: width > 500 ? width / 2 : width / 1.8,
            heigth: width > 500 ? width / 2 : width / 1.8,
            color: userProg >= 3 ? Palette.white : color.withOpacity(0.6),
            radius: 500,
            enabled: userProg >= 3,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              width: width / 1.8,
              height: 60,
              decoration: const BoxDecoration(
                  color: Palette.pink,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Center(
                child: Text(
                  "ÉCRIRE",
                  style: TextStyle(
                      color: Palette.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
    ];

    return Scaffold(
      body: userProg == -1 || part == -1
          ? Stack(
              children: [
                SvgPicture.asset(
                    'assets/images/themes/backgrounds/$background.svg',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    color: Palette.white.withOpacity(0.65),
                    colorBlendMode: BlendMode.modulate),
                const Center(
                  child: CircularProgressIndicator(
                    color: Palette.lightBlue,
                  ),
                ),
                CustomAppBar(
                  title: title.toUpperCase(),
                  color: color,
                  automaticallyImplyLeading: true,
                  image: image,
                ),
              ],
            )
          : Stack(
              children: [
                SvgPicture.asset(
                    'assets/images/themes/backgrounds/$background.svg',
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    color: Palette.white.withOpacity(0.65),
                    colorBlendMode: BlendMode.modulate),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Button(
                        callback: () {
                          Sfx.play("audios/sfx/plip.mp3", 1);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LessonPage(
                                subTheme: widget.subTheme,
                                user: widget.user,
                                finished: finished,
                                part: part,
                              ),
                            ),
                          );
                        },
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                "assets/images/themes/lesson.png",
                                width: width / 2.8,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    "MA LEÇON",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width > 500 ? 25 : 20,
                                        color: Palette.black),
                                  ),
                                ),
                                Button(
                                  callback: () {
                                    Sfx.play("audios/sfx/plip.mp3", 1);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LessonPage(
                                          subTheme: widget.subTheme,
                                          user: widget.user,
                                          finished: finished,
                                          part: part,
                                        ),
                                      ),
                                    );
                                  },
                                  content: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          "LIRE",
                                          style: TextStyle(
                                              color: Palette.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.play_arrow_rounded,
                                          color: Palette.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  color: Palette.pink,
                                  width: 130,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: width > 500 ? 25 : 0,
                            )
                          ],
                        ),
                        width: width > 500 ? width - 150 : width - 40,
                        heigth: 200,
                        color: Palette.white,
                        radius: 20,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: width > 500 ? height / 3.5 + 80 : height / 3 + 80),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height / 2.2,
                          child: Center(
                            child: ScrollSnapList(
                              duration: 1000,
                              onItemFocus: (index) {
                                setState(() {
                                  _currentIndex = index;
                                });
                              },
                              itemSize: 200,
                              itemBuilder: (BuildContext context, int index) {
                                return elements[index];
                              },
                              initialIndex: userProg.toDouble() - 1,
                              dynamicItemSize: true,
                              shrinkWrap: true,
                              itemCount: elements.length,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(elements.length, (index) {
                            return Container(
                              width: 40,
                              height: 40,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentIndex == index
                                    ? Palette.pink
                                    : Palette.white,
                              ),
                              child: Center(
                                child: Text(
                                  _currentIndex == index
                                      ? "${_currentIndex + 1}"
                                      : "${index + 1}",
                                  style: TextStyle(
                                    color: _currentIndex == index
                                        ? Palette.white
                                        : Palette.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomAppBar(
                  title: title.toUpperCase(),
                  color: color,
                  automaticallyImplyLeading: true,
                  image: image,
                ),
              ],
            ),
    );
  }
}
