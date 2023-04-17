// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Account/create_account.dart';
import 'package:mon_vocabulaire/Widgets/account_bloc.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

import '../../Model/user.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  User user_salam = User(
      id: 1,
      name: "salma",
      image: "https://cdn-icons-png.flaticon.com/512/3371/3371919.png",
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
        1: true,
        2: false,
        3: false,
        4: true,
        5: true,
        6: false,
        7: true,
        8: false,
        9: false,
        10: true,
        11: true,
        12: false,
      });
  User user_mehdi = User(
      id: 2,
      name: "mehdi",
      image: "https://cdn-icons-png.flaticon.com/512/3371/3371822.png",
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
        1: false,
        2: false,
        3: false,
        4: false,
        5: false,
        6: false,
        7: false,
        8: false,
        9: false,
        10: false,
        11: false,
        12: false,
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        elevation: 1,
        title: const Center(child: Text("Mes Comptes")),
      ),
      body: Align(
        alignment: Alignment.center,
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
      floatingActionButton: Button(
        callback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Registration(),
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
                style: TextStyle(color: Colors.white, fontSize: 14),
              )),
            ),
            Icon(
              Icons.add,
              color: Palette.white,
            ),
            Expanded(child: SizedBox())
          ],
        ),
        width: 200,
        heigth: 60,
        color: Palette.blue,
      ),
    );
  }
}
