import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';

import 'Account/accounts.dart';
import 'Account/create_account.dart';
import '../Widgets/Palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import 'package:mon_vocabulaire/Widgets/bubble.dart';
import '../../../Model/user.dart';
import '../../../Services/sfx.dart';
import '../../../Widgets/message_mascotte.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<Acceuil> createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {
  double _opacity = 0;

  List<String> images = ["", ""];
  String background = "";
  Color color = Palette.blue;
  Color color2 = Palette.blue;
  List<String> titles = ["", ""];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/logo_ministere.png',
              alignment: Alignment.topLeft,
              fit: BoxFit.fill,
              color: Palette.white.withOpacity(0.65),
              colorBlendMode: BlendMode.modulate),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 70,
                  child: SizedBox(),
                ),
                Button(
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateAccount(),
                      ),
                    );
                  },
                  content: Row(
                    children: const [
                      Expanded(
                        flex: 20,
                        child: Center(
                            child: Text(
                          "Ajouter un compte",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        )),
                      ),
                      Icon(
                        Icons.add,
                        color: Palette.white,
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  width: 255,
                  heigth: 65,
                  color: Palette.blue,
                ),
                const Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
                Button(
                  callback: () {},
                  content: Row(
                    children: const [
                      Expanded(
                        flex: 20,
                        child: Center(
                            child: Text(
                          "Se connecter",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      Icon(
                        Icons.login,
                        color: Palette.white,
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  width: 255,
                  heigth: 65,
                  color: Palette.blue,
                ),
                const Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
                Button(
                  callback: () {},
                  content: Row(
                    children: const [
                      Expanded(
                        flex: 50,
                        child: Center(
                            child: Text(
                          "Top 5",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  width: 255,
                  heigth: 65,
                  color: Palette.blue,
                ),
                const Expanded(
                  flex: 5,
                  child: SizedBox(),
                ),
                Button(
                  callback: () {},
                  content: Row(
                    children: const [
                      Expanded(
                        flex: 50,
                        child: Center(
                            child: Text(
                          "Quitter",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      Icon(
                        Icons.logout,
                        color: Palette.white,
                      ),
                      Expanded(child: SizedBox())
                    ],
                  ),
                  width: 255,
                  heigth: 65,
                  color: Palette.blue,
                ),
                const Expanded(
                  flex: 10,
                  child: SizedBox(),
                ),
                const BubbleMessage(
                  message: "Bienvenu sur Mon vocabulaire !! "
                      " je suis Bubble,et je vais t'aider a améliorer ton vocabulaire.",
                ),
                const Expanded(
                  flex: 20,
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
