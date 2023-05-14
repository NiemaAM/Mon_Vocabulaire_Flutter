// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/quiz_prposition.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import '../../Model/quiz_model.dart';
import '../../Services/audio_background.dart';
import '../../Services/sfx.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/button.dart';
import '../../Widgets/quiz_app_bar.dart';

class QuizImageTexts extends StatefulWidget {
  final int subTheme;
  final User user;
  const QuizImageTexts({super.key, required this.subTheme, required this.user});

  @override
  State<QuizImageTexts> createState() => _QuizImageTextsState();
}

class _QuizImageTextsState extends State<QuizImageTexts> {
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
  int time = 0;
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
    }
  }

  void endQuiz() {
    if (index == size && chances != 0) {
      setState(() {
        quizEnded = true;
      });
      Sfx.play("audios/sfx/win.mp3", 1);
      _controllerConfetti.play();
    } else if (chances == 0) {
      setState(() {
        quizEnded = true;
      });
      Sfx.play("audios/sfx/lose.mp3", 1);
    }
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
                      height: height / 2,
                      width: width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(100),
                            topLeft: Radius.circular(100)),
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
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.close,
                                  color: Palette.red,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: width > 500 ? height / 18 : height / 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: width / 3.5,
                                    right: width / 3.5,
                                  ),
                                  child: Image.asset(
                                    reponse[1],
                                  ),
                                ),
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
            child: SizedBox(
              height: height / 2.4,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: width / 300,
                  mainAxisSpacing: width / 300,
                  crossAxisSpacing: width / 300,
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List.generate(
                    mots.length,
                    (int index) {
                      String key = mots[index];
                      return Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Center(
                              child: Button(
                                enabled: !quizEnded,
                                content: Center(
                                  child: Text(key,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
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
                                      Sfx.play("audios/sfx/zew.mp3", 1);
                                      Timer(const Duration(seconds: 1), () {
                                        nextQuestion();
                                        setState(() {
                                          chances -= 1;
                                          duration = 30;
                                          didResponse = false;
                                        });
                                        endQuiz();
                                      });
                                    }
                                  }
                                },
                                heigth: 100,
                                width: width / 2.4,
                                radius: 30,
                              ),
                            ),
                          ]);
                    },
                  ),
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
        ],
      ),
    );
  }
}
