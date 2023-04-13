import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Widgets/button.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _Course();
}

class _Course extends State<Course> {
  int coursbar = 3;
  int chances = 3;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Row(
            children: [
              LinearPercentIndicator(
                width: width - 100,
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
              const Expanded(child: SizedBox()),
              const Text(
                "20",
                style: TextStyle(
                    color: Palette.indigo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const Expanded(child: SizedBox()),
              Image.asset(
                'assets/themes_images/coin.png',
                scale: 20,
              ),
            ],
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
                  Padding(
                    padding: EdgeInsets.only(top: height / 40),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 34),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 4, 7), fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 18),
                    child: const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 4, 7), fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    // dis app bar button
                    padding: EdgeInsets.only(top: height / 8),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: height / 4.1,
                        width: width / 1.7,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.2),
                          color: Palette.white,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                        child: Image.asset(
                          'assets/images/135.png',
                          fit: BoxFit.contain,
                          scale: 8,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: width / 1.7, top: height / 5.2),
                    child: Button(
                      content: const Icon(
                        Icons.chevron_left,
                        color: Palette.white,
                      ),
                      color: Palette.pink,
                      callback: () {},
                      heigth: 39,
                      width: 39,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 5.2, left: width / 1.7),
                    child: Button(
                      content: const Icon(
                        Icons.chevron_right,
                        color: Palette.white,
                      ),
                      color: Color.fromRGBO(233, 30, 99, 1),
                      callback: () {},
                      heigth: 39,
                      width: 39,
                    ),
                  ),
                  Padding(
                    // dis app bar button
                    padding: const EdgeInsets.only(top: 400),
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            height: height / 4.06,
                            width: width / 1.65,
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Align(
                                alignment: const Alignment(0.01, 0.1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Text(
                                        "(Nom,Masculin,Singulier)",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 4, 7),
                                            fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Un chien",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 4, 7),
                                            fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        "/...../",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 4, 7),
                                            fontSize: 20),
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
                    padding: const EdgeInsets.only(top: 200),
                    child: Align(
                      alignment: Alignment.center,
                      child: Button(
                        color: Colors.pink,
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
                    padding: const EdgeInsets.only(left: 70, top: 140),
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
