import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/Appbars/game_app_bar.dart';
import 'package:mon_vocabulaire/Widgets/Popups/game_popup.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../Services/sfx.dart';
import '../../Services/voice.dart';
import '../../Widgets/Palette.dart';
import '../../Widgets/game_card.dart';
import '../../Widgets/message_mascotte.dart';

class FlipCardGame extends StatefulWidget {
  final User user;
  const FlipCardGame({super.key, required this.user});

  @override
  State<FlipCardGame> createState() => _FlipCardGameState();
}

class _FlipCardGameState extends State<FlipCardGame>
    with WidgetsBindingObserver {
  List<int> cards = [];
  bool isFirstFlip = false;
  CardSide cardSide = CardSide.FRONT;
  int countdown = 10;
  int duration = 180;
  late int previousIndex;
  int numFlippedCards = 0;
  int? firstCard;
  int? secondCard;
  bool isGameFinish = false;
  late Timer _timer;
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
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          countdown--;
          if (countdown == 4) {
            Sfx.play("audios/sfx/race_start.mp3", 1);
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

  void endGame() {
    if (duration > 0) {
      _controllerConfetti.play();
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GamePopup(
          onButton1Pressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButton2Pressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FlipCardGame(
                  user: widget.user,
                ),
              ),
            );
          },
          win: duration > 0,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    cards = getRandomCards().toList();
    cardKeys = List.generate(12, (_) => GlobalKey<FlipCardState>());

    _controllerConfetti =
        ConfettiController(duration: const Duration(seconds: 1));

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    Sfx.pause();
    _timer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      Sfx.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Scaffold(
          appBar: CustomAppBarGames(
            user: widget.user,
            background: true,
          ),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: BubbleMessage(
                    widget: countdown > 0
                        ? countdown == 1
                            ? Text(
                                "Souviens-toi de l'emplacement des cartes et trouve toutes les paires ! Il te reste $countdown secondes.",
                                style: const TextStyle(
                                    color: Color(0xFF0E57AC), fontSize: 15),
                              )
                            : Text(
                                "Souviens-toi de l'emplacement des cartes et trouve toutes les paires ! Il te reste $countdown secondes.",
                                style: const TextStyle(
                                    color: Color(0xFF0E57AC), fontSize: 15),
                              )
                        : Text(
                            "C'est parti !",
                            style: const TextStyle(
                                color: Color(0xFF0E57AC), fontSize: 15),
                          )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: width > 500 ? 130 : height / 6,
                    left: width > 500 ? 80 : 0,
                    right: width > 500 ? 80 : 0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(13),
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: width < 500 ? 3 : 3,
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
                                  Voice.play("audios/voices/$cardImage.mp3", 1);
                                });
                              } else {
                                // Flip the selected cards back over after a delay
                                Future.delayed(
                                    const Duration(milliseconds: 1000),
                                    () async {
                                  if (flippedCardList[index] &&
                                      flippedCardList[previousIndex]) {
                                    _flipControllers[index].toggleCard();
                                    _flipControllers[previousIndex]
                                        .toggleCard();
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
        ),
        Padding(
          padding: const EdgeInsets.only(top: 23),
          child: LinearPercentIndicator(
            padding: const EdgeInsets.all(0),
            animation: true,
            lineHeight: 15,
            animationDuration: 0,
            percent: duration / 180,
            barRadius: const Radius.circular(0),
            progressColor: duration >= 120
                ? Palette.lightGreen
                : duration <= 60
                    ? Palette.red
                    : Palette.orange,
            backgroundColor: Palette.indigo,
          ),
        ),
      ],
    );
  }
}
