import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

class DonePopup extends StatelessWidget {
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;

  const DonePopup({
    super.key,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Sfx.play("audios/sfx/done.mp3", 1);
    return Dialog(
      insetPadding: EdgeInsets.all(width > 500 ? 100 : 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    Text(
                      "Términé !",
                      style: TextStyle(
                          fontSize: width > 500 ? 30 : 25.0,
                          fontWeight: FontWeight.bold,
                          color: Palette.lightGreen),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "Tu as terminé la leçon",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width > 500 ? 20 : 16,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Button(
                            callback: onButton1Pressed,
                            content: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Palette.white,
                                    size: 20,
                                  ),
                                  Text(
                                    " Retour",
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontSize: width > 500 ? 20 : 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            width: width > 500 ? width / 3.5 : width / 3,
                            color: Palette.lightBlue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Button(
                            callback: onButton2Pressed,
                            content: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Suivant ",
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontSize: width > 500 ? 20 : 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Palette.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            width: width > 500 ? width / 3.5 : width / 3,
                            color: Palette.lightGreen,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: -65.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: 130.0,
              height: 130.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Palette.white, // Replace with desired color
              ),
              child: Center(
                child: Container(
                  width: 115.0,
                  height: 115.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Palette.lightGreen, // Replace with desired color
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Palette.white,
                      size: 110,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
