import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

class AlertPopup extends StatelessWidget {
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;
  final String titre;
  final String description;
  final String button1;
  final String button2;
  final Widget? content;
  final Color textColor;
  final bool buttonOnly;

  const AlertPopup({
    super.key,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    required this.titre,
    required this.description,
    required this.button1,
    required this.button2,
    this.content,
    this.textColor = Palette.black,
    this.buttonOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                      titre,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: width > 500 ? 25 : 20.0,
                          fontWeight: FontWeight.bold,
                          color: Palette.orange),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                    const SizedBox(height: 10.0),
                    content ?? const SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buttonOnly
                            ? Button(
                                callback: onButton1Pressed,
                                content: Center(
                                  child: Text(
                                    " $button1",
                                    style: TextStyle(
                                        color: Palette.white,
                                        fontSize: width > 500 ? 20 : 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                width: width > 500 ? width / 3.5 : width / 3,
                                color: Palette.lightBlue,
                              )
                            : Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Button(
                                  callback: onButton1Pressed,
                                  content: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        const Icon(
                                          Icons.close_rounded,
                                          color: Palette.white,
                                          size: 20,
                                        ),
                                        Text(
                                          " $button1",
                                          style: TextStyle(
                                              color: Palette.white,
                                              fontSize: width > 500 ? 20 : 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Expanded(
                                            flex: 2, child: SizedBox())
                                      ],
                                    ),
                                  ),
                                  width: width > 500 ? width / 3.5 : width / 3,
                                  color: Palette.lightBlue,
                                ),
                              ),
                        buttonOnly
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Button(
                                  callback: onButton2Pressed,
                                  content: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Expanded(
                                            flex: 2, child: SizedBox()),
                                        Text(
                                          "$button2 ",
                                          style: TextStyle(
                                              color: Palette.white,
                                              fontSize: width > 500 ? 20 : 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Icon(
                                          Icons.check_rounded,
                                          color: Palette.white,
                                          size: 20,
                                        ),
                                        const Expanded(child: SizedBox())
                                      ],
                                    ),
                                  ),
                                  width: width > 500 ? width / 3.5 : width / 3,
                                  color: Palette.red,
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
                    color: Palette.orange, // Replace with desired color
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.warning_rounded,
                        color: Palette.white,
                        size: 90,
                      ),
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
