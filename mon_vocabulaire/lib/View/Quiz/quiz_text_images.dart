import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/quiz_app_bar.dart';

import '../../Widgets/button.dart';
import '../end_game.dart';

class QuizTextImages extends StatefulWidget {
  const QuizTextImages({super.key});

  @override
  State<QuizTextImages> createState() => _QuizTextImagesState();
}

class _QuizTextImagesState extends State<QuizTextImages> {
  final bool _isEnabled = true;
  Color color = Palette.lightGrey;
  Color color2 = Palette.lightGrey;
  int chances = 3;
  Map<String, String> data = {
    "Foulard": "https://cdn-icons-png.flaticon.com/512/2507/2507657.png",
    "B": "https://cdn-icons-png.flaticon.com/512/2806/2806170.png",
    "C": "https://cdn-icons-png.flaticon.com/512/2300/2300218.png",
    "D": "https://cdn-icons-png.flaticon.com/512/2806/2806186.png"
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
          title: QuizAppBar(chances: chances)),
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
                        color: Colors.blueAccent,
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
                                icon: const Icon(Icons.close)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Align(
                              alignment: Alignment.center,
                              child: Button(
                                color: Colors.blueAccent,
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
                                content: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/6024/6024384.png"),
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
                        content: Image.network(value),
                        color: Palette.white,
                        callback: () {
                          if (key == correct) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EndGame(
                                    titre: "Bien joué !",
                                    faute: false,
                                  ),
                                ));
                          } else {
                            if (chances == 1) {
                              setState(() {
                                //chances = 3; //TODO: chage this to popup
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EndGame(
                                        titre: "Jeu terminée !",
                                        faute: true,
                                      ),
                                    ));
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
