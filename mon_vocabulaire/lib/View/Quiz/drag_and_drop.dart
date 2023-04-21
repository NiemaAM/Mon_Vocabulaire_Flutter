import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/quiz_prposition_lettres.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import '../../Model/quiz_model.dart';
import '../../Services/audio_background.dart';
import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/button.dart';
import '../../Widgets/container_letter.dart';
import '../../Widgets/quiz_app_bar.dart';

class DragAndDrop extends StatefulWidget {
  final int subTheme;
  final User user;
  const DragAndDrop({super.key, required this.user, required this.subTheme});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  int chances = 3;
  String theme = '';
  String subTheme = '';
  QuizModel quizModel = QuizModel();
  List<PropositionLettres> questions = [];
  List<String> reponse = [];
  List<String> correct = [];
  List<String> question = [];
  List<String> propositions = [];
  bool isCorrect = false;
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

  clear() {
    setState(() {
      question.clear();
      propositions.clear();
      reponse.clear();
      correct.clear();
    });
  }

  getQuestions() async {
    List<PropositionLettres> quest =
        await quizModel.getRandomPropositionsLettres(theme, subTheme);
    setState(() {
      questions = quest;
    });
    setState(() {
      size = quizModel.getSize();
    });
    nextQuestion();
  }

  nextQuestion() async {
    clear();
    if (index == 0) {
      setState(() {
        reponse = questions[index]
            .reponse
            .map((element) => element.toString())
            .toList();
        correct = questions[index].lettresReponse;
        question = questions[index].lettresQuestion;
        propositions = questions[index].lettresProposition;
        index += 1;
      });
    } else if (index < size) {
      setState(() {
        index += 1;
        reponse = questions[index]
            .reponse
            .map((element) => element.toString())
            .toList();
        correct = questions[index].lettresReponse;
        question = questions[index].lettresQuestion;
        propositions = questions[index].lettresProposition;
      });
    }
  }

  int duration = 30;
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration > 0) {
          duration -= 1;
        } else {
          timer.cancel();
          nextQuestion();
          duration = 30;
          startTimer();
        }
        if (index == size || chances == 0) {
          duration = 0;
        }
      });
    });
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
                      },
                    ),
                    TextButton(
                      child: const Text('Réessayer'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DragAndDrop(
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
                                builder: (context) => DragAndDrop(
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
                    //le fond
                    Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                height: height / 2.2,
                                width: width,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      topRight: Radius.circular(100)),
                                ),
                              ),
                            ])),
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
                                  padding: EdgeInsets.only(top: height / 2.7),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Button(
                                      color: Palette.pink,
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
                                  padding: EdgeInsets.only(
                                      left: 70, top: height / 2.7),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Button(
                                      content: Image.asset(
                                          "assets/themes_images/snail.png"),
                                      color: Palette.blue,
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

                    //l'image
                    Positioned(
                        top: -height * 0.5,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                            child: Image.asset(
                          reponse[1],
                          scale: 3,
                        ))),

                    // Le Mot
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: height / 3.5, left: 10, right: 10),
                        child: Center(
                          child: GridView.builder(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: question.length <= 3
                                    ? 110
                                    : question.length <= 4
                                        ? 90
                                        : question.length <= 5
                                            ? 70
                                            : question.length <= 6
                                                ? 50
                                                : question.length <= 7
                                                    ? 30
                                                    : question.length <= 8
                                                        ? 10
                                                        : 0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: question.length <= 10
                                        ? question.length
                                        : 10,
                                    childAspectRatio: 1,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: question.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DragTarget(
                                onAccept: (receivedItem) {
                                  if (receivedItem.toString() ==
                                      correct[index]) {
                                    Sfx.play("sfx/plip.mp3", 1);
                                    setState(() {
                                      question[index] = correct[index];
                                    });
                                  } else {
                                    Sfx.play("sfx/zew.mp3", 1);
                                    setState(() {
                                      chances -= 1;
                                    });
                                  }
                                  if (!question.contains("??")) {
                                    setState(() {
                                      isCorrect = true;
                                      duration = 30;
                                    });
                                    Timer(const Duration(seconds: 1), () {
                                      Sfx.play("sfx/ding.mp3", 1);
                                    });
                                    Timer(const Duration(seconds: 1), () {
                                      setState(() {
                                        isCorrect = false;
                                      });
                                      nextQuestion();
                                    });
                                  }
                                },
                                onWillAccept: (receivedItem) {
                                  return true;
                                },
                                onLeave: (receivedItem) {},
                                builder:
                                    (context, acceptedItems, rejectedItems) =>
                                        ContainerLetter(
                                  lettre: question[index] == "??"
                                      ? ""
                                      : question[index],
                                  isReponse: false,
                                  color: question[index] == "??"
                                      ? Palette.indigo
                                      : isCorrect
                                          ? Palette.lightGreen
                                          : Palette.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    //les propositions
                    Container(
                      margin: EdgeInsets.only(top: height / 1.5),
                      height: width / 8,
                      width: width,
                      child: Center(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: propositions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Draggable(
                              data: propositions[index],
                              childWhenDragging: Container(),
                              feedback: ContainerLetter(
                                  lettre: propositions[index],
                                  isReponse: true,
                                  color: Palette.pink),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ContainerLetter(
                                      lettre: propositions[index],
                                      isReponse: true,
                                      color: Palette.pink),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
