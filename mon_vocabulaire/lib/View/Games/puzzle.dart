// ignore_for_file: must_be_immutable, library_private_types_in_public_api, unnecessary_null_comparison

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as image;
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:mon_vocabulaire/Services/voice.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../Widgets/button.dart';

class Puzzle extends StatefulWidget {
  const Puzzle({super.key});
  @override
  _PuzzleState createState() => _PuzzleState();
}

class TimerGame {
  static bool timerOn = true;
  static bool getTimer() {
    return timerOn;
  }

  static void setTimer(bool set) {
    timerOn = set;
  }
}

class _PuzzleState extends State<Puzzle> {
  GlobalKey<_PuzzleWidgetState> globalKey = GlobalKey();
  int duration = 180;
  String image = "assets/images/logo.png";
  String voice = "audios/voices/1.mp3";
  bool isEnd = false;

  void getIamge() {
    int randomNumber = Random().nextInt(233) + 1;
    setState(() {
      image = "assets/images/pics/$randomNumber.png";
      voice = "audios/voices/$randomNumber.mp3";
    });
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (duration > 0 && TimerGame.timerOn) {
        setState(() {
          duration--;
        });
      } else if (TimerGame.timerOn) {
        endGame();
      }
    });
  }

  void endGame() {
    Sfx.play("audios/sfx/lose.mp3", 1);
    TimerGame.setTimer(false);
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      customHeader: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: duration > 0 ? Palette.yellow : Palette.red,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        child: Icon(
          duration > 0 ? Icons.star_rounded : Icons.timer,
          color: Palette.white,
          size: 80,
        ),
      ),
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Oh non, le temps est écoulé !",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Palette.pink,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Tu y étais presque, essaye encore une fois.",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Image.asset(
          "assets/images/mascotte/lose.gif",
          scale: 4,
        ),
      ]),
      btnCancelIcon: Icons.home,
      btnCancelText: " ",
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnOkIcon: Icons.restart_alt_rounded,
      btnOkText: " ",
      btnOkOnPress: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Puzzle(),
          ),
        );
      },
    ).show();
  }

  @override
  void initState() {
    super.initState();
    TimerGame.setTimer(true);
    AudioBK.pauseBK();
    getIamge();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    AudioBK.playBK();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    AudioBK.pauseBK();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/puzzle.png",
              width: 40,
            ),
            const Text(
              "  Puzzle",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        SizedBox(
          height: height,
          child: Image.asset('assets/images/games/backgrounds/puzzlee.jpg',
              alignment: Alignment.center,
              fit: BoxFit.cover,
              color: Palette.white.withOpacity(0.50),
              colorBlendMode: BlendMode.modulate),
        ),
        LinearPercentIndicator(
          padding: const EdgeInsets.all(0),
          animation: true,
          lineHeight: 10,
          animationDuration: 0,
          percent: duration / 180,
          barRadius: const Radius.circular(0),
          progressColor: duration >= 120
              ? Palette.lightGreen
              : duration <= 60
                  ? Palette.red
                  : Palette.orange,
          backgroundColor: Theme.of(context).shadowColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Button(
                color: Palette.blue,
                content: const Icon(
                  Icons.volume_up,
                  color: Palette.white,
                  size: 50,
                ),
                callback: () {
                  Voice.play(voice, 1);
                },
                width: 100,
                heigth: 100,
              ),
            ),
          ],
        ),
        SafeArea(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Container(
              margin: const EdgeInsets.all(60),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SizedBox(
                    width: constraints.biggest.width,
                    child: PuzzleWidget(
                      key: globalKey,
                      size: constraints.biggest,
                      imageBackGround: Image.asset(image),
                      sizePuzzle: 3,
                    ),
                  );
                },
              ),
            ),
          ),
        ]))
      ]),
    );
  }
}

class PuzzleWidget extends StatefulWidget {
  Size size;
  // set inner padding
  double innerPadding;
  // set image use for background
  Image imageBackGround;
  int sizePuzzle;
  PuzzleWidget({
    super.key,
    required this.size,
    this.innerPadding = 0,
    required this.imageBackGround,
    required this.sizePuzzle,
  });

  @override
  _PuzzleWidgetState createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  final GlobalKey _globalKey = GlobalKey();
  late Size size;
// la liste  puzzle objects
  List<PuzzleObject>? puzzleObjects;
  // image load with renderer
  image.Image? fullimage;
  // success flag
  bool success = false;
  bool startSlide = false;
  // save current swap process for reverse checking
  List<int>? process;
  // flag finish swap
  bool finishSwap = false;

  @override
  Widget build(BuildContext context) {
    size = Size(widget.size.width - widget.innerPadding * 2,
        widget.size.width - widget.innerPadding);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              // color: Palette.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: widget.size.width,
            height: widget.size.width,
            padding: EdgeInsets.all(widget.innerPadding),
            child: Stack(children: [
              //  stack our background et puzzle box
              if (puzzleObjects == null) ...[
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: double.maxFinite,
                    child: widget.imageBackGround,
                  ),
                )
              ], //  puzzle with empty case
              if (puzzleObjects != null)
                ...puzzleObjects!
                    .where((puzzleObject) => puzzleObject.empty)
                    .map(
                  (puzzleObject) {
                    return Positioned(
                      left: puzzleObject.posCurrent.dx,
                      top: puzzleObject.posCurrent.dy,
                      child: SizedBox(
                        width: puzzleObject.size.width,
                        height: puzzleObject.size.height,
                        child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(2),
                          color: Colors.white24,
                          child: Stack(
                            children: [
                              if (puzzleObject.image != null) ...[
                                Opacity(
                                  opacity: success ? 1 : 0.3,
                                  child: puzzleObject.image,
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              // this for box with not empty flag
              if (puzzleObjects != null)
                ...puzzleObjects!
                    .where((puzzleObject) => !puzzleObject.empty)
                    .map(
                  (puzzleObject) {
                    return AnimatedPositioned(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.ease,
                        left: puzzleObject.posCurrent.dx,
                        top: puzzleObject.posCurrent.dy,
                        child: GestureDetector(
                          onTap: () =>
                              changePosition(puzzleObject.indexCurrent!),
                          child: SizedBox(
                            width: puzzleObject.size.width,
                            height: puzzleObject.size.height,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(2),
                              child: Stack(
                                children: [
                                  if (puzzleObject.image != null) ...[
                                    puzzleObject.image
                                  ], //les nombres
                                  Center(
                                    child: Opacity(
                                      opacity: success ? 0 : 0.5,
                                      child: Text(
                                        "${puzzleObject.indexDefault}",
                                        style: const TextStyle(
                                            fontSize: 35,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                ).toList()
            ])),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Button(
                content: const Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.play_arrow_rounded,
                      color: Palette.white,
                      size: 25,
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      "Diviser l'image",
                      style: TextStyle(color: Palette.white),
                    ),
                    Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
                color: Palette.pink,
                callback: () => generatePuzzle(),
                heigth: 50,
                width: 150,
              ),
              const Expanded(child: SizedBox()),
              Button(
                content: const Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.image_rounded,
                      color: Palette.white,
                      size: 25,
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      "Voir l'image",
                      style: TextStyle(color: Palette.white),
                    ),
                    Expanded(flex: 2, child: SizedBox()),
                  ],
                ),
                color: Palette.darkGreen,
                callback: () => clearPuzzle(),
                width: 150,
                heigth: 50,
              ),
              const Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }

  //render image
  _getImageFromWidget() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    size = boundary.size;
    var img = await boundary.toImage();
    var byteData = await img.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();

    return image.decodeImage(pngBytes!);
  }

//generate puzzle
  generatePuzzle() async {
    // dclare our array puzzle
    // 1st load render image to crop, we need load just once
    fullimage ??= await _getImageFromWidget();

    // calculate box size for each puzzle
    Size sizeBox =
        Size(size.width / widget.sizePuzzle, size.width / widget.sizePuzzle);

    // let proceed with generate box puzzle
    // power of 2 because we need generate row & column same number
    puzzleObjects =
        List.generate(widget.sizePuzzle * widget.sizePuzzle, (index) {
      // we need setup offset 1st
      Offset offsetTemp = Offset(
        index % widget.sizePuzzle * sizeBox.width,
        index ~/ widget.sizePuzzle * sizeBox.height,
      );
      // set image crop for nice effect, check also if image is null
      image.Image? tempCrop;
      if (fullimage != null) {
        tempCrop = image.copyCrop(
          fullimage!,
          x: offsetTemp.dx.round(),
          y: offsetTemp.dy.round(),
          width: sizeBox.width.round(),
          height: sizeBox.height.round(),
        );
      }
      return PuzzleObject(
        posCurrent: offsetTemp,
        posDefault: offsetTemp,
        indexCurrent: index,
        indexDefault: index + 1,
        size: sizeBox,
        image: tempCrop == null
            // ignore: cast_from_null_always_fails
            ? null as Image
            : Image.memory(
                image.encodePng(tempCrop),
                fit: BoxFit.contain,
              ),
      );
    });
    puzzleObjects!.last.empty = true;
    bool swap = true;
    setState(() {});
    // 20 * size puzzle shuffle
    for (var i = 0; i < widget.sizePuzzle * 20; i++) {
      for (var j = 0; j < widget.sizePuzzle / 2; j++) {
        PuzzleObject puzzleObjectEmpty = getEmptyObject();

        // get index of empty slide object
        int emptyIndex = puzzleObjectEmpty.indexCurrent!;
        // process.add(emptyIndex);
        int randKey;
        if (swap) {
          // horizontal swap
          int row = emptyIndex ~/ widget.sizePuzzle;
          randKey =
              row * widget.sizePuzzle + Random().nextInt(widget.sizePuzzle);
        } else {
          int col = emptyIndex % widget.sizePuzzle;
          randKey =
              widget.sizePuzzle * Random().nextInt(widget.sizePuzzle) + col;
        }
        // call change position method we create before to swap place
        changePosition(randKey);
        swap = !swap;
      }
    }
  }

  // get empty slide object from list
  PuzzleObject getEmptyObject() {
    return puzzleObjects!.firstWhere((element) => element.empty);
  }

  changePosition(int indexCurrent) {
    PuzzleObject puzzleObjectEmpty = getEmptyObject();
    // get index of empty slide object
    int emptyIndex = puzzleObjectEmpty.indexCurrent!;
    // min & max index based on vertical or horizontal
    int minIndex = min(indexCurrent, emptyIndex);
    int maxIndex = max(indexCurrent, emptyIndex);
    // temp list moves involves
    List<PuzzleObject> rangeMoves = [];
    // check if index current from vertical / horizontal line
    if (indexCurrent % widget.sizePuzzle == emptyIndex % widget.sizePuzzle) {
      // same vertical line
      rangeMoves = puzzleObjects!
          .where((element) =>
              element.indexCurrent! % widget.sizePuzzle ==
              indexCurrent % widget.sizePuzzle)
          .toList();
    } else if (indexCurrent ~/ widget.sizePuzzle ==
        emptyIndex ~/ widget.sizePuzzle) {
      rangeMoves = puzzleObjects!;
    } else {
      rangeMoves = [];
    }

    rangeMoves = rangeMoves
        .where((puzzle) =>
            puzzle.indexCurrent! >= minIndex &&
            puzzle.indexCurrent! <= maxIndex &&
            puzzle.indexCurrent != emptyIndex)
        .toList();
    // check empty index under or above current touch
    if (emptyIndex < indexCurrent) {
      rangeMoves.sort((a, b) => a.indexCurrent! < b.indexCurrent! ? 1 : 0);
    } else {
      rangeMoves.sort((a, b) => a.indexCurrent! < b.indexCurrent! ? 0 : 1);
    }
    // check if rangeMOves is exist,, then proceed switch position
    if (rangeMoves.isNotEmpty) {
      int? tempIndex = rangeMoves[0].indexCurrent;
      Offset tempPos = rangeMoves[0].posCurrent;
      for (var i = 0; i < rangeMoves.length - 1; i++) {
        rangeMoves[i].indexCurrent = rangeMoves[i + 1].indexCurrent;
        rangeMoves[i].posCurrent = rangeMoves[i + 1].posCurrent;
      }
      rangeMoves.last.indexCurrent = puzzleObjectEmpty.indexCurrent;
      rangeMoves.last.posCurrent = puzzleObjectEmpty.posCurrent;

      // //setup pos for empty puzzle box..
      puzzleObjectEmpty.indexCurrent = tempIndex;
      puzzleObjectEmpty.posCurrent = tempPos;
    }
    // this to check if all puzzle box already in default place.. can set callback for success later
    if (puzzleObjects![0].indexDefault == puzzleObjects![0].indexCurrent! + 1 &&
        puzzleObjects![1].indexDefault == puzzleObjects![1].indexCurrent! + 1 &&
        puzzleObjects![2].indexDefault == puzzleObjects![2].indexCurrent! + 1 &&
        puzzleObjects![3].indexDefault == puzzleObjects![3].indexCurrent! + 1 &&
        puzzleObjects![4].indexDefault == puzzleObjects![4].indexCurrent! + 1 &&
        puzzleObjects![5].indexDefault == puzzleObjects![5].indexCurrent! + 1 &&
        puzzleObjects![6].indexDefault == puzzleObjects![6].indexCurrent! + 1 &&
        puzzleObjects![7].indexDefault == puzzleObjects![7].indexCurrent! + 1 &&
        puzzleObjects![8].indexDefault == puzzleObjects![8].indexCurrent! + 1 &&
        !finishSwap) {
      success = true;
    } else {
      success = false;
      if (success == true) {
        TimerGame.setTimer(false);
        Sfx.play("audios/sfx/win.mp3", 1);
        AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          customHeader: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                color: Palette.yellow,
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: const Icon(
              Icons.star_rounded,
              color: Palette.white,
              size: 80,
            ),
          ),
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          body: Column(children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Très bon travail !",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Palette.pink,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                "Bravo, tu as une bonne mémoire !",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              "assets/images/mascotte/win.gif",
              scale: 4,
            ),
          ]),
          btnCancelIcon: Icons.home,
          btnCancelText: " ",
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
          btnOkIcon: Icons.restart_alt_rounded,
          btnOkText: " ",
          btnOkOnPress: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Puzzle(),
              ),
            );
          },
        ).show();
      }
      startSlide = true;
      setState(() {});
    }
  }

  clearPuzzle() {
    setState(() {
      // checking already slide for reverse purpose
      puzzleObjects = null;
      finishSwap = true;
      startSlide = true;
    });
  }
}

class PuzzleObject {
  // setup offset for default / current position
  Offset posDefault;
  Offset posCurrent;
  // setup index for default / current position
  int? indexDefault;
  int? indexCurrent;
  // status box is empty
  bool empty;
  // size each box
  Size size;
  // Image field for crop later
  Image image;

  PuzzleObject({
    this.empty = false,
    required this.image,
    this.indexCurrent,
    this.indexDefault,
    required this.posCurrent,
    required this.posDefault,
    required this.size,
  });
}
