import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';

import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/Palette.dart';

//Bubble Class
class Bubble {
  double x;
  double y;
  double size;
  double speed;
  String image;

  Bubble(
      {required this.x,
      required this.y,
      required this.size,
      required this.speed,
      required this.image});
}

//Image Class
class FallingImage {
  double x;
  double y;
  double size;
  double speed;
  String image;

  FallingImage(
      {required this.x,
      required this.y,
      required this.size,
      required this.speed,
      required this.image});
}

class NinjaBubble extends StatefulWidget {
  const NinjaBubble({super.key});

  @override
  State<NinjaBubble> createState() => _NinjaBubbleState();
}

class _NinjaBubbleState extends State<NinjaBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Bubble> _bubbles = [];
  List<FallingImage> _fallingImages = [];

  late double _screenWidth;

  bool selected = false;
  bool _isScreenBlocked = false;
  int duration = 180;

  List<String> _bubbleImages =
      List.generate(241, (index) => '${index + 1}.png');

  @override
  void initState() {
    super.initState();
    AudioBK.pauseBK();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        if (!_isScreenBlocked) {
          _bubbles.forEach((bubble) {
            bubble.y += bubble.speed;
          });
          _fallingImages.forEach((image) {
            image.y += image.speed;
          });
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _screenWidth = MediaQuery.of(context).size.width;

    _createBubbles();
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _createBubbles();
      });
    });
  }

  var num = 0;

  void _createBubbles() {
    var rng = Random();
    for (var i = 0; i < 2; i++) {
      num++;
      if (num % 10 == 0) {
        _bubbles.add(Bubble(
          x: rng.nextDouble() * (_screenWidth - 200.0) + 50.0,
          y: -50.0 - rng.nextDouble() * 300.0,
          size: rng.nextDouble() * 100.0 + 50.0,
          speed: rng.nextDouble() * 3.0 + 2.0,
          image: _bubbleImages[240],
        ));
      } else {
        _bubbles.add(Bubble(
          x: rng.nextDouble() * (_screenWidth - 200.0) + 50.0,
          y: -50.0 - rng.nextDouble() * 300.0,
          size: rng.nextDouble() * 100.0 + 50.0,
          speed: rng.nextDouble() * 3.0 + 2.0,
          image: _bubbleImages[rng.nextInt(_bubbleImages.length)],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AudioBK.pauseBK();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Palette.black),
        title: Row(
          children: [
            Image.asset(
              "assets/images/games/bubbles.png",
              width: 40,
            ),
            const Text(
              "  Ninja Bubble",
              style: TextStyle(color: Palette.black),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade200],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ..._bubbles.map((bubble) {
            return Positioned(
              left: bubble.x,
              top: bubble.y,
              child: Transform.rotate(
                angle: Random().nextDouble() * 2 * pi,
                child: GestureDetector(
                  onTap: () {
                    String number = bubble.image.split('.').first;
                    if (bubble.image.startsWith("241")) {
                      Sfx.play("audios/sfx/bubble-pop.mp3", 2);
                      Voice.play("audios/sfx/boom.mp3", 1);
                      endGame();
                      selected = true;
                    } else {
                      Sfx.play("audios/sfx/bubble-pop.mp3", 1);
                      Voice.play("audios/voices/$number.mp3", 1);
                    }
                    setState(() {
                      // Remove bubble
                      _bubbles.remove(bubble);
                      // Add falling image
                      _fallingImages.add(
                        FallingImage(
                            x: bubble.x,
                            y: bubble.y,
                            size: bubble.size,
                            speed: bubble.speed,
                            image: bubble.image),
                      );
                      if (bubble.image.startsWith('241')) {
                        _isScreenBlocked = true;
                        if (_isScreenBlocked) {
                          _controller.stop();
                        } else {
                          _controller.repeat();
                        }
                      }
                    });
                  },
                  child: Container(
                    width: bubble.size,
                    height: bubble.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          ..._fallingImages.map((image) {
            return Positioned(
                left: image.image.startsWith('241') ? null : image.x,
                top: image.image.startsWith('241') ? null : image.y,
                child: image.image.startsWith('241')
                    ? Center(
                        child: AnimatedContainer(
                          width: selected ? 800.0 : 100.0,
                          height: selected ? 800.0 : 100.0,
                          duration: const Duration(seconds: 3),
                          alignment: Alignment.center,
                          curve: Curves.fastOutSlowIn,
                          child: Image.asset(
                            'assets/images/mascotte/bomb_explotion.gif',
                            gaplessPlayback: true,
                            scale: 0.1,
                          ),
                        ),
                      )
                    : Image.asset(
                        'assets/images/pics/${image.image}',
                        width: image.size,
                        height: image.size,
                      ));
          }).toList(),
        ],
      ),
    );
  }

  Future<void> endGame() async {
    await Future.delayed(const Duration(seconds: 4));
    Sfx.play("audios/sfx/lose.mp3", 1);
    AwesomeDialog(
      context: context,
      headerAnimationLoop: false,
      customHeader: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
            color: Palette.red,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Icon(
          Icons.timer,
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
            "Oh non, tu as touché la bombe !",
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
            "Tu y étais presque, essaye encore une fois",
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Image.asset(
          "assets/images/mascotte/bomb_explotion.gif",
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
            builder: (context) => const NinjaBubble(),
          ),
        );
      },
    ).show();
  }
}
