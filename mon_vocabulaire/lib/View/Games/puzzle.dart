// ignore_for_file: must_be_immutable, unnecessary_null_comparison, cast_from_null_always_fails, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Services/voice.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import '../../../Widgets/Popups/game_popup.dart';
import '../../../Widgets/button.dart';
import 'package:mon_vocabulaire/Services/sfx.dart';
import 'package:image/image.dart' as image;
import 'package:flutter/rendering.dart';

class Puzzle extends StatefulWidget {
  final User user;

  const Puzzle({super.key, required this.user});
  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  GlobalKey<_PuzzleWidgetState> globalKey = GlobalKey();
  String image = "assets/images/logo.png";
  String voice = "audios/voices/1.mp3";
  Timer? _timer;
  int _duration = 0;
  bool viewVisible = true;

  void getIamge() {
    int randomNumber = Random().nextInt(233) + 1;
    setState(() {
      image = "assets/images/pics/$randomNumber.png";
      voice = "audios/voices/$randomNumber.mp3";
    });
  }

  void startTimer() async {
    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any existing timer

    _timer = Timer.periodic(oneSec, (Timer timer) async {
      await Future.delayed(const Duration(milliseconds: 10));
      setState(() {
        _duration++;
      });
    });
  }

  void restartTimer() {
    setState(() {
      _duration = 0;
    });
    startTimer();
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper().substractCoins(widget.user.id!, 10);
    AudioBK.pauseBK();
    getIamge();
    hideWidget();
  }

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   AudioBK.playBK();
  // }

  @override
  Widget build(BuildContext context) {
    AudioBK.pauseBK();
    final minutes = (_duration ~/ 60).toString().padLeft(2, '0');
    final seconds = (_duration % 60).toString().padLeft(2, '0');
    final timerText = '$minutes:$seconds';

    return Scaffold(
        backgroundColor: Palette.white,
        appBar: CustomAppBarGames(
          user: widget.user,
          background: true,
          widgetCenter: Text(
            timerText,
            style: GoogleFonts.acme(
              textStyle: const TextStyle(
                color: Palette.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        body: Stack(children: [
          Center(
              child: ListView(shrinkWrap: true, children: <Widget>[
            SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      const Expanded(flex: 6, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Visibility(
                          maintainAnimation: true,
                          maintainState: true,
                          visible: viewVisible,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.lightBlue,
                                width: 2.0,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue,
                            ),
                            child: Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.all(5),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Image.asset(
                                  image,
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            visible: viewVisible,
                            child: Button(
                              color: Palette.pink,
                              content: const Icon(
                                Icons.volume_up,
                                color: Palette.white,
                                size: 30,
                              ),
                              callback: () {
                                Voice.play(voice, 1);
                              },
                              width: 60,
                              heigth: 60,
                            ),
                          )),
                      const Expanded(
                        flex: 6,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 14, 40, 40),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SizedBox(
                          width: constraints.biggest.width,
                          child: PuzzleWidget(
                            key: globalKey,
                            size: constraints.biggest,
                            imageBackGround: Image.asset(image),
                            sizePuzzle: 3,
                            startTimerCallback: startTimer,
                            restartCallback: restartTimer,
                            stopCallback: stopTimer,
                            showCallback: showWidget,
                            user: widget.user,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ]))
        ]));
  }
}

class PuzzleWidget extends StatefulWidget {
  Size size;
  Function()? startTimerCallback;
  Function()? restartCallback;
  Function()? stopCallback;
  Function()? showCallback;
  double innerPadding;
  final User user;

  Image imageBackGround;
  int sizePuzzle;
  PuzzleWidget({
    super.key,
    required this.size,
    this.innerPadding = 5,
    required this.user,
    required this.imageBackGround,
    required this.sizePuzzle,
    this.startTimerCallback,
    this.restartCallback,
    this.stopCallback,
    this.showCallback,
  });
  @override
  State<PuzzleWidget> createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  final GlobalKey _globalKey = GlobalKey();
  late Size size;
  List<PuzzleObject>? puzzleObjects;
  image.Image? fullimage;
  bool isFirstTime = true;
  bool success = false;
  bool startSlide = false;
  List<int>? process;
  bool finishSwap = false;
  bool isEnd = false;
  bool initialized = false;
  bool timerzero = false;
  bool viewVisible = true;

  @override
  Widget build(BuildContext context) {
    size = Size(widget.size.width - widget.innerPadding * 2,
        widget.size.width - widget.innerPadding);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.lightBlue,
                  width: 3.0,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlue,
            ),
            width: widget.size.width,
            height: widget.size.width,
            padding: EdgeInsets.all(widget.innerPadding),
            child: Stack(children: [
              if (puzzleObjects == null) ...[
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    height: double.maxFinite,
                    padding: const EdgeInsets.all(15),
                    child: widget.imageBackGround,
                  ),
                )
              ],
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
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(2),
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  if (puzzleObject.image != null) ...[
                                    puzzleObject.image
                                  ],
                                  Center(
                                    child: Opacity(
                                      opacity: success ? 0 : 0.5,
                                      child: Text(
                                        "${puzzleObject.indexDefault}",
                                        style: GoogleFonts.acme(
                                          textStyle: const TextStyle(
                                            fontSize: 35,
                                          ),
                                        ),
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
          padding: const EdgeInsets.only(top: 15),
          child: Button(
            content: Row(
              children: [
                const Expanded(flex: 5, child: SizedBox()),
                Center(
                    child: Text(
                  initialized ? "Recommencer" : "Commencer",
                  style: const TextStyle(
                      color: Palette.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
                const Expanded(flex: 2, child: SizedBox()),
                initialized
                    ? const Icon(
                        Icons.restart_alt_outlined,
                        color: Palette.white,
                        size: 25,
                      )
                    : const Icon(
                        Icons.play_arrow_rounded,
                        color: Palette.white,
                        size: 25,
                      ),
                const Expanded(flex: 2, child: SizedBox())
              ],
            ),
            color: Palette.pink,
            callback: () {
              if (initialized) {
                generatePuzzle();

                generatePuzzle();
                widget.restartCallback?.call();
              } else {
                generatePuzzle();
                widget.startTimerCallback?.call();
                initialized = true;
                widget.showCallback?.call();
              }
            },
            width: 200,
            heigth: 65,
          ),
        ),
      ],
    );
  }

  _getImageFromWidget() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    size = boundary.size;
    var img = await boundary.toImage();
    var byteData = await img.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();

    return image.decodeImage(pngBytes!);
  }

  void generatePuzzle() async {
    fullimage ??= await _getImageFromWidget();

    Size sizeBox =
        Size(size.width / widget.sizePuzzle, size.width / widget.sizePuzzle);
    puzzleObjects =
        List.generate(widget.sizePuzzle * widget.sizePuzzle, (index) {
      Offset offsetTemp = Offset(
        index % widget.sizePuzzle * (sizeBox.width),
        index ~/ widget.sizePuzzle * (sizeBox.height),
      );

      image.Image? tempCrop;
      if (fullimage != null) {
        tempCrop = image.copyCrop(
          fullimage!,
          x: offsetTemp.dx.round(),
          y: offsetTemp.dy.round(),
          width: (sizeBox.width).round(),
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

    for (var i = 0; i < widget.sizePuzzle * 20; i++) {
      for (var j = 0; j < widget.sizePuzzle / 2; j++) {
        PuzzleObject puzzleObjectEmpty = getEmptyObject();

        int emptyIndex = puzzleObjectEmpty.indexCurrent!;

        int randKey;
        if (swap) {
          int row = emptyIndex ~/ widget.sizePuzzle;
          randKey =
              row * widget.sizePuzzle + Random().nextInt(widget.sizePuzzle);
        } else {
          int col = emptyIndex % widget.sizePuzzle;
          randKey =
              widget.sizePuzzle * Random().nextInt(widget.sizePuzzle) + col;
        }
        changePosition(randKey);
        swap = !swap;
      }
    }
    if (checkPuzzleComplete()) {
      showEndDialog();
      widget.stopCallback?.call();
    }
  }

  bool checkPuzzleComplete() {
    bool complete = true;
    for (var i = 0; i < puzzleObjects!.length; i++) {
      if (puzzleObjects![i].indexCurrent != i) {
        complete = false;
        break;
      }
    }
    return complete;
  }

  bool dialogShown = false;
  int coins = 0;
  Future<void> getCoins() async {
    int _coins = await DatabaseHelper().getCoins(widget.user.id!);
    setState(() {
      coins = _coins;
    });
  }

  void showEndDialog() {
    if (dialogShown) {
      return;
    }

    dialogShown = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GamePopup(
          price: 10,
          onButton1Pressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButton2Pressed: () {
            getCoins();
            if (coins >= 10) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Puzzle(
                    user: widget.user,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 2),
                backgroundColor: Palette.indigo,
                content: Text(
                  'Tu n\'as pas assez de pièces pour jouer.',
                  style: TextStyle(color: Palette.white, fontSize: 18),
                ),
              ));
            }
          },
        );
      },
    );
  }

  PuzzleObject getEmptyObject() {
    return puzzleObjects!.firstWhere((element) => element.empty);
  }

  changePosition(int indexCurrent) {
    PuzzleObject puzzleObjectEmpty = getEmptyObject();
    int emptyIndex = puzzleObjectEmpty.indexCurrent!;
    int minIndex = min(indexCurrent, emptyIndex);
    int maxIndex = max(indexCurrent, emptyIndex);
    List<PuzzleObject> rangeMoves = [];
    if (indexCurrent % widget.sizePuzzle == emptyIndex % widget.sizePuzzle) {
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
    if (emptyIndex < indexCurrent) {
      rangeMoves.sort((a, b) => a.indexCurrent! < b.indexCurrent! ? 1 : 0);
    } else {
      rangeMoves.sort((a, b) => a.indexCurrent! < b.indexCurrent! ? 0 : 1);
    }
    if (rangeMoves.isNotEmpty) {
      int? tempIndex = rangeMoves[0].indexCurrent;
      Offset tempPos = rangeMoves[0].posCurrent;
      for (var i = 0; i < rangeMoves.length - 1; i++) {
        rangeMoves[i].indexCurrent = rangeMoves[i + 1].indexCurrent;
        rangeMoves[i].posCurrent = rangeMoves[i + 1].posCurrent;
      }
      rangeMoves.last.indexCurrent = puzzleObjectEmpty.indexCurrent;
      rangeMoves.last.posCurrent = puzzleObjectEmpty.posCurrent;

      puzzleObjectEmpty.indexCurrent = tempIndex;
      puzzleObjectEmpty.posCurrent = tempPos;
      if (puzzleObjects![0].indexDefault ==
              puzzleObjects![0].indexCurrent! + 1 &&
          puzzleObjects![1].indexDefault ==
              puzzleObjects![1].indexCurrent! + 1 &&
          puzzleObjects![2].indexDefault ==
              puzzleObjects![2].indexCurrent! + 1 &&
          puzzleObjects![3].indexDefault ==
              puzzleObjects![3].indexCurrent! + 1 &&
          puzzleObjects![4].indexDefault ==
              puzzleObjects![4].indexCurrent! + 1 &&
          puzzleObjects![5].indexDefault ==
              puzzleObjects![5].indexCurrent! + 1 &&
          puzzleObjects![6].indexDefault ==
              puzzleObjects![6].indexCurrent! + 1 &&
          puzzleObjects![7].indexDefault ==
              puzzleObjects![7].indexCurrent! + 1 &&
          puzzleObjects![8].indexDefault ==
              puzzleObjects![8].indexCurrent! + 1 &&
          !finishSwap) {
        success = true;
      } else {
        success = false;
        if (success == true) {
          Sfx.play("audios/sfx/win.mp3", 1);
        }
      }
      startSlide = true;
      setState(() {});
      Future.delayed(const Duration(milliseconds: 5000), () {
        if (checkPuzzleComplete()) {
          showEndDialog();
          widget.stopCallback?.call();
        }
      });
    }
  }
}

class PuzzleObject {
  Offset posDefault;
  Offset posCurrent;
  int? indexDefault;
  int? indexCurrent;
  bool empty;
  Size size;
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
