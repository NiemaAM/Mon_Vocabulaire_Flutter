// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/large_container.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../Widgets/rounded_button.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.pink,
          title: const Text("Mes Comptes"),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          LargeContainer(
            width: width * 0.9,
            heigth: height * 0.20,
            color: Palette.pink,
            radius: 30,
            name: "Mehdi",
            level: "Niveau 1 - CE1",
            image: "https://cdn-icons-png.flaticon.com/512/3177/3177440.png",
            callback: () {},
          ),
          LargeContainer(
            width: width * 0.9,
            heigth: height * 0.20,
            color: Palette.pink,
            radius: 30,
            name: "Salma",
            level: "Niveau 2 - CE2",
            image: "https://cdn-icons-png.flaticon.com/512/3177/3177440.png",
            callback: () {},
          ),
          RoundedButton(
            width: width * 0.2,
            heigth: height * 0.1,
            color: Palette.yellow,
            radius: 80,
            iconname: Icons.add_rounded,
          )
        ]));
  }
}
