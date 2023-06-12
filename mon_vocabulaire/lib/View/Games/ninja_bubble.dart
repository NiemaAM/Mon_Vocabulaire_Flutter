// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/db_new.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';

import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/Popups/game_popup.dart';

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
  final User user;
  const NinjaBubble({super.key, required this.user});

  @override
  State<NinjaBubble> createState() => _NinjaBubbleState();
}

class _NinjaBubbleState extends State<NinjaBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Bubble> _bubbles = [];
  final List<FallingImage> _fallingImages = [];

  late double _screenWidth;

  bool selected = false;
  bool _isScreenBlocked = false;
  int duration = 180;
  bool pop = true;

  final List<String> _bubbleImages =
      List.generate(241, (index) => '${index + 1}.png');

  @override
  void initState() {
    super.initState();
    DatabaseHelper().substractCoins(widget.user.id!, 30);
    AudioBK.pauseBK();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        if (!_isScreenBlocked) {
          for (var bubble in _bubbles) {
            bubble.y += bubble.speed;
          }
          for (var image in _fallingImages) {
            image.y += image.speed;
          }
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _screenWidth = MediaQuery.of(context).size.width;

    _createBubbles();
    Timer.periodic(const Duration(seconds: 5), (timer) {
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
          size: rng.nextInt(50) + 100.0,
          speed: rng.nextDouble() * 3.0 + 5.0,
          image: _bubbleImages[240],
        ));
      } else {
        _bubbles.add(Bubble(
          x: rng.nextDouble() * (_screenWidth - 200.0) + 50.0,
          y: -50.0 - rng.nextDouble() * 300.0,
          size: rng.nextInt(50) + 100.0,
          speed: rng.nextDouble() * 3.0 + 5.0,
          image: _bubbleImages[rng.nextInt(_bubbleImages.length)],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AudioBK.pauseBK();

    return Scaffold(
      appBar: CustomAppBarGames(
        user: widget.user,
        background: true,
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
                    if (pop) {
                      String number = bubble.image.split('.').first;
                      if (bubble.image.startsWith("241")) {
                        Sfx.play("audios/sfx/pop.mp3", 1);
                        Voice.play("audios/sfx/boom.mp3", 0.5);
                        endGame();
                        selected = true;
                        pop = false;
                      } else {
                        Sfx.play("audios/sfx/pop.mp3", 1);
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
                    }
                  },
                  child: Container(
                    width: bubble.size,
                    height: bubble.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: 4,
                          color: bubble.image.startsWith('241')
                              ? Palette.red
                              : Palette.lightBlue),
                      color: bubble.image.startsWith('241')
                          ? Palette.red.withOpacity(0.5)
                          : Palette.lightBlue.withOpacity(0.5),
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
                            scale: 1,
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

  int coins = 0;
  Future<void> getCoins() async {
    int _coins = await DatabaseHelper().getCoins(widget.user.id!);
    setState(() {
      coins = _coins;
    });
  }

  Future<void> endGame() async {
    await Future.delayed(const Duration(seconds: 4));
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GamePopup(
          price: 30,
          onButton1Pressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButton2Pressed: () {
            getCoins();
            if (coins >= 30) {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NinjaBubble(
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
          win: false,
          textLose: "Tu as touché la bombe",
          loseImg: "assets/images/mascotte/bomb_explotion.gif",
        );
      },
    );
  }
}
