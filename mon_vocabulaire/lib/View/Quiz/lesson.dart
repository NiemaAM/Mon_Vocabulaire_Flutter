import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../Widgets/button.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPage();
}

class _LessonPage extends State<LessonPage> {
  int coursbar = 3;
  int chances = 3;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Center(
            child: LinearPercentIndicator(
              width: width - 35,
              animation: true,
              lineHeight: 25.0,
              animationDuration: 1000,
              percent: 0.7,
              barRadius: const Radius.circular(100),
              progressColor: Palette.lightGreen,
              backgroundColor: Palette.lightGrey,
              center: const Text(
                "150/240 mots",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        //fonds container
        body: Stack(children: [
          Stack(
            children: [
              Stack(
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
                    ),
                  ),
                ],
              ),
              //close icon
              Center(
                child: Stack(alignment: Alignment.topCenter, children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close)),
                  ),
                  Stack(
                    children: [
                      Padding(
                        // dis app bar button
                        padding: EdgeInsets.only(top: height / 20),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: width - 100,
                            width: width - 100,
                            decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Palette.lightGrey,
                                  blurRadius: 0,
                                  offset: Offset(0, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Image.asset(
                                'assets/images/135.png',
                                scale: 3,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: width / 3,
                        left: 20,
                        child: Button(
                          content: const Icon(
                            Icons.chevron_left_rounded,
                            color: Palette.white,
                            size: 40,
                          ),
                          color: Palette.pink,
                          callback: () {},
                          heigth: 60,
                          width: 60,
                        ),
                      ),
                      Positioned(
                        top: width / 3,
                        right: 20,
                        child: Button(
                          content: const Icon(
                            Icons.chevron_right_rounded,
                            color: Palette.white,
                            size: 40,
                          ),
                          color: Palette.pink,
                          callback: () {},
                          heigth: 60,
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 2.5),
                      child: Stack(
                        children: [
                          Container(
                            height: width - 150,
                            width: width - 80,
                            decoration: const BoxDecoration(
                              color: Palette.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Palette.lightGrey,
                                  blurRadius: 0,
                                  offset: Offset(0, 8), // Shadow position
                                ),
                              ],
                            ),
                            child: Align(
                                alignment: const Alignment(0.01, 0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Text(
                                        "(Nom,Masculin,Singulier)",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Un chien",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "/...../",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 10),
                    child: Align(
                      alignment: Alignment.center,
                      child: Button(
                        color: Palette.pink,
                        content: const Icon(
                          Icons.volume_up,
                          color: Palette.white,
                          size: 50,
                        ),
                        callback: () {},
                        width: 100,
                        heigth: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70, top: height / 5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Button(
                        content: Image.asset("assets/themes_images/snail.png"),
                        color: Palette.blue,
                        callback: () {},
                        heigth: 35,
                        width: 35,
                      ),
                    ),
                  ),
                ]),
              )
            ],
          )
        ]));
  }
}
