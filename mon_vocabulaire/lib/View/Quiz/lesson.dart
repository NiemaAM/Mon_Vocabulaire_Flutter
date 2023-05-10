import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/lesson_model.dart';
import 'package:mon_vocabulaire/View/Quiz/quiz_text_images.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../Model/quiz_model.dart';
import '../../Model/user.dart';
import '../../Services/audio_background.dart';
import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/button.dart';

class LessonPage extends StatefulWidget {
  final int subTheme;
  final User user;
  const LessonPage({super.key, required this.subTheme, required this.user});

  @override
  State<LessonPage> createState() => _LessonPage();
}

class _LessonPage extends State<LessonPage> {
  int coursbar = 3;
  int chances = 3;
  String theme = '';
  String subTheme = '';
  QuizModel quizModel = QuizModel();
  List<Lesson> lesson = [];
  int index = 0;
  int size = 5;
  getTheme() {
    switch (widget.subTheme) {
      case 1:
        setState(() {
          theme = "École";
          subTheme = "Eléments";
        });
        break;
      case 2:
        setState(() {
          theme = 'École';
          subTheme = 'Personnes';
        });
        break;
      case 3:
        setState(() {
          theme = 'Maison et Famille';
          subTheme = 'Maison';
        });
        break;
      case 4:
        setState(() {
          theme = 'Maison et Famille';
          subTheme = 'Famille';
        });
        break;
      case 5:
        setState(() {
          theme = 'Cuisine et aliments';
          subTheme = 'Cuisine';
        });
        break;
      case 6:
        setState(() {
          theme = 'Cuisine et aliments';
          subTheme = 'Aliments';
        });
        break;
      case 7:
        setState(() {
          theme = 'Animaux';
          subTheme = 'Ferme';
        });
        break;
      case 8:
        setState(() {
          theme = 'Animaux';
          subTheme = 'Forêt';
        });
        break;
      case 9:
        setState(() {
          theme = 'Mon corps et mes habits';
          subTheme = 'Mon corps';
        });
        break;
      case 10:
        setState(() {
          theme = 'Mon corps et mes habits';
          subTheme = 'Mes habits';
        });
        break;
      case 11:
        setState(() {
          theme = 'Sports et loisirs';
          subTheme = 'Sports';
        });
        break;
      case 12:
        setState(() {
          theme = 'Sports et loisirs';
          subTheme = 'Loisirs';
        });
        break;
      default:
    }
  }

  getLesson() async {
    List<Lesson> les = await quizModel.getLesson(theme, subTheme);
    setState(() {
      lesson = les;
      if (quizModel.getSize() >= 10) {
        size = 9;
      } else {
        size = quizModel.getSize() - 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    AudioBK.pauseBK();
    getTheme();
    getLesson();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.play("audios/sfx/pop.mp3", 1);
    AudioBK.playBK();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AudioBK.pauseBK();
    Voice.play(lesson[index].audio, 1);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Center(
            child: LinearPercentIndicator(
              width: width - 35,
              animation: false,
              lineHeight: 25.0,
              animationDuration: 1,
              percent: index / size,
              barRadius: const Radius.circular(100),
              progressColor: Palette.lightGreen,
              backgroundColor: Theme.of(context).shadowColor,
              center: Text(
                "${index + 1} sur ${size + 1} mots",
                style: const TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
        //fonds container
        body: Stack(children: [
          Stack(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    height: height / 1.45,
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100)),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topCenter,
                    child: SizedBox(
                      height: height / 1.7,
                    ),
                  ),
                ],
              ),
              //close icon
              Center(
                child: Stack(alignment: Alignment.topCenter, children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            title: 'Quitter la leçon',
                            desc: 'Es-tu sûr(e) de vouloir quitter ?',
                            btnCancelText: "Quitter",
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                            btnOkText: "Rester",
                            btnOkOnPress: () {},
                          ).show();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Palette.red,
                        )),
                  ),
                  Stack(
                    children: [
                      Padding(
                        // dis app bar button
                        padding: EdgeInsets.only(top: height / 20),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: height / 2.7,
                            width: width / 1.3,
                            decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Palette.lightGrey,
                                  blurRadius: 0,
                                  offset: Offset(0, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(40),
                              child: Image.asset(
                                lesson[index].image,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 5,
                        left: width > 500 ? width / 13 : 15,
                        child: Button(
                          content: Icon(
                            Icons.chevron_left_rounded,
                            color: index > 0 ? Palette.white : Palette.grey,
                            size: 40,
                          ),
                          color: index > 0
                              ? Theme.of(context).secondaryHeaderColor
                              : Palette.lightGrey,
                          callback: () {
                            if (index > 0) {
                              Sfx.play("audios/sfx/plip.mp3", 1);
                              setState(() {
                                index -= 1;
                              });
                            }
                            Voice.play(lesson[index].audio, 1);
                          },
                          heigth: 60,
                          width: 60,
                        ),
                      ),
                      Positioned(
                        top: height / 5,
                        right: width > 500 ? width / 13 : 15,
                        child: Button(
                          content: Icon(
                            Icons.chevron_right_rounded,
                            color: index != size ? Palette.white : Palette.grey,
                            size: 40,
                          ),
                          color: index != size
                              ? Theme.of(context).secondaryHeaderColor
                              : Palette.lightGrey,
                          callback: () {
                            if (index < size) {
                              Sfx.play("audios/sfx/plip.mp3", 1);
                              setState(() {
                                index += 1;
                              });
                            } else {
                              Sfx.play("audios/sfx/done.mp3", 1);
                              AwesomeDialog(
                                context: context,
                                headerAnimationLoop: false,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Leçon terminée',
                                desc: 'Bravo ! Tu as terminé ta leçon.',
                                btnCancelText: "Retour",
                                btnCancelOnPress: () {
                                  Navigator.pop(context);
                                },
                                btnOkText: "Suivant",
                                btnOkOnPress: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuizTextImages(
                                        subTheme: widget.subTheme,
                                        user: widget.user,
                                      ),
                                    ),
                                  );
                                },
                              ).show();
                            }
                          },
                          heigth: 60,
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 2.5),
                      child: Stack(
                        children: [
                          Container(
                            height: height / 3.8,
                            width: width / 1.3,
                            decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Palette.lightGrey,
                                  blurRadius: 0,
                                  offset: Offset(0, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Align(
                                alignment: const Alignment(0.01, 0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        lesson[index].article == "une"
                                            ? "(Nom,Féminin,Singulier)"
                                            : lesson[index].article == "de la"
                                                ? "(Nom,Féminin,Singulier)"
                                                : lesson[index].article == "des"
                                                    ? "(Nom,Pluriels)"
                                                    : "(Nom,Masculin,Singulier)",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "${lesson[index].article} ${lesson[index].mot}",
                                        style: const TextStyle(
                                            fontSize: 20, color: Palette.black),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Button(
                        color: Theme.of(context).secondaryHeaderColor,
                        content: const Icon(
                          Icons.volume_up,
                          color: Palette.white,
                          size: 50,
                        ),
                        callback: () {
                          Voice.play(lesson[index].audio, 1);
                        },
                        width: 100,
                        heigth: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70, top: height / 4.5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Button(
                        content: Image.asset("assets/images/themes/snail.png"),
                        color: Palette.blue,
                        callback: () {
                          Voice.play(lesson[index].audio, 0.60);
                        },
                        heigth: 35,
                        width: 35,
                      ),
                    ),
                  ),
                ]),
              )
            ],
          )
        ]));
  }
}
