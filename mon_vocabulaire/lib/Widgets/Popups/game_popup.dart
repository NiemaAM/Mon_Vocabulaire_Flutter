import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

class GamePopup extends StatelessWidget {
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;
  final bool win;
  final bool tie;
  final bool oneButton;
  final String textWin;
  final String textLose;
  final String loseImg;
  final int price;
  final bool isClicked;

  const GamePopup({
    super.key,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    this.win = true,
    this.oneButton = false,
    this.tie = false,
    this.textWin = "Tu as gagné",
    this.textLose = "Tu as perdu",
    this.loseImg = "assets/images/mascotte/lose.gif",
    required this.price,
    required this.isClicked,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    win && !tie
        ? Sfx.play("audios/sfx/win.mp3", 1)
        : !win && !tie
            ? Sfx.play("audios/sfx/lose.mp3", 1)
            : Sfx.play("audios/sfx/tw.mp3", 1);
    return win && !tie
        ? Dialog(
            insetPadding: EdgeInsets.all(width > 500 ? 100 : 30),
            backgroundColor: Palette.white,
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
                            "Super !",
                            style: TextStyle(
                                fontSize: width > 500 ? 30 : 25.0,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 255, 174, 0)),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            textWin,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: width > 500 ? 20 : 16,
                                color: Palette.black),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 40, right: 40),
                            child:
                                Image.asset("assets/images/mascotte/win2.gif"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              oneButton
                                  ? Button(
                                      enabled: !isClicked,
                                      callback: onButton1Pressed,
                                      content: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Partie suivante",
                                              style: TextStyle(
                                                  color: Palette.white,
                                                  fontSize:
                                                      width > 500 ? 20 : 16,
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
                                      width: width > 500 ? 300 : 200,
                                      color: Palette.lightBlue,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Button(
                                        enabled: !isClicked,
                                        callback: onButton1Pressed,
                                        content: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Expanded(child: SizedBox()),
                                              const Icon(
                                                Icons
                                                    .arrow_back_ios_new_rounded,
                                                color: Palette.white,
                                                size: 20,
                                              ),
                                              Text(
                                                " Retour",
                                                style: TextStyle(
                                                    color: Palette.white,
                                                    fontSize:
                                                        width > 500 ? 20 : 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Expanded(
                                                  flex: 2, child: SizedBox())
                                            ],
                                          ),
                                        ),
                                        width: width > 500
                                            ? width / 3.5
                                            : width / 3,
                                        color: Palette.lightBlue,
                                      ),
                                    ),
                              oneButton
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Button(
                                        enabled: !isClicked,
                                        callback: onButton2Pressed,
                                        content: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Expanded(
                                                  flex: 2, child: SizedBox()),
                                              Text(
                                                "Rejouer ",
                                                style: TextStyle(
                                                    color: Palette.white,
                                                    fontSize:
                                                        width > 500 ? 20 : 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Image.asset(
                                                "assets/images/themes/coin.png",
                                                scale: width >= 700
                                                    ? 16
                                                    : width >= 500
                                                        ? 18
                                                        : 22,
                                              ),
                                              const Expanded(child: SizedBox())
                                            ],
                                          ),
                                        ),
                                        width: width > 500
                                            ? width / 3.5
                                            : width / 3,
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
                      color: Palette.white,
                    ),
                    child: Center(
                      child: Container(
                        width: 115.0,
                        height: 115.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(
                              232, 255, 214, 33), // Replace with desired color
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.star_rounded,
                            color: Color.fromARGB(234, 255, 174, 0),
                            size: 110,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : !win && !tie
            ? Dialog(
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
                                "Oh non",
                                style: TextStyle(
                                    fontSize: width > 500 ? 30 : 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.red),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                textLose,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: width > 500 ? 20 : 16,
                                    color: Palette.black),
                              ),
                              const SizedBox(height: 10.0),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: loseImg ==
                                            "assets/images/mascotte/lose.gif"
                                        ? 40
                                        : 0,
                                    right: loseImg ==
                                            "assets/images/mascotte/lose.gif"
                                        ? 40
                                        : 0),
                                child: Image.asset(
                                  loseImg,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(),
                                  oneButton
                                      ? Button(
                                          enabled: !isClicked,
                                          callback: onButton1Pressed,
                                          content: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Partie suivante",
                                                  style: TextStyle(
                                                      color: Palette.white,
                                                      fontSize:
                                                          width > 500 ? 20 : 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Palette.white,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          width: width > 500 ? 300 : 200,
                                          color: Palette.lightBlue,
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Button(
                                            enabled: !isClicked,
                                            callback: onButton1Pressed,
                                            content: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  const Icon(
                                                    Icons
                                                        .arrow_back_ios_new_rounded,
                                                    color: Palette.white,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    " Retour",
                                                    style: TextStyle(
                                                        color: Palette.white,
                                                        fontSize: width > 500
                                                            ? 20
                                                            : 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Expanded(
                                                      flex: 2,
                                                      child: SizedBox())
                                                ],
                                              ),
                                            ),
                                            width: width > 500
                                                ? width / 3.5
                                                : width / 3,
                                            color: Palette.lightBlue,
                                          ),
                                        ),
                                  oneButton
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Button(
                                            enabled: !isClicked,
                                            callback: onButton2Pressed,
                                            content: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Expanded(
                                                      flex: 2,
                                                      child: SizedBox()),
                                                  Text(
                                                    "Rejouer ",
                                                    style: TextStyle(
                                                        color: Palette.white,
                                                        fontSize: width > 500
                                                            ? 20
                                                            : 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Image.asset(
                                                    "assets/images/themes/coin.png",
                                                    scale: width >= 700
                                                        ? 16
                                                        : width >= 500
                                                            ? 18
                                                            : 22,
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox())
                                                ],
                                              ),
                                            ),
                                            width: width > 500
                                                ? width / 3.5
                                                : width / 3,
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
                          color: Palette.white,
                        ),
                        child: Center(
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.red, // Replace with desired color
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.heart_broken_rounded,
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
              )
            : Dialog(
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
                                "Égalité !",
                                style: TextStyle(
                                    fontSize: width > 500 ? 30 : 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Palette.lightBlue),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Tu y étais presque",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: width > 500 ? 20 : 16,
                                    color: Palette.black),
                              ),
                              const SizedBox(height: 10.0),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 40, right: 40),
                                child: Image.asset(
                                    "assets/images/mascotte/win3.gif"),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const SizedBox(),
                                  oneButton
                                      ? Button(
                                          enabled: !isClicked,
                                          callback: onButton1Pressed,
                                          content: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Partie suivante",
                                                  style: TextStyle(
                                                      color: Palette.white,
                                                      fontSize:
                                                          width > 500 ? 20 : 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  color: Palette.white,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                          width: width > 500 ? 300 : 200,
                                          color: Palette.lightBlue,
                                        )
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Button(
                                            enabled: !isClicked,
                                            callback: onButton1Pressed,
                                            content: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Expanded(
                                                      child: SizedBox()),
                                                  const Icon(
                                                    Icons
                                                        .arrow_back_ios_new_rounded,
                                                    color: Palette.white,
                                                    size: 20,
                                                  ),
                                                  Text(
                                                    " Retour",
                                                    style: TextStyle(
                                                        color: Palette.white,
                                                        fontSize: width > 500
                                                            ? 20
                                                            : 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const Expanded(
                                                      flex: 2,
                                                      child: SizedBox())
                                                ],
                                              ),
                                            ),
                                            width: width > 500
                                                ? width / 3.5
                                                : width / 3,
                                            color: Palette.lightBlue,
                                          ),
                                        ),
                                  oneButton
                                      ? const SizedBox()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Button(
                                            enabled: !isClicked,
                                            callback: onButton2Pressed,
                                            content: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Expanded(
                                                      flex: 2,
                                                      child: SizedBox()),
                                                  Text(
                                                    "Rejouer ",
                                                    style: TextStyle(
                                                        color: Palette.white,
                                                        fontSize: width > 500
                                                            ? 20
                                                            : 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Image.asset(
                                                    "assets/images/themes/coin.png",
                                                    scale: width >= 700
                                                        ? 16
                                                        : width >= 500
                                                            ? 18
                                                            : 22,
                                                  ),
                                                  const Expanded(
                                                      child: SizedBox())
                                                ],
                                              ),
                                            ),
                                            width: width > 500
                                                ? width / 3.5
                                                : width / 3,
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
                          color: Palette.white,
                        ),
                        child: Center(
                          child: Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette
                                  .lightBlue, // Replace with desired color
                            ),
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Icon(
                                  Icons.drag_handle,
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
