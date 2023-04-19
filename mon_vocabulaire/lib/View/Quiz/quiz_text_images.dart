import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/audio_BK.dart';
import 'package:mon_vocabulaire/Model/quiz_model.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/quiz_app_bar.dart';
import '../../Model/audio_player.dart';
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
      if (mounted) {
        setState(() {
          if (duration > 0) {
            duration -= 1; // decrement the duration every second
          } else {
            timer.cancel(); // stop the timer when the duration reaches 0
            testGetRandomWords(); // execute the function after the timer is done
            duration = 30;
            startTimer();
          }
        });
      }
    });
  }

  QuizModel quizModel = QuizModel();
  List<String> images = [];
  List<String> mots = [];
  List<String> reponse = [];
  testGetRandomWords() async {
    await quizModel.getRandomWords(theme, subTheme);
    List<String> _images = quizModel
        .getPropositionImages()
        .map((element) => element.toString())
        .toList();
    List<String> _mots = quizModel
        .getProposition()
        .map((element) => element.toString())
        .toList();
    List<String> _reponse =
        quizModel.getReponse().map((element) => element.toString()).toList();
    setState(() {
      images = _images;
      mots = _mots;
      reponse = _reponse;
      correct = _reponse[3];
    });
  }

  @override
  void initState() {
    super.initState();
    Audio_BK.pauseBK();

    getTheme();
    testGetRandomWords();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: QuizAppBar(
            chances: chances,
            duration: duration,
            user: widget.user,
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
                      decoration: const BoxDecoration(
                        color: Palette.blue,
                        borderRadius: BorderRadius.only(
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
                                  Audio_BK.playBK();
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close)),
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
                                  AudioPlayerHelper.play(reponse, 1);
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
                                    "assets/themes_images/snail.png"),
                                color: Palette.pink,
                                callback: () {
                                  AudioPlayerHelper.play(reponse, 0.6);
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
                        content: Image.asset(
                          value,
                          scale: 5,
                        ),
                        color: Palette.white,
                        callback: () {
                          if (key == correct) {
                            testGetRandomWords();
                            setState(() {
                              duration = 30;
                            });
                          } else {
                            if (chances == 1) {
                              setState(() {
                                chances -= 1;
                              });
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                              child: const Text('Retour'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
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
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizTextImages(
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
                                    );
                                  });
                            } else {
                              setState(() {
                                chances -= 1;
                              });
                            }
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
