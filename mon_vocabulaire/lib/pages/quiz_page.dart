import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/custom_clip.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../Widgets/button.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool _isEnabled = true;
  Color color = Palette.lightGrey;
  Color color2 = Palette.lightGrey;
  int chances = 3;

  void checkAnswer(String selectedImage) {
    setState(() {
      color = Palette.darkGreen;
      color2 = Palette.red;
    });

    String correctImage =
        "https://cdn-icons-png.flaticon.com/512/1386/1386975.png"; //image de foulard
    if (selectedImage != correctImage) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Try again !")));
      setState(() {
        chances -= 1;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Correct !")));
    }
  }

  void song() async {}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        elevation: 10,
        shadowColor: Palette.magenta,
        backgroundColor: Palette.pink,
        centerTitle: true,
        title: const Column(
          children: [
            Text("3/15"),
            Text(
              "IMAGES",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    for (int i = 0; i < chances; i++)
                      Container(
                        margin: const EdgeInsets.only(
                            right: 5), // add right margin of 10 pixels
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/833/833472.png',
                          scale: 20,
                        ),
                      ),
                    const Expanded(child: SizedBox()),
                    const Text(
                      "20",
                      style: TextStyle(
                          color: Palette.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/1490/1490850.png',
                      scale: 20,
                    ),
                  ],
                )),
            Stack(alignment: AlignmentDirectional.topEnd, children: [
              Button(
                label: false,
                callback: () {
                  song();
                },
                isImage: false,
                icon: const Icon(
                  Icons.volume_up,
                  color: Palette.white,
                  size: 50,
                ),
                width: 100,
                heigth: 100,
              ),
              Button(
                isImage: true,
                image:
                    "https://cdn-icons-png.flaticon.com/512/6024/6024384.png",
                color: Palette.pink,
                callback: song,
                heigth: 35,
                width: 35,
                label: false,
              ),
            ]),
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 80, 10, 10),
                color: Palette.indigo,
                height: height / 1.45,
                child: Column(children: [
                  const Text(
                    "Foulard",
                    style: TextStyle(
                        fontSize: 30,
                        color: Palette.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Button(
                            enabled: _isEnabled,
                            isImage: true,
                            image:
                                "https://cdn-icons-png.flaticon.com/512/1386/1386975.png",
                            color: color,
                            callback: () {
                              checkAnswer(
                                  "https://cdn-icons-png.flaticon.com/512/1386/1386975.png");
                            },
                            heigth: height / 5,
                            width: width / 2.3,
                            label: false,
                            radius: 30,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Button(
                            enabled: _isEnabled,
                            isImage: true,
                            image:
                                "https://cdn-icons-png.flaticon.com/512/2806/2806170.png",
                            color: color2,
                            callback: () {
                              checkAnswer(
                                  "https://cdn-icons-png.flaticon.com/512/2806/2806170.png");
                            },
                            heigth: height / 5,
                            width: width / 2.3,
                            label: false,
                            radius: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(children: [
                    Expanded(
                      child: Center(
                        child: Button(
                          enabled: _isEnabled,
                          isImage: true,
                          image:
                              "https://cdn-icons-png.flaticon.com/512/2300/2300218.png",
                          color: color2,
                          callback: () {
                            checkAnswer(
                                "https://cdn-icons-png.flaticon.com/512/2300/2300218.png");
                          },
                          heigth: height / 5,
                          width: width / 2.3,
                          label: false,
                          radius: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Button(
                          enabled: _isEnabled,
                          isImage: true,
                          image:
                              "https://cdn-icons-png.flaticon.com/512/2806/2806186.png",
                          color: color2,
                          callback: () {
                            checkAnswer(
                                "https://cdn-icons-png.flaticon.com/512/2806/2806186.png");
                          },
                          heigth: height / 5,
                          width: width / 2.3,
                          label: false,
                          radius: 30,
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            color = Palette.lightGrey;
            color2 = Palette.lightGrey;
            _isEnabled = true;
          });
        },
        tooltip: 'Clear',
        child: const Icon(Icons.minimize_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
