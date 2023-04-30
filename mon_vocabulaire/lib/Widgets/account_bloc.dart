import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Model/user.dart';
import 'Palette.dart';
import 'button.dart';

class AccountBloc extends StatefulWidget {
  final User user;
  const AccountBloc({super.key, required this.user});

  @override
  State<AccountBloc> createState() => _AccountBlocState();
}

class _AccountBlocState extends State<AccountBloc> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Button(
        callback: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                user: widget.user,
              ),
            ),
          );
        },
        content: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      Text(
                        widget.user.coins.toString(),
                        style: TextStyle(
                            color: Palette.yellow,
                            fontSize: width > 500 ? 18 : 14),
                      ),
                      SizedBox(
                        width: width > 500 ? 4 : 8,
                      ),
                      Image.asset(
                        'assets/themes_images/coin.png',
                        scale: width > 500 ? 15 : 25,
                      ),
                    ],
                  )),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: width / 25),
                    child: LinearPercentIndicator(
                      width: width > 500 ? width - 130 : width - 110,
                      animation: true,
                      lineHeight: width / 17,
                      animationDuration: 1000,
                      percent: widget.user
                              .words_per_level[widget.user.current_level]! /
                          240,
                      barRadius: const Radius.circular(100),
                      progressColor: Palette.lightGreen,
                      backgroundColor: Palette.lightGrey,
                      center: Text(
                        "${widget.user.words_per_level[widget.user.current_level]} sur 240 mots",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: width > 500 ? width / 9 : width / 11,
                        backgroundColor: Palette.blue,
                        child: ClipOval(
                          child: Image.asset(
                            widget.user.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.user.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Palette.white,
                                  fontSize: width / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Niveau ${(widget.user.current_level).toString()} - ${widget.user.current_level.toString()}AEP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Palette.white, fontSize: width / 25),
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
        color: Palette.pink,
        heigth: width / 2.5,
        width: width - 20,
        radius: 20,
      ),
    );
  }
}
