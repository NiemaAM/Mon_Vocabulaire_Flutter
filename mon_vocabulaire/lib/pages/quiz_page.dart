import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/quiz_app_bar.dart';

import '../Widgets/button.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final bool _isEnabled = true;
  Color color = Palette.lightGrey;
  Color color2 = Palette.lightGrey;
  int chances = 3;
  Map<String, String> data = {
    "A": "https://cdn-icons-png.flaticon.com/512/1386/1386975.png",
    "B": "https://cdn-icons-png.flaticon.com/512/2806/2806170.png",
    "C": "https://cdn-icons-png.flaticon.com/512/2300/2300218.png",
    "D": "https://cdn-icons-png.flaticon.com/512/2806/2806186.png"
  };
  String correct = 'A';

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
          elevation: 0,
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          title: QuizAppBar(chances: chances)),
      body: Stack(
        children: [
          Stack(
            children: [
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Container(
                  height: height / 1.45,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Palette.indigo,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100)),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.topCenter,
                child: SizedBox(
                  height: height / 1.9,
                  child: Center(
                      child: Text(
                    correct,
                    style: const TextStyle(color: Palette.white, fontSize: 30),
                  )),
                ),
              ),
              Center(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Button(
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
                              Button(
                                content: Image.network(
                                    "https://cdn-icons-png.flaticon.com/512/6024/6024384.png"),
                                color: Palette.pink,
                                callback: song,
                                heigth: 35,
                                width: 35,
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
              height: height / 1.8,
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
                        color: color,
                        callback: () {
                          if (key == correct) {
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
                        heigth: width / 2.3,
                        width: width / 2.3,
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
