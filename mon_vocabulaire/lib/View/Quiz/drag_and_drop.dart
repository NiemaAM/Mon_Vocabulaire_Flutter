import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';

import '../../Widgets/Palette.dart';
import '../../Widgets/button.dart';
import '../../Widgets/container_letter.dart';
import '../../Widgets/quiz_app_bar.dart';

class DragAndDrop extends StatefulWidget {
  final User user;
  const DragAndDrop({super.key, required this.user});

  @override
  State<DragAndDrop> createState() => _DragAndDropState();
}

class _DragAndDropState extends State<DragAndDrop> {
  int chances = 3;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    bool accepted = false;
    String lettre = "";
    Widget child = const ContainerLetter(
      lettre: "A",
      isReponse: false,
      color: Palette.pink,
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Palette.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: QuizAppBar(
            chances: chances,
            user: widget.user,
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
                  decoration: const BoxDecoration(
                    color: Palette.blue,
                    borderRadius: BorderRadius.only(
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
                            icon: const Icon(Icons.close)),
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
                            callback: () {},
                            width: 100,
                            heigth: 100,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70, top: height / 2.7),
                        child: Align(
                          alignment: Alignment.center,
                          child: Button(
                            content:
                                Image.asset("assets/themes_images/snail.png"),
                            color: Palette.blue,
                            callback: () {},
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
                "assets/images/132.png",
                scale: 3,
              ))),

          // Le Mot
          Padding(
              padding: EdgeInsets.only(top: height / 1.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ContainerLetter(
                    lettre: "U",
                    isReponse: false,
                    color: Palette.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const ContainerLetter(
                    lettre: "N",
                    isReponse: false,
                    color: Palette.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const ContainerLetter(
                    lettre: "C",
                    isReponse: false,
                    color: Palette.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const ContainerLetter(
                    lettre: "H",
                    isReponse: false,
                    color: Palette.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DragTarget(
                    onAccept: (data) {
                      accepted = true;
                      lettre = data.toString();
                    },
                    builder: (context, candidateData, rejectedData) {
                      if (accepted == false) {
                        return const ContainerLetter(
                          lettre: "",
                          isReponse: false,
                          color: Palette.indigo,
                        );
                      } else if (accepted == true && lettre == "A") {
                        return ContainerLetter(
                          lettre: lettre,
                          isReponse: false,
                          isCorrect: true,
                          color: Palette.lightGreen,
                        );
                      } else {
                        return const ContainerLetter(
                          lettre: "...",
                          isReponse: false,
                          color: Palette.indigo,
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const ContainerLetter(
                    lettre: "T",
                    isReponse: false,
                    color: Palette.white,
                  )
                ],
              )),

          //les propositions
          Padding(
            padding: EdgeInsets.only(top: height / 1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Draggable(
                    data: "R",
                    childWhenDragging: Container(),
                    feedback: const ContainerLetter(
                      lettre: "R",
                      isReponse: true,
                      color: Palette.pink,
                    ),
                    child: const ContainerLetter(
                      lettre: "R",
                      isReponse: false,
                      color: Palette.pink,
                    )),
                const Expanded(child: SizedBox()),
                Draggable(
                  data: "A",
                  childWhenDragging: Container(),
                  feedback: const ContainerLetter(
                    lettre: "A",
                    isReponse: true,
                    color: Palette.pink,
                  ),
                  child: child,
                ),
                const Expanded(child: SizedBox()),
                Draggable(
                  data: "U",
                  childWhenDragging: Container(),
                  feedback: const ContainerLetter(
                    lettre: "U",
                    isReponse: true,
                    color: Palette.pink,
                  ),
                  child: const ContainerLetter(
                    lettre: "U",
                    isReponse: false,
                    color: Palette.pink,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Draggable(
                  data: "O",
                  childWhenDragging: Container(),
                  feedback: const ContainerLetter(
                    lettre: "O",
                    isReponse: true,
                    color: Palette.pink,
                  ),
                  child: const ContainerLetter(
                    lettre: "O",
                    isReponse: false,
                    color: Palette.pink,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Draggable(
                    data: "Z",
                    childWhenDragging: Container(),
                    feedback: const ContainerLetter(
                      lettre: "Z",
                      isReponse: true,
                      color: Palette.pink,
                    ),
                    child: const ContainerLetter(
                      lettre: "Z",
                      isReponse: false,
                      color: Palette.pink,
                    )),
                const Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
