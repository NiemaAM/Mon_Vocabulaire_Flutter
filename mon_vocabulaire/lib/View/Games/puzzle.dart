import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as image;
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../../Widgets/button.dart';

class Puzzle extends StatefulWidget {
  const Puzzle({super.key});
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  int valueSlider = 3;

  GlobalKey<_PuzzleWidgetState> globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    double border = 5;
    return Scaffold(
        body: Stack(children: [
      SizedBox(
        height: height,
        child: Image.asset('assets/images/games/backgrounds/forest.jpg',
            alignment: Alignment.center,
            fit: BoxFit.cover,
            color: Palette.white.withOpacity(0.8),
            colorBlendMode: BlendMode.modulate),
      ),
      SafeArea(
          child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 1),
          child: Container(
            margin: EdgeInsets.all(80),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(10),
            //   color: Color.fromARGB(255, 146, 244, 54),
            // ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  width: constraints.biggest.width,
                  child: PuzzleWidget(
                    key: globalKey,
                    size: constraints.biggest,
                    imageBackGround: Image.asset("assets/images/pics/140.png"),
                    // set size puzzle
                    sizePuzzle: valueSlider,
                  ),
                );
              },
            ),
          ),
        ),
      ]))
    ]));
  }
}

class PuzzleWidget extends StatefulWidget {
  Size size;
  GlobalKey _globalKey = GlobalKey();
  // set inner padding
  double innerPadding;
  // set image use for background
  Image imageBackGround;
  int sizePuzzle;
  PuzzleWidget({
    super.key,
    required this.size,
    this.innerPadding = 5,
    required this.imageBackGround,
    required this.sizePuzzle,
  });

  @override
  _PuzzleWidgetState createState() => _PuzzleWidgetState();
}

class _PuzzleWidgetState extends State<PuzzleWidget> {
  GlobalKey _globalKey = GlobalKey();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              if (widget.imageBackGround != null && puzzleObjects == null) ...[
                RepaintBoundary(
                  key: _globalKey,
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Color.fromARGB(255, 98, 230, 151),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // padding: EdgeInsets.all(10),
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
                          margin: EdgeInsets.all(2),
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
                        duration: Duration(milliseconds: 200),
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
                                color: Color.fromARGB(255, 164, 251, 171),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(2),
                              child: Stack(
                                children: [
                                  if (puzzleObject.image != null) ...[
                                    puzzleObject.image as Widget
                                  ], //les nombres
                                  Center(
                                    child: Text(
                                      "${puzzleObject.indexDefault}",
                                      style: const TextStyle(
                                          fontFamily: AutofillHints.birthday,
                                          fontSize: 15),
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
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5, top: height / 30.5),
                child: Button(
                  content: const Icon(
                    Icons.play_arrow_rounded,
                    color: Palette.white,
                    size: 25,
                  ),
                  color: Palette.yellow,
                  callback: () => generatePuzzle(),
                  heigth: 50,
                  width: 50,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 80, top: height / 30.5),
                child: Button(
                  content: const Icon(
                    Icons.clear,
                    color: Palette.white,
                    size: 25,
                  ),
                  color: Palette.yellow,
                  callback: () => clearPuzzle(),
                  width: 50,
                  heigth: 50,
                ),
              ),
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
    if (widget.imageBackGround != null && this.fullimage == null)
      this.fullimage = await _getImageFromWidget();

    print(this.fullimage?.width);

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
      if (widget.imageBackGround != null && this.fullimage != null) {
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
              row * widget.sizePuzzle + new Random().nextInt(widget.sizePuzzle);
        } else {
          int col = emptyIndex % widget.sizePuzzle;
          randKey =
              widget.sizePuzzle * new Random().nextInt(widget.sizePuzzle) + col;
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
    if (rangeMoves.length > 0) {
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
    if (puzzleObjects!
                .where((slideObject) =>
                    slideObject.indexCurrent == slideObject.indexDefault! - 1)
                .length ==
            puzzleObjects!.length &&
        finishSwap) {
      print("Success");
      success = true;
    } else {
      success = false;
    }
    startSlide = true;
    setState(() {});
  }

  clearPuzzle() {
    setState(() {
      // checking already slide for reverse purpose
      puzzleObjects = null;
      // finishSwap = true;
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
