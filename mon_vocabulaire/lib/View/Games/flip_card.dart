import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Services/audio_background.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../Model/user.dart';
import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/game_card.dart';

class FlipCardGame extends StatefulWidget {
  final User user;
  const FlipCardGame({super.key, required this.user});

  @override
  State<FlipCardGame> createState() => _FlipCardGameState();
}

class _FlipCardGameState extends State<FlipCardGame> {
  List<int> cards = [];
  bool isFirstFlip = false;
  CardSide cardSide = CardSide.FRONT;
  int countdown = 10;
  int duration = 30;
  late int previousIndex;
  int numFlippedCards = 0;
  int? firstCard;
  int? secondCard;
  bool isGameFinish = false;
  final List<bool> flippedCardList = List.generate(12, (index) => false);
  late List<GlobalKey<FlipCardState>> cardKeys;
  final List<FlipCardController> _flipControllers = List.generate(
    12,
    (index) => FlipCardController(),
  );

  late ConfettiController _controllerConfetti;

  List<int> getRandomCards() {
    List<int> cardImage = [];
    while (cardImage.length < 12) {
      int randomNumber = Random().nextInt(233) + 1;
      if (!cardImage.contains(randomNumber)) {
        cardImage.addAll([randomNumber, randomNumber]);
      }
    }
    cardImage.shuffle();
    cardImage.shuffle();
    return cardImage;
  }

  void startTimer() {
    {
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          countdown--;
          if (countdown == 4) {
            Sfx.play("sfx/race_start.mp3", 1);
          }
          if (countdown < 0) {
            duration--;
            if (duration == 0) {
              timer.cancel();
              for (int i = 0; i < flippedCardList.length; i++) {
                // to disable flipOntouch
                flippedCardList[i] = true;
              }
              endGame();
            }
          }
          if (isGameFinish) {
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    cards = getRandomCards().toList();
    cardKeys = List.generate(12, (_) => GlobalKey<FlipCardState>());

    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));

    startTimer();
    AudioBK.pauseBK();
  }

  void endGame() {
    if (duration > 0) {
      _controllerConfetti.play();
      Sfx.play("sfx/win.mp3", 1);
    } else {
      Sfx.play("sfx/lose.mp3", 1);
    }

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
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            duration > 0
                ? "Très bon travail !"
                : "Oh non, le temps est écoulé !",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Palette.pink,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            duration > 0
                ? "Bravo , tu as une bonne mémoire !"
                : "Tu es presque , essaye encore une fois",
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Image.asset(
          duration > 0 ? "assets/mascotte/win.gif" : "assets/mascotte/lose.gif",
          scale: 4,
        ),
      ]),
      btnCancelIcon: Icons.gamepad,
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
            builder: (context) => FlipCardGame(user: widget.user),
          ),
        );
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 14.0,
            animationDuration: 0,
            percent: duration / 30,
            barRadius: const Radius.circular(100),
            progressColor: duration >= 20
                ? Palette.lightGreen
                : duration <= 10
                    ? Palette.red
                    : Palette.orange,
            backgroundColor: Theme.of(context).shadowColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: false,
                      dialogType: DialogType.question,
                      animType: AnimType.rightSlide,
                      title: 'Quitter le quiz',
                      desc: 'Es-tu sûr(e) de vouloir quitter ?',
                      btnCancelText: "Quitter",
                      btnCancelOnPress: () {
                        Navigator.pop(context);
                      },
                      btnOkText: "Rester",
                      btnOkOnPress: () {},
                    ).show();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Palette.red,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, bottom: 20),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                countdown > 0
                    ? countdown == 1
                        ? "$countdown second"
                        : "$countdown seconds"
                    : "Commence !",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(13),
              itemCount: 12,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final cardImage = cards[index];

                return CardWidget(
                  key: cardKeys[index],
                  backImage: '$cardImage',
                  frontImage: 'question-mark',
                  height: width / 4,
                  width: width / 4,
                  cardSide: CardSide.BACK,
                  duration: const Duration(seconds: 10),
                  controller: _flipControllers[index],
                  flipOntouch: countdown > 0
                      ? flippedCardList[index]
                      : numFlippedCards == 2
                          ? false
                          : !flippedCardList[index],
                  onFlip: () async {
                    if (isFirstFlip) {
                      if (numFlippedCards < 2) {
                        // if it's the first flipped card
                        if (firstCard == null) {
                          firstCard = cardImage;
                          previousIndex = index;
                          // if it's the second flipped card
                        } else if (secondCard == null &&
                            index != previousIndex) {
                          secondCard = cardImage;
                          setState(() {
                            numFlippedCards = 2;
                          });
                        }
                        flippedCardList[index] = true;
                        flippedCardList[previousIndex] = true;
                        if (firstCard != null && secondCard != null) {
                          //if there is 2 cards that match
                          if (firstCard == secondCard) {
                            setState(() {
                              firstCard = null;
                              secondCard = null;
                              numFlippedCards = 0;
                              Voice.play("audios/$cardImage.mp3", 1);
                            });
                          } else {
                            print(flippedCardList[index]);
                            // Flip the selected cards back over after a delay
                            Future.delayed(const Duration(milliseconds: 1000),
                                () async {
                              if (flippedCardList[index] &&
                                  flippedCardList[previousIndex]) {
                                _flipControllers[index].toggleCard();
                                _flipControllers[previousIndex].toggleCard();
                                firstCard = null;
                                secondCard = null;
                                flippedCardList[index] = false;
                                flippedCardList[previousIndex] = false;
                                numFlippedCards = 0;
                              }
                            });
                          }
                        }
                        // if all the cards are flipped
                        if (flippedCardList
                            .every((element) => element == true)) {
                          setState(() {
                            isGameFinish = true;
                          });
                        }
                        // if the game is finished
                        if (isGameFinish) {
                          Future.delayed(const Duration(milliseconds: 1300),
                              () async {
                            endGame();
                          });
                        }
                      }
                    }
                  },
                  onFlipDone: (isBACK) {
                    setState(() {
                      isFirstFlip = true;
                    });
                  },
                );
              },
            ),
          ),
          ConfettiWidget(
            gravity: 0,
            confettiController: _controllerConfetti,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            numberOfParticles: 20,
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Palette.lightGreen,
              Palette.blue,
              Palette.pink,
              Palette.orange,
              Palette.purple
            ], // manually specify the colors to be used
          ),
        ],
      ),
    );
  }
}
