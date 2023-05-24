// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/quiz_model.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Quiz/lesson.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/quiz_app_bar.dart';
import 'package:mon_vocabulaire/Widgets/Popups/quiz_popup.dart';
import '../../Model/quiz_prposition.dart';
import '../../Services/audio_background.dart';
import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/button.dart';

class QuizTextImages extends StatefulWidget {
  final int subTheme;
  final User user;
  const QuizTextImages({super.key, required this.subTheme, required this.user});

  @override
  State<QuizTextImages> createState() => _QuizTextImagesState();
}

class _QuizTextImagesState extends State<QuizTextImages> {
  Color color = Palette.lightGrey;
  Color color2 = Palette.lightGrey;
  int chances = 3;
  String correct = '';
  String theme = '';
  String subTheme = '';
  QuizModel quizModel = QuizModel();
  List<Proposition> questions = [];
  int index = 0;
  List<String> images = [];
  List<String> mots = [];
  List<String> reponse = [];
  bool didResponse = false;
  String response = '';
  bool quizEnded = false;
  late ConfettiController _controllerConfetti;

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

  int duration = 30;
  int time = 30;
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration > 0 && !quizEnded) {
          duration -= 1; // decrement the duration every second
          time += 1;
        } else if (chances > 0 && !quizEnded) {
          timer.cancel(); // stop the timer when the duration reaches 0
          nextQuestion(); // execute the function after the timer is done
          duration = 30;
          startTimer();
        }
        if (index == size || chances == 0 || quizEnded) {
          duration = 0;
        }
        if (duration <= 0 && !didResponse && !quizEnded) {
          chances--;
          Sfx.play("audios/sfx/zew.mp3", 1);
          heartVisible();
          endQuiz();
        }
      });
    });
  }

  bool first = true;
  getQuestions() async {
    List<Proposition> quest =
        await quizModel.getRandomPropositions(theme, subTheme);
    setState(() {
      questions = quest;
    });
    setState(() {
      if (quizModel.getSize() >= 10) {
        size = 10;
      } else {
        size = quizModel.getSize();
      }
    });
    nextQuestion();
  }

  int size = 5;
  nextQuestion() async {
    if (first) {
      setState(() {
        images = questions[index]
            .propositionsImages
            .map((element) => element.toString())
            .toList();
        mots = questions[index]
            .propositions
            .map((element) => element.toString())
            .toList();
        reponse = questions[index]
            .reponse
            .map((element) => element.toString())
            .toList();
        correct = reponse[3];
        first = false;
        if (didResponse) {
          nextQuestion();
        }
      });
      Voice.play(reponse[0], 1);
    } else if (index < size) {
      setState(() {
        index += 1;
        images = questions[index]
            .propositionsImages
            .map((element) => element.toString())
            .toList();
        mots = questions[index]
            .propositions
            .map((element) => element.toString())
            .toList();
        reponse = questions[index]
            .reponse
            .map((element) => element.toString())
            .toList();
        correct = reponse[3];
      });
      if (index != size) {
        Voice.play(reponse[0], 1);
      }
    }
  }

  void endQuiz() {
    if (chances == 0) {
      setState(() {
        quizEnded = true;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return QuizPopup(
            chances: chances,
            timer: time.toDouble(),
            onButton1Pressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            onButton2Pressed: () {
              Navigator.pop(context);
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
            onButton3Pressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonPage(
                    subTheme: widget.subTheme,
                    user: widget.user,
                  ),
                ),
              );
            },
          );
        },
      );
    }
    if (index == size && chances != 0) {
      setState(() {
        quizEnded = true;
      });
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return QuizPopup(
            chances: chances,
            timer: time.toDouble(),
            onButton1Pressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            onButton2Pressed: () {
              Navigator.pop(context);
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
            onButton3Pressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonPage(
                    subTheme: widget.subTheme,
                    user: widget.user,
                  ),
                ),
              );
            },
          );
        },
      );
      _controllerConfetti.play();
    }
  }

  bool _visible = false;
  void heartVisible() {
    Timer(const Duration(microseconds: 500), () {
      setState(() {
        _visible = true;
      });
      Timer(const Duration(seconds: 1), () {
        setState(() {
          _visible = false;
        });
      });
    });
  }

  Widget looseHeart() {
    return AnimatedOpacity(
        // If the widget is visible, animate to 0.0 (invisible).
        // If the widget is hidden, animate to 1.0 (fully visible).
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(seconds: 1),
        // The green box must be a child of the AnimatedOpacity widget.
        child: const Icon(
          Icons.heart_broken_rounded,
          color: Palette.red,
          size: 150,
        ));
  }

  @override
  void initState() {
    super.initState();
    AudioBK.pauseBK();
    getTheme();
    getQuestions();
    startTimer();
    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));
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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: QuizAppBar(
            totalDuration: 30,
            chances: chances,
            duration: duration,
            user: widget.user,
            question: index >= size ? size : index + 1,
            size: size,
          )),
      body: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Stack(
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
                        child: Center(
                            child: Text(
                          correct,
                          style: const TextStyle(
                              color: Palette.white, fontSize: 30),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Stack(children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    color: Palette.red,
                                    size: 40,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.center,
                              child: Button(
                                color: Palette.blue,
                                content: const Icon(
                                  Icons.volume_up,
                                  color: Palette.white,
                                  size: 50,
                                ),
                                callback: () {
                                  if (!quizEnded) {
                                    Voice.play(reponse[0], 1);
                                  } else {
                                    endQuiz();
                                  }
                                },
                                width: 100,
                                heigth: 100,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 70, top: 20),
                            child: Align(
                              alignment: Alignment.center,
                              child: Button(
                                content: Image.asset(
                                    "assets/images/themes/snail.png"),
                                color: Palette.pink,
                                callback: () {
                                  if (!quizEnded) {
                                    Voice.play(reponse[0], 0.60);
                                  } else {
                                    endQuiz();
                                  }
                                },
                                heigth: 35,
                                width: 35,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Padding(
              padding: EdgeInsets.only(
                  top: width > 500 ? height / 3.7 : height / 2.7),
              child: GridView.count(
                crossAxisCount: 2,
                padding: EdgeInsets.only(
                    left: width > 500 ? 60 : 0,
                    right: width > 500 ? 60 : 0,
                    top: width > 500 ? 60 : 0),
                children: List.generate(
                  mots.length,
                  (int index) {
                    String key = mots[index];
                    String value = images[index];
                    return Center(
                      child: Button(
                        content: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            value,
                          ),
                        ),
                        color: didResponse
                            ? key == response
                                ? response == correct
                                    ? Palette.lighterGreen
                                    : Palette.lightRed
                                : key == correct
                                    ? Palette.lighterGreen
                                    : Palette.white
                            : Palette.white,
                        callback: () {
                          if (!quizEnded) {
                            setState(() {
                              didResponse = true;
                              response = key;
                            });
                            if (key == correct) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Palette.lightGreen,
                                content: Text(
                                  'Bonne reponse',
                                  style: TextStyle(
                                      color: Palette.white, fontSize: 18),
                                ),
                              ));
                              Sfx.play("audios/sfx/ding.mp3", 1);
                              Timer(const Duration(seconds: 1), () {
                                nextQuestion();
                                setState(() {
                                  duration = 30;
                                  didResponse = false;
                                });
                                endQuiz();
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Palette.red,
                                content: Text(
                                  'Mauvaise reponse',
                                  style: TextStyle(
                                      color: Palette.white, fontSize: 18),
                                ),
                              ));
                              Sfx.play("audios/sfx/zew.mp3", 1);
                              heartVisible();
                              Timer(const Duration(seconds: 2), () {
                                nextQuestion();
                                setState(() {
                                  chances -= 1;
                                  duration = 30;
                                  didResponse = false;
                                });
                                endQuiz();
                              });
                            }
                          } else {
                            endQuiz();
                          }
                        },
                        heigth: width > 500 ? width / 2.8 : width / 2.2,
                        width: width > 500 ? width / 2.8 : width / 2.2,
                        radius: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          ConfettiWidget(
            gravity: 0,
            confettiController: _controllerConfetti,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            numberOfParticles: 20,
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Palette.lightGreen,
              Palette.blue,
              Palette.pink,
              Palette.orange,
              Palette.purple
            ], // manually specify the colors to be used
          ),
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: Align(
              alignment: Alignment.topCenter,
              child: looseHeart(),
            ),
          ),
        ],
      ),
    );
  }
}
