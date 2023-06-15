import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Controller/realtime_data_controller.dart';
import 'package:mon_vocabulaire/Model/user_models.dart';
import 'package:mon_vocabulaire/Services/animation_route.dart';
import 'package:mon_vocabulaire/View/Home/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'Palette.dart';
import 'button.dart';

class AccountBloc extends StatefulWidget {
  final User user;
  const AccountBloc({super.key, required this.user});

  @override
  State<AccountBloc> createState() => _AccountBlocState();
}

class _AccountBlocState extends State<AccountBloc> {
  int _words = 0;
  RealtimeDataController controller = RealtimeDataController();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  calculateResult() async {
    await controller.getAllWords(widget.user.id!);
    int? totalWords = controller.words;
    setState(() {
      _words = totalWords!;
    });
  }

  @override
  void initState() {
    super.initState();
    calculateResult();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Button(
        callback: () {
          Navigator.of(context).pushReplacement(
            SlideButtom(
              page: Home(
                user: widget.user,
              ),
            ),
          );
        },
        content: Padding(
          padding:
              const EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 5),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Text(
                        widget.user.coins < 999
                            ? "${widget.user.coins.toString()} "
                            : "999 ",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 241, 158, 4),
                            fontSize: width > 500 ? 18 : 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset(
                        'assets/images/themes/coin.png',
                        scale: width > 500 ? 15 : 25,
                      ),
                    ],
                  )),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: width / 29),
                    child: LinearPercentIndicator(
                      width: width > 500 ? width - 130 : width - 110,
                      animation: true,
                      lineHeight: width / 15,
                      animationDuration: 1000,
                      percent: _words / 240,
                      barRadius: const Radius.circular(100),
                      progressColor: Palette.lightGreen,
                      backgroundColor: Palette.lightGrey,
                      center: Text(
                        "$_words sur 240 mots",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: width > 500 ? width / 9 : width / 9.5,
                          backgroundColor: Palette.lightBlue,
                          child: ClipOval(
                              child: widget.user.image.startsWith("assets")
                                  ? Image.asset(
                                      widget.user.image,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(widget.user.image),
                                      fit: BoxFit.cover,
                                      width: width / 2.5,
                                      height: width / 2.5,
                                    )),
                        ),
                      ),
                      const Expanded(flex: 2, child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.user.name.replaceFirst(
                                widget.user.name.characters.first,
                                widget.user.name.characters.first.toUpperCase(),
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Palette.indigo,
                                  fontSize: width / 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Niveau ${(widget.user.currentLevel).toString()} - ${widget.user.currentLevel.toString()}AEP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Palette.indigo, fontSize: width / 25),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        color: Palette.white,
        heigth: width / 2.5,
        width: width - 20,
        radius: 20,
      ),
    );
  }
}
