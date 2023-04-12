// ignore_for_file: file_names

import 'package:flutter/material.dart';
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
        title: const Text("Mes Comptes"),
      ),
      body: const Center(
        child: Text("Accounts"),
      ),
      floatingActionButton: Button(
        callback: () {},
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
        color: Colors.blue,
      ),
    );
  }
}
