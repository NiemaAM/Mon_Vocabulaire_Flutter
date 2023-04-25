import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../Model/user.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

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
                        style: const TextStyle(color: Palette.yellow),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Image.asset(
                        'assets/themes_images/coin.png',
                        scale: 25,
                      ),
                    ],
                  )),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: width / 25),
                    child: LinearPercentIndicator(
                      width: width - 110,
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
                        "${widget.user.words_per_level[widget.user.current_level]}/240 mots",
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
                        radius: width / 11,
                        backgroundColor: Palette.blue,
                        child: ClipOval(
                          child: Image.network(
                            widget.user.image,
                            fit: BoxFit.cover,
                            width: width / 4,
                            height: width / 4,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.user.name,
                              style: TextStyle(
                                  color: Palette.white,
                                  fontSize: width / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Niveau ${(widget.user.current_level).toString()} - CE${widget.user.current_level.toString()}",
                              style: TextStyle(
                                  color: Palette.white, fontSize: width / 25),
                            ),
                          ],
                        ),
                      ),
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
