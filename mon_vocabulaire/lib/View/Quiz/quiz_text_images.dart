// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/quiz_model.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/quiz_app_bar.dart';
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
  final bool _isEnabled = true;
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
          subTheme = 'Mammifères';
        });
        break;
      case 8:
        setState(() {
          theme = 'Animaux';
          subTheme = 'Oiseaux et autres';
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

  void song() async {}

//TODO: change this
  void call() {
    setState(() {
      color = Palette.darkGreen;
      color2 = Palette.lightRed;
    });
  }

  int duration = 30;
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration > 0) {
          duration -= 1; // decrement the duration every second
        } else {
          timer.cancel(); // stop the timer when the duration reaches 0
          nextQuestion(); // execute the function after the timer is done
          duration = 30;
          startTimer();
        }
        if (index == size || chances == 0) {
          duration = 0;
        }
      });
    });
  }

  getQuestions() async {
    List<Proposition> quest =
        await quizModel.getRandomPropositions(theme, subTheme);
    setState(() {
      questions = quest;
    });
    setState(() {
      size = quizModel.getSize();
    });
    nextQuestion();
  }

  int size = 5;
  nextQuestion() async {
    if (index == 0) {
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
        index += 1;
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

  @override
  void initState() {
    super.initState();
    AudioBK.pauseBK();
    getTheme();
    getQuestions();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.play("sfx/pop.mp3", 1);
    AudioBK.playBK();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            question: index,
            size: size,
          )),
      body: index == size
          ? AlertDialog(
              // <-- SEE HERE
              title: const Text('Bien joué !'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: const <Widget>[
                    Text("Tu as terminé le quiz :)"),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Retour'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Accueil'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text('Réessayer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizTextImages(
                              subTheme: widget.subTheme,
                              user: widget.user,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          : chances == 0
              ? AlertDialog(
                  // <-- SEE HERE
                  title: const Text('Oh non ...'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: const <Widget>[
                        Text("Tu n'as plus de coeurs :("),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: const Text('Retour'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Accueil'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Réessayer'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizTextImages(
                                  subTheme: widget.subTheme,
                                  user: widget.user,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                )
              : Stack(
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
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Palette.red,
                                          )),
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
                                            Voice.play(reponse[0], 1);
                                          },
                                          width: 100,
                                          heigth: 100,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 70, top: 20),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Button(
                                          content: Image.asset(
                                              "assets/themes_images/snail.png"),
                                          color: Palette.pink,
                                          callback: () {
                                            Voice.play(reponse[0], 0.75);
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
                      child: SizedBox(
                        height: height / 1.9,
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(
                            mots.length,
                            (int index) {
                              String key = mots[index];
                              String value = images[index];
                              return Center(
                                child: Button(
                                  enabled: _isEnabled,
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
                                    setState(() {
                                      didResponse = true;
                                      response = key;
                                    });
                                    if (key == correct) {
                                      Sfx.play("sfx/ding.mp3", 1);
                                      Timer(const Duration(seconds: 1), () {
                                        nextQuestion();
                                        setState(() {
                                          duration = 30;
                                          didResponse = false;
                                        });
                                      });
                                    } else {
                                      Sfx.play("sfx/zew.mp3", 1);
                                      Timer(const Duration(seconds: 1), () {
                                        nextQuestion();
                                        setState(() {
                                          chances -= 1;
                                          duration = 30;
                                          didResponse = false;
                                        });
                                      });
                                    }
                                  },
                                  heigth: width / 2.2,
                                  width: width / 2.2,
                                  radius: 30,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
