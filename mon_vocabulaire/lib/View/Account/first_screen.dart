import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mon_vocabulaire/View/Account/accounts.dart';
import 'package:mon_vocabulaire/View/Account/create_account.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';
import '../../../Widgets/message_mascotte.dart';

class FirstSceen extends StatefulWidget {
  const FirstSceen({super.key});

  @override
  State<FirstSceen> createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
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
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset('assets/images/logo_ministere.png',
                alignment: Alignment.topLeft,
                fit: BoxFit.fill,
                colorBlendMode: BlendMode.modulate),
          ),
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
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Accounts(),
                      ),
                    );
                  },
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
                  callback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Accounts(),
                      ),
                    );
                  },
                  content: Row(
                    children: const [
                      Expanded(
                        flex: 50,
                        child: Center(
                            child: Text(
                          "Top joueurs",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                      Icon(
                        Icons.star_rounded,
                        color: Palette.white,
                      ),
                      Expanded(
                        child: SizedBox(),
                      )
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
                  callback: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
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
                  message: "Bienvenu sur Mon vocabulaire !"
                      " je suis Bubble, et je vais t'aider a améliorer ton vocabulaire.",
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
