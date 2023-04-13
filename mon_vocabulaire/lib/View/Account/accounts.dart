// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Account/create_account.dart';
import 'package:mon_vocabulaire/Widgets/account_bloc.dart';
import 'package:mon_vocabulaire/Widgets/button.dart';
import 'package:mon_vocabulaire/Widgets/palette.dart';

class Accounts extends StatefulWidget {
  const Accounts({super.key});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.blue,
        elevation: 1,
        title: const Center(child: Text("Mes Comptes")),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView(
            shrinkWrap: true,
            children: const [
              AccountBloc(
                avatar:
                    "https://cdn-icons-png.flaticon.com/512/3371/3371919.png",
                coins: 20,
                level: 'Niveau 1 - CE1',
                nom: 'Salma',
              ),
              AccountBloc(
                avatar:
                    "https://cdn-icons-png.flaticon.com/512/3371/3371822.png",
                coins: 120,
                level: 'Niveau 2 - CE2',
                nom: 'Mehdi',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Button(
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
        color: Palette.pink,
      ),
    );
  }
}
