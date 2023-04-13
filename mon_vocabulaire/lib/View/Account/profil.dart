import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/View/Account/edit_account.dart';
import 'package:mon_vocabulaire/Widgets/levels.dart';

import '../../Widgets/Palette.dart';
import 'accounts.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        backgroundColor: Palette.blue,
        title: const Text("Mon Profil"),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Accounts(),
              ),
            );
          },
          icon: const Icon(Icons.logout),
          tooltip: "Changer de compte",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditAccount(),
                ),
              );
            },
            icon: const Icon(Icons.edit),
            tooltip: "Modifier mon compte",
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: CircleAvatar(
              radius: width / 5,
              backgroundColor: Palette.blue,
              child: ClipOval(
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/3371/3371919.png", //TODO: change this to images from gallery
                  fit: BoxFit.cover,
                  width: width / 2.5,
                  height: width / 2.5,
                ),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              "Salma",
              style: TextStyle(fontSize: width / 15),
            ),
          )),
          const Levels(
            level: 2,
          )
        ],
      ),
    );
  }
}
