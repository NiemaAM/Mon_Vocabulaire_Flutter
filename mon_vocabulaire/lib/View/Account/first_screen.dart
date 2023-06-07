import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/View/Account/Top5.dart';
import 'package:mon_vocabulaire/View/Account/accounts.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/Palette.dart';

class FirstSceen extends StatefulWidget {
  const FirstSceen({super.key});

  get user => null;

  @override
  State<FirstSceen> createState() => _FirstSceenState();
}

class _FirstSceenState extends State<FirstSceen> {
  List<String> images = ["", ""];
  String background = "";
  Color color = Palette.white;
  Color color2 = Palette.white;
  List<String> titles = ["", ""];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.lightBlue,
      body: Center(
        child: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Image.asset(
                    "assets/images/logo.png",
                    height: 200,
                  ),
                ),
                Column(
                  children: [
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
                          Expanded(flex: 5, child: SizedBox()),
                          Center(
                              child: Text(
                            "JOUER",
                            style: TextStyle(
                                color: Palette.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          )),
                          Expanded(flex: 2, child: SizedBox()),
                          Icon(
                            Icons.menu_book_rounded,
                            color: Palette.indigo,
                          ),
                          Expanded(flex: 2, child: SizedBox())
                        ],
                      ),
                      width: 200,
                      heigth: 65,
                      color: Palette.white,
                    ),
                  ],
                ),
                Center(
                  child: Button(
                    callback: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Top5(),
                        ),
                      );
                    },
                    content: Row(
                      children: const [
                        Expanded(flex: 5, child: SizedBox()),
                        Center(
                            child: Text(
                          "TOP",
                          style: TextStyle(
                              color: Palette.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                        Expanded(flex: 2, child: SizedBox()),
                        Icon(
                          Icons.star_rounded,
                          color: Palette.indigo,
                        ),
                        Expanded(flex: 2, child: SizedBox())
                      ],
                    ),
                    width: 200,
                    heigth: 65,
                    color: Palette.white,
                  ),
                ),
                Center(
                  child: Button(
                    callback: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                    content: Row(
                      children: const [
                        Expanded(flex: 5, child: SizedBox()),
                        Center(
                            child: Text(
                          "SORTIR",
                          style: TextStyle(
                              color: Palette.indigo,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                        Expanded(flex: 2, child: SizedBox()),
                        Icon(
                          Icons.logout,
                          color: Palette.indigo,
                        ),
                        Expanded(flex: 2, child: SizedBox())
                      ],
                    ),
                    width: 200,
                    heigth: 65,
                    color: Palette.white,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "Mon Vocabulaire",
                  style: GoogleFonts.acme(
                    textStyle: const TextStyle(
                      color: Palette.white,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
