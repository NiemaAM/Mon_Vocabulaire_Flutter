import 'package:flutter/material.dart';
import 'package:mon_vocabulaire/Model/user.dart';
import 'package:mon_vocabulaire/Widgets/levels.dart';

import '../../Widgets/Palette.dart';
import '../Settings/settings_page.dart';

class Profil extends StatefulWidget {
  final User user;
  const Profil({super.key, required this.user});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Profil"),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsPage(
                  user: widget.user,
                ),
              ),
            );
          },
          icon: const Icon(Icons.settings),
          tooltip: "Paramètres",
        ),
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
                  widget.user.image, //TODO: change this to images from gallery
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
              widget.user.name.replaceFirst(widget.user.name.characters.first,
                  widget.user.name.characters.first.toUpperCase()),
              style: TextStyle(fontSize: width / 15),
            ),
          )),
          Levels(
            user: widget.user,
          )
        ],
      ),
    );
  }
}
