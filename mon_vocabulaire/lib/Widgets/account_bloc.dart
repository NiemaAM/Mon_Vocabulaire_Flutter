import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/home.dart';

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
              Row(
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Palette.blue,
                    child: ClipOval(
                      child: Image.network(
                        widget.avatar,
                        fit: BoxFit.cover,
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.nom,
                          style: const TextStyle(
                              color: Palette.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.level,
                          style: const TextStyle(
                              color: Palette.white, fontSize: 18),
                        ),
                      ],
                    ),
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
