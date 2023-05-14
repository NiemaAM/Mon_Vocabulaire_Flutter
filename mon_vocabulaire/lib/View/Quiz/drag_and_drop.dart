import 'dart:async';

import 'package:confetti/confetti.dart';
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
        setState(() {
          theme = 'Sports et loisirs';
          subTheme = 'Loisirs';
        });
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

  bool first = true;
  getQuestions() async {
    List<PropositionLettres> quest =
        await quizModel.getRandomPropositionsLettres(theme, subTheme);
    setState(() {
      questions = quest;
    });
    setState(() {
      if (quizModel.getSize() >= 10) {
        size = 9;
      } else {
        size = quizModel.getSize() - 1;
      }
    });
    nextQuestion();
  }

  nextQuestion() {
    if (first) {
      clear();
      setState(() {
        reponse = questions[index]
            .reponse
            .map((element) => element.toString())
            .toList();
        correct = questions[index].lettresReponse;
        question = questions[index].lettresQuestion;
        propositions = questions[index].lettresProposition;
        first = false;
        if (isCorrect) {
          nextQuestion();
        }
      });
      Voice.play(reponse[0], 1);
    } else if (index < size) {
      clear();
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
      Voice.play(reponse[0], 1);
    }
  }

  int duration = 30;
  int time = 30;
  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (duration > 0) {
          duration -= 1; // decrement the duration every second
          time += 1;
        } else if (chances > 0) {
          timer.cancel(); // stop the timer when the duration reaches 0
          nextQuestion(); // execute the function after the timer is done
          duration = 30;
          startTimer();
        }
        if (chances == 0 || quizEnded) {
          duration = 0;
        }
      });
    });
  }

  void endQuiz() {
    if (index == size && chances != 0) {
      setState(() {
        quizEnded = true;
      });
      Timer(const Duration(seconds: 1), () {
        Sfx.play("audios/sfx/win.mp3", 1);
      });
      _controllerConfetti.play();
    } else if (chances == 0) {
      setState(() {
        quizEnded = true;
      });
      Timer(const Duration(seconds: 1), () {
        Sfx.play("audios/sfx/lose.mp3", 1);
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
            question: index >= size ? size + 1 : index + 1,
            size: size + 1,
          )),
      body: Stack(
        children: [
          //le fond
          Align(
              alignment: AlignmentDirectional.bottomEnd,
              child:
                  Stack(alignment: AlignmentDirectional.bottomEnd, children: [
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
                            onPressed: () {},
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
                            enabled: !quizEnded,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70, top: height / 2.7),
                        child: Align(
                          alignment: Alignment.center,
                          child: Button(
                            content:
                                Image.asset("assets/images/themes/snail.png"),
                            color: Palette.blue,
                            callback: () {
                              Voice.play(reponse[0], 0.65);
                            },
                            heigth: 35,
                            width: 35,
                            enabled: !quizEnded,
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
                  child: Padding(
                padding: EdgeInsets.only(
                  left: width / 3.5,
                  right: width / 3.5,
                ),
                child: Image.asset(
                  reponse[1],
                ),
              ))),

          // Le Mot
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: height / 3.5, left: 10, right: 10),
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          question.length <= 10 ? question.length : 10,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: question.length,
                  itemBuilder: (BuildContext context, int index) {
                    return DragTarget(
                      onAccept: (receivedItem) {
                        if (!quizEnded) {
                          if (receivedItem.toString() == correct[index]) {
                            if (!quizEnded) {
                              Sfx.play("audios/sfx/plip.mp3", 1);
                            }
                            setState(() {
                              question[index] = correct[index];
                            });
                          } else {
                            if (!quizEnded) {
                              Sfx.play("audios/sfx/zew.mp3", 1);
                            }
                            setState(() {
                              chances -= 1;
                            });
                            endQuiz();
                          }
                          if (!question.contains("??")) {
                            endQuiz();
                            setState(() {
                              isCorrect = true;
                              duration = 30;
                            });
                            if (!quizEnded) {
                              Timer(const Duration(milliseconds: 1000), () {
                                Sfx.play("audios/sfx/ding.mp3", 1);
                              });
                            }
                            Timer(const Duration(seconds: 1), () {
                              setState(() {
                                isCorrect = false;
                              });
                              nextQuestion();
                            });
                          }
                        }
                      },
                      onWillAccept: (receivedItem) {
                        return true;
                      },
                      onLeave: (receivedItem) {},
                      builder: (context, acceptedItems, rejectedItems) =>
                          ContainerLetter(
                        lettre: question[index] == "??" ? "" : question[index],
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
