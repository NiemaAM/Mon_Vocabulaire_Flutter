import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'Palette.dart';
import 'button.dart';

class AccountBloc extends StatefulWidget {
  final String avatar;
  final int coins;
  final String level;
  final String nom;
  const AccountBloc(
      {super.key,
      required this.avatar,
      required this.coins,
      required this.level,
      required this.nom});

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
              builder: (context) => const Home(), //TODO: Add account id
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
                        widget.coins.toString(),
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
                    padding: EdgeInsets.only(bottom: width / 25, left: 12),
                    child: LinearPercentIndicator(
                      width: width - 120,
                      animation: true,
                      lineHeight: 25.0,
                      animationDuration: 1000,
                      percent: 0.7,
                      barRadius: const Radius.circular(100),
                      progressColor: Palette.lightGreen,
                      backgroundColor: Palette.lightGrey,
                      center: const Text(
                        "150/240 mots",
                        style: TextStyle(
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
                            widget.avatar,
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
                              widget.nom,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: width / 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.level,
                              style: TextStyle(
                                  color: Colors.black, fontSize: width / 25),
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
        color: Palette.white,
        heigth: width / 2.5,
        width: width - 20,
        radius: 20,
      ),
    );
  }
}
