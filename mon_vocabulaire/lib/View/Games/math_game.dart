import 'package:flutter/material.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/button.dart';

class MathGame extends StatefulWidget {
  const MathGame({super.key});

  @override
  State<MathGame> createState() => _MathGameState();
}

class _MathGameState extends State<MathGame> {
  List<int> question = [3, 3, 00];
  List<int> propositions = [6, 4, 9];
  List<String> signs = ["+", "-", "*"];
  List<String> compare = [">", "=", "<"];
  List<Color> colors = [Palette.pink, Palette.blue, Palette.lightGreen];
  int where = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          SizedBox(
            height: height,
            child: Image.asset(
              'assets/images/games/backgrounds/class.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 7, left: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${question[0]}",
                  style: const TextStyle(fontSize: 55, color: Palette.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    signs[0],
                    style: const TextStyle(fontSize: 55, color: Palette.white),
                  ),
                ),
                Text(
                  "${question[1]}",
                  style: const TextStyle(fontSize: 55, color: Palette.white),
                ),
                const Text(
                  " =",
                  style: TextStyle(fontSize: 55, color: Palette.white),
                ),
                DragTarget(
                    onAccept: (receivedItem) {
                      if (question[0] + question[1] ==
                          propositions[where].toInt()) {
                        question[2] = propositions[where].toInt();
                      }
                    },
                    onWillAccept: (receivedItem) {
                      return true;
                    },
                    onLeave: (receivedItem) {},
                    builder: (context, acceptedItems, rejectedItems) => Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: question[2] == 00
                                    ? const Color.fromARGB(255, 6, 76, 5)
                                    : colors[where],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Center(
                              child: Text(
                                question[2] == 00
                                    ? "?"
                                    : "${propositions[where]}",
                                style: const TextStyle(
                                    fontSize: 55, color: Palette.white),
                              ),
                            ),
                          ),
                        )),
              ],
            ),
          ),
          //les propositions
          Padding(
            padding: EdgeInsets.only(top: height / 1.8),
            child: SizedBox(
              height: 120,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: propositions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Draggable(
                      data: propositions[index],
                      childWhenDragging: Container(),
                      feedback: Button(
                        callback: () {
                          setState(() {
                            where == index;
                          });
                        },
                        content: Center(
                            child: Text(
                          "${propositions[index]}",
                          style: const TextStyle(
                              color: Palette.white,
                              fontSize: 55,
                              fontWeight: FontWeight.bold),
                        )),
                        color: colors[index],
                        heigth: 100,
                        width: 100,
                        radius: 20,
                      ),
                      child: Center(
                        child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Button(
                              callback: () {
                                setState(() {
                                  where == index;
                                });
                              },
                              content: Center(
                                  child: Text(
                                "${propositions[index]}",
                                style: const TextStyle(
                                    color: Palette.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold),
                              )),
                              color: colors[index],
                              heigth: 100,
                              width: 100,
                              radius: 20,
                            )),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Button(
        callback: () {
          Navigator.pop(context);
        },
        content: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Palette.white,
          size: 30,
        ),
        width: 70,
        heigth: 70,
        color: const Color.fromARGB(255, 11, 133, 9),
      ),
    );
  }
}
