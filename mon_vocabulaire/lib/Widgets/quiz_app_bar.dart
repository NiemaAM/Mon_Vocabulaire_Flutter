import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class QuizAppBar extends StatefulWidget {
  final int chances;
  const QuizAppBar({super.key, required this.chances});

  @override
  State<QuizAppBar> createState() => _QuizAppBarState();
}

class _QuizAppBarState extends State<QuizAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              "3/15",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10, left: 0, right: 0),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Palette.magenta,
                valueColor: AlwaysStoppedAnimation<Color>(Palette.blue),
                minHeight: 10,
              ),
            ),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(
                            right: 5), // add right margin of 10 pixels
                        child: widget.chances >= 1
                            ? const Icon(
                                Icons.favorite,
                                color: Palette.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Palette.grey,
                              )),
                    Container(
                        margin: const EdgeInsets.only(
                            right: 5), // add right margin of 10 pixels
                        child: widget.chances >= 2
                            ? const Icon(
                                Icons.favorite,
                                color: Palette.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Palette.grey,
                              )),
                    Container(
                        margin: const EdgeInsets.only(
                            right: 5), // add right margin of 10 pixels
                        child: widget.chances == 3
                            ? const Icon(
                                Icons.favorite,
                                color: Palette.red,
                              )
                            : const Icon(
                                Icons.favorite,
                                color: Palette.grey,
                              )),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Row(
                  children: [
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
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
