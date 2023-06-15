// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

class QuizPopup extends StatefulWidget {
  final VoidCallback onButton1Pressed;
  final VoidCallback onButton2Pressed;
  final VoidCallback onButton3Pressed;
  final int chances;
  final double timer;
  final User user;
  final int subThemeId;
  final int words;
  final int quiz;
  final int part;

  const QuizPopup({
    super.key,
    required this.onButton1Pressed,
    required this.onButton2Pressed,
    required this.onButton3Pressed,
    required this.chances,
    required this.timer,
    required this.user,
    required this.subThemeId,
    this.words = 10,
    required this.quiz,
    required this.part,
  });

  @override
  State<QuizPopup> createState() => _QuizPopupState();
}

class _QuizPopupState extends State<QuizPopup> {
  int quiz = -1;
  bool finished = false;

  getQuiz() async {
    int _quiz =
        await DatabaseHelper().getQuiz(widget.user.id!, widget.subThemeId);
    bool _finished =
        await DatabaseHelper().getFinished(widget.user.id!, widget.subThemeId);
    setState(() {
      quiz = _quiz;
      finished = _finished;
    });
    if (quiz != -1) {
      addCoinsWordsStars();
      updatePart();
    }
  }

  void addCoinsWordsStars() {
    if (widget.chances == 0) {
      Sfx.play("audios/sfx/lose.mp3", 1);
    }
    if (widget.chances == 1) {
      Sfx.play("audios/sfx/win.mp3", 1);
      DatabaseHelper().addCoins(widget.user.id!, 5);
    }
    if (widget.chances == 2) {
      Sfx.play("audios/sfx/win.mp3", 1);
      DatabaseHelper().addCoins(widget.user.id!, 10);
    }
    if (widget.chances == 3) {
      Sfx.play("audios/sfx/win.mp3", 1);
      DatabaseHelper().addCoins(widget.user.id!, 15);
      DatabaseHelper().addStars(widget.user.id!, widget.subThemeId, 1);
    }
    if (widget.chances > 0 && widget.quiz == 3 && !finished) {
      DatabaseHelper()
          .addWords(widget.user.id!, widget.words, widget.subThemeId);
    }
  }

  void updatePart() {
    if (widget.chances > 0) {
      if (widget.quiz == 1 && quiz <= 1) {
        DatabaseHelper().updateQuiz(widget.user.id!, widget.subThemeId, 2);
      }
      if (widget.quiz == 2 && quiz <= 2) {
        DatabaseHelper().updateQuiz(widget.user.id!, widget.subThemeId, 3);
      }
      if (widget.quiz == 3) {
        if (widget.subThemeId == 1 ||
            widget.subThemeId == 3 ||
            widget.subThemeId == 12) {
          if (widget.part == 1) {
            DatabaseHelper().updatePart(widget.user.id!, widget.subThemeId, 2);
            DatabaseHelper().updateQuiz(widget.user.id!, widget.subThemeId, 0);
          }
          if (widget.part == 2) {
            DatabaseHelper().updatePart(widget.user.id!, widget.subThemeId, 3);
            DatabaseHelper().updateQuiz(widget.user.id!, widget.subThemeId, 0);
          }
          if (widget.part == 3) {
            DatabaseHelper()
                .updateFinished(widget.user.id!, widget.subThemeId, true);
          }
        }
        if (widget.subThemeId == 6 ||
            widget.subThemeId == 7 ||
            widget.subThemeId == 8 ||
            widget.subThemeId == 9 ||
            widget.subThemeId == 10) {
          if (widget.part == 1) {
            DatabaseHelper().updatePart(widget.user.id!, widget.subThemeId, 2);
            DatabaseHelper().updateQuiz(widget.user.id!, widget.subThemeId, 0);
          }
          if (widget.part == 2) {
            DatabaseHelper()
                .updateFinished(widget.user.id!, widget.subThemeId, true);
          }
        }
        if (widget.subThemeId == 2 ||
            widget.subThemeId == 4 ||
            widget.subThemeId == 5 ||
            widget.subThemeId == 11) {
          if (widget.part == 1) {
            DatabaseHelper()
                .updateFinished(widget.user.id!, widget.subThemeId, true);
          }
        }
      }
    }
  }

  @override
  void initState() {
    if (widget.chances > 0) {
      getQuiz();
    }
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return quiz == -1 && widget.chances > 0
        ? const Center(
            child: CircularProgressIndicator(
              color: Palette.lightBlue,
            ),
          )
        : widget.chances == 3
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
                          Positioned(
                            right: 0,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/themes/coin.png",
                                  width: 40,
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "+15",
                                    style: TextStyle(
                                        color: Palette.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                              left: 0,
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    color: Palette.lightBlue,
                                    size: 40,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      widget.timer < 60
                                          ? "${widget.timer.toInt()} sec"
                                          : "${(widget.timer ~/ 60).toInt()} min",
                                      style: const TextStyle(
                                          color: Palette.lightBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  )
                                ],
                              )),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 60.0),
                              Text(
                                "Excellent !",
                                style: TextStyle(
                                    fontSize: width > 500 ? 30 : 20.0,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        const Color.fromARGB(255, 255, 174, 0)),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "Tu es un champion",
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
                                    "assets/images/mascotte/win.gif"),
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Button(
                                      callback: widget.onButton1Pressed,
                                      content: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  fontSize:
                                                      width > 500 ? 20 : 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      width:
                                          width > 500 ? width / 3.5 : width / 3,
                                      color: Palette.lightBlue,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Button(
                                      callback: widget.onButton2Pressed,
                                      content: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Suivant ",
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
                                      width:
                                          width > 500 ? width / 3.5 : width / 3,
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
                              color: Color.fromARGB(232, 255, 214,
                                  33), // Replace with desired color
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
            : widget.chances == 2
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
                              Positioned(
                                right: 0,
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/themes/coin.png",
                                      width: 40,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(
                                        "+10",
                                        style: TextStyle(
                                            color: Palette.orange,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  child: Column(
                                    children: [
                                      const Icon(
                                        Icons.timer_outlined,
                                        color: Palette.lightBlue,
                                        size: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          widget.timer < 60
                                              ? "${widget.timer.toInt()} sec"
                                              : "${(widget.timer ~/ 60).toInt()} min",
                                          style: const TextStyle(
                                              color: Palette.lightBlue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      )
                                    ],
                                  )),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 60.0),
                                  Text(
                                    "Bien!",
                                    style: TextStyle(
                                        fontSize: width > 500 ? 30 : 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.darkGrey),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "Bel effort",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: width > 500 ? 20 : 16,
                                        color: Palette.black),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: Image.asset(
                                        "assets/images/mascotte/win2.gif"),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5),
                                        child: Button(
                                          callback: widget.onButton1Pressed,
                                          content: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
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
                                              ],
                                            ),
                                          ),
                                          width: width > 500
                                              ? width / 3.5
                                              : width / 3,
                                          color: Palette.lightBlue,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Button(
                                          callback: widget.onButton2Pressed,
                                          content: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Expanded(
                                                    flex: 2, child: SizedBox()),
                                                Text(
                                                  "Suivant ",
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
                              color:
                                  Palette.white, // Replace with desired color
                            ),
                            child: Center(
                              child: Container(
                                width: 115.0,
                                height: 115.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Palette
                                      .grey, // Replace with desired color
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.star_rounded,
                                    color: Palette.lightGrey,
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
                : widget.chances == 1
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
                                  Positioned(
                                    right: 0,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/themes/coin.png",
                                          width: 40,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "+5",
                                            style: TextStyle(
                                                color: Palette.orange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      left: 0,
                                      child: Column(
                                        children: [
                                          const Icon(
                                            Icons.timer_outlined,
                                            color: Palette.lightBlue,
                                            size: 40,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              widget.timer < 60
                                                  ? "${widget.timer.toInt()} sec"
                                                  : "${(widget.timer ~/ 60).toInt()} min",
                                              style: const TextStyle(
                                                  color: Palette.lightBlue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      )),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 60.0),
                                      Text(
                                        "Assez Bien",
                                        style: TextStyle(
                                            fontSize: width > 500 ? 30 : 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Palette.darkGrey),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "Tu peux faire mieux",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: width > 500 ? 20 : 16,
                                            color: Palette.black),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40),
                                        child: Image.asset(
                                            "assets/images/mascotte/win3.gif"),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 5),
                                            child: Button(
                                              callback: widget.onButton1Pressed,
                                              content: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
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
                                                  ],
                                                ),
                                              ),
                                              width: width > 500
                                                  ? width / 3.5
                                                  : width / 3,
                                              color: Palette.lightBlue,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Button(
                                              callback: widget.onButton2Pressed,
                                              content: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Suivant ",
                                                      style: TextStyle(
                                                          color: Palette.white,
                                                          fontSize: width > 500
                                                              ? 20
                                                              : 16,
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
                                  color: Palette
                                      .white, // Replace with desired color
                                ),
                                child: Center(
                                  child: Container(
                                    width: 120.0,
                                    height: 120.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette
                                          .grey, // Replace with desired color
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.star_rounded,
                                        color: Palette.lightGrey,
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
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 60.0),
                                  Text(
                                    "Oh non",
                                    style: TextStyle(
                                        fontSize: width > 500 ? 30 : 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Palette.red),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(
                                    "Tu as perdu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: width > 500 ? 20 : 16,
                                        color: Palette.black),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 40, right: 40),
                                    child: Image.asset(
                                        "assets/images/mascotte/lose.gif"),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Button(
                                        callback: widget.onButton3Pressed,
                                        content: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Réviser ma leçon  ",
                                                style: TextStyle(
                                                    color: Palette.white,
                                                    fontSize:
                                                        width > 500 ? 20 : 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const Icon(
                                                Icons.menu_book_rounded,
                                                color: Palette.white,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                        width: width > 500 ? 300 : 200,
                                        color: Palette.lightBlue,
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
                                  color: Palette
                                      .white, // Replace with desired color
                                ),
                                child: Center(
                                  child: Container(
                                    width: 120.0,
                                    height: 120.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Palette
                                          .red, // Replace with desired color
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
                      );
  }
}
