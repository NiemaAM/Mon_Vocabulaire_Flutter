// ignore_for_file: file_names, equal_keys_in_map

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mon_vocabulaire/View/Account/create_account.dart';
import 'package:mon_vocabulaire/Widgets/account_bloc.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../../Model/user.dart';
import '../../Services/animation_route.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  User user_salam = User(
      id: 1,
      name: "salma",
      image: "assets/avatars/avatar_girl.png",
      current_level: 1,
      words_per_level: {1: 120},
      coins: 20,
      words_per_subtheme: {
        1: 65,
        2: 25,
        3: 40,
        4: 28,
        5: 33,
        6: 50,
        7: 65,
        8: 25,
        9: 40,
        10: 28,
        11: 33,
        12: 50,
      },
      stars_per_subtheme: {
        1: 1,
        2: 2,
        3: 2,
        4: 1,
        5: 1,
        6: 2,
        7: 1,
        8: 2,
        9: 2,
        10: 1,
        11: 0,
        12: 2,
      },
      status_per_Subtheme: {
        1: {1: true},
        1: {2: true},
        1: {3: false},
        1: {4: false},
        1: {5: false},
        2: {1: true},
        2: {2: true},
        2: {3: false},
        2: {4: false},
        2: {5: false},
        3: {1: true},
        3: {2: true},
        3: {3: false},
        3: {4: false},
        3: {5: false},
        4: {1: true},
        4: {2: true},
        4: {3: true},
        4: {4: true},
        4: {5: true},
        5: {1: true},
        5: {2: true},
        5: {3: false},
        5: {4: false},
        5: {5: false},
        6: {1: true},
        6: {2: true},
        6: {3: false},
        6: {4: false},
        6: {5: false},
        7: {1: true},
        7: {2: true},
        7: {3: false},
        7: {4: false},
        7: {5: false},
        8: {1: true},
        8: {2: true},
        8: {3: false},
        8: {4: false},
        8: {5: false},
        9: {1: true},
        9: {2: true},
        9: {3: false},
        9: {4: false},
        9: {5: false},
        10: {1: true},
        10: {2: true},
        10: {3: false},
        10: {4: false},
        10: {5: false},
        11: {1: true},
        11: {2: true},
        11: {3: false},
        11: {4: false},
        11: {5: false},
        12: {1: true},
        12: {2: true},
        12: {3: false},
        12: {4: false},
        12: {5: false},
      });
  User user_mehdi = User(
      id: 2,
      name: "mehdi",
      image: "assets/avatars/avatar_boy.png",
      current_level: 2,
      words_per_level: {1: 40, 2: 200},
      coins: 120,
      words_per_subtheme: {
        1: 15,
        2: 5,
        3: 25,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
        9: 0,
        10: 0,
        11: 0,
        12: 0,
      },
      stars_per_subtheme: {
        1: 1,
        2: 1,
        3: 1,
        4: 1,
        5: 1,
        6: 1,
        7: 1,
        8: 1,
        9: 1,
        10: 1,
        11: 1,
        12: 1,
      },
      status_per_Subtheme: {
        1: {1: true},
        1: {2: true},
        1: {3: true},
        1: {4: true},
        1: {5: true},
        2: {1: true},
        2: {2: true},
        2: {3: true},
        2: {4: true},
        2: {5: true},
        3: {1: true},
        3: {2: true},
        3: {3: true},
        3: {4: false},
        3: {5: false},
        4: {1: true},
        4: {2: true},
        4: {3: true},
        4: {4: true},
        4: {5: true},
        5: {1: true},
        5: {2: true},
        5: {3: false},
        5: {4: false},
        5: {5: false},
        6: {1: true},
        6: {2: true},
        6: {3: false},
        6: {4: false},
        6: {5: false},
        7: {1: true},
        7: {2: true},
        7: {3: false},
        7: {4: false},
        7: {5: false},
        8: {1: true},
        8: {2: true},
        8: {3: false},
        8: {4: false},
        8: {5: false},
        9: {1: true},
        9: {2: true},
        9: {3: false},
        9: {4: false},
        9: {5: false},
        10: {1: true},
        10: {2: true},
        10: {3: false},
        10: {4: false},
        10: {5: false},
        11: {1: true},
        11: {2: true},
        11: {3: false},
        11: {4: false},
        11: {5: false},
        12: {1: true},
        12: {2: true},
        12: {3: false},
        12: {4: false},
        12: {5: false},
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.lightBlue,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Image.asset(
                "assets/images/logo.png",
                height: 200,
              ),
            ),
          ),
          Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                AccountBloc(
                  user: user_salam,
                ),
                AccountBloc(
                  user: user_mehdi,
                ),
              ],
            ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: Button(
          callback: () {
            Navigator.of(context).push(
              SlideButtom(page: const CreateAccount()),
            );
          },
          content: Row(
            children: const [
              Expanded(
                flex: 20,
                child: Center(
                    child: Text(
                  "AJOUTER",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
              Icon(
                Icons.add_rounded,
                color: Palette.white,
              ),
              Expanded(
                flex: 2,
                child: SizedBox(),
              )
            ],
          ),
          width: 170,
          heigth: 60,
          color: Palette.pink,
        ),
      ),
    );
  }
}
