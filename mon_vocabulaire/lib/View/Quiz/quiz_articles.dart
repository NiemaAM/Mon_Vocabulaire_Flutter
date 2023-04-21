import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';

import '../../Widgets/button.dart';
import '../../Widgets/end_popup.dart';
import '../../Widgets/palette.dart';
import '../../Widgets/quiz_app_bar.dart';

class QuizArticles extends StatefulWidget {
  final User user;
  const QuizArticles({super.key, required this.user});

  @override
  State<QuizArticles> createState() => _QuizArticlesState();
}

class _QuizArticlesState extends State<QuizArticles> {
  final bool _isEnabled = true;
  Color color = Palette.lightGrey;
  Color color2 = Palette.lightGrey;
  int chances = 3;
  Map<String, String> data = {
    "Foulard": "assets/images/184.png",
    "B": "assets/images/185.png",
    "C": "assets/images/186.png",
    "D": "assets/images/187.png"
  };
  String correct = 'Foulard';

  void song() async {}

//TODO: change this
  void call() {
    setState(() {
      color = Palette.darkGreen;
      color2 = Palette.lightRed;
    });
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
              chances: chances, user: widget.user, question: 0, size: 0)),
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
                                  song();
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
                                color: Colors.pink,
                                callback: song,
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
                  data.length,
                  (int index) {
                    String key = data.keys.elementAt(index);
                    String value = data[key]!;
                    return Center(
                      child: Button(
                        enabled: _isEnabled,
                        content: Image.asset(value),
                        color: Palette.white,
                        callback: () {
                          if (key == correct) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const EndPopup();
                                });
                          } else {
                            if (chances == 0) {
                              setState(() {
                                chances = 3; //TODO: chage this to popup
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
