// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/quiz_prposition.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/end_popup.dart';
import 'package:mon_vocabulaire/Widgets/sucess_popup.dart';
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
          ? SucessPopup()
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
                                builder: (context) => QuizImageTexts(
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
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.close,
                                            color: Palette.red,
                                          )),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: height / 10),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Image.asset(
                                            reponse[1],
                                            scale: 3,
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
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 15, right: 15),
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: width / 300,
                            mainAxisSpacing: width / 300,
                            crossAxisSpacing: width / 300,
                            controller:
                                ScrollController(keepScrollOffset: false),
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
                                          enabled: _isEnabled,
                                          content: Center(
                                            child: Text(key,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              Timer(const Duration(seconds: 1),
                                                  () {
                                                nextQuestion();
                                                setState(() {
                                                  duration = 30;
                                                  didResponse = false;
                                                });
                                              });
                                            } else {
                                              Sfx.play("sfx/zew.mp3", 1);
                                              Timer(const Duration(seconds: 1),
                                                  () {
                                                nextQuestion();
                                                setState(() {
                                                  chances -= 1;
                                                  duration = 30;
                                                  didResponse = false;
                                                });
                                              });
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
                  ],
                ),
    );
  }
}
